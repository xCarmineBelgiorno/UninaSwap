// server.js
const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');
const path = require('path');
const app = express();
app.use(bodyParser.json({limit:'50mb'}));

// percorso robusto relativo alla posizione corrente del server
const WEBAPP_DIR = path.join(__dirname, '..', '..', 'src', 'main', 'webapp');

console.log('WEBAPP_DIR =', WEBAPP_DIR);
try { console.log('sample files in WEBAPP_DIR:', fs.readdirSync(WEBAPP_DIR).slice(0,50)); }
catch(err) { console.log('read dir error (startup):', err.message); }

// funzione di escape regex per le chiavi
function escapeForRegex(s) {
  return s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

// lista ricorsiva di .jsp (ritorna percorsi relativi)
function listJspFiles(dir) {
  const res = [];
  function walk(d) {
    try {
      const items = fs.readdirSync(d, { withFileTypes: true });
      for (const it of items) {
        const full = path.join(d, it.name);
        if (it.isDirectory()) walk(full);
        else if (it.isFile() && it.name.endsWith('.jsp')) {
          res.push(path.relative(WEBAPP_DIR, full).replace(/\\/g, '/'));
        }
      }
    } catch(e) {}
  }
  walk(dir);
  return res;
}

// =======================
// INLINE STATIC INCLUDES
// =======================
function inlineIncludes(content, currentDir, depth = 0) {
  if (depth > 10) return content;

  // <%@ include file="..." %>
  content = content.replace(/<%@\s*include\s+file="([^"]+)"\s*%>/g, (m, incPath) => {
    try {
      const resolved = incPath.startsWith('/') ? path.join(WEBAPP_DIR, incPath) : path.join(currentDir, incPath);
      if (!fs.existsSync(resolved)) return m;
      let incRaw = fs.readFileSync(resolved, 'utf8');
      incRaw = inlineIncludes(incRaw, path.dirname(resolved), depth+1);
      return incRaw;
    } catch(e) {
      return m;
    }
  });

  // <jsp:include page="...jsp" .../>
  content = content.replace(/<jsp:include\b[^>]*page="([^"]+)"[^>]*>(?:<\/jsp:include>)?/g, (m, incPath) => {
    if (/\$\{|\<%/.test(incPath)) return m;
    try {
      const resolved = incPath.startsWith('/') ? path.join(WEBAPP_DIR, incPath) : path.join(currentDir, incPath);
      if (!fs.existsSync(resolved)) return m;
      let incRaw = fs.readFileSync(resolved, 'utf8');
      incRaw = inlineIncludes(incRaw, path.dirname(resolved), depth+1);
      return incRaw;
    } catch(e) {
      return m;
    }
  });

  return content;
}

// =======================
// Placeholder extraction & restore (migliorata)
// =======================
function extractPlaceholders(content) {
  let mapping = {}, idx = 0;

  // 1) scriptlet blocks <% ... %> e directive <%@ ... %>
  content = content.replace(/(<%[\s\S]*?%>)/g, (m) => {
    const key = `__JSP_PLACEHOLDER_${idx++}__`;
    mapping[key] = m;
    return key;
  });

  // 2) taglib blocks like <c:forEach ...>...</c:forEach>
  content = content.replace(/(<[a-zA-Z0-9]+:[^>]*>[\s\S]*?<\/[a-zA-Z0-9]+:[^>]*>)/g, (m) => {
    const key = `__JSP_PLACEHOLDER_${idx++}__`;
    mapping[key] = m;
    return key;
  });

  // 3) self-closing taglib like <c:out ... />
  content = content.replace(/(<[a-zA-Z0-9]+:[^>]*\/>)/g, (m) => {
    const key = `__JSP_PLACEHOLDER_${idx++}__`;
    mapping[key] = m;
    return key;
  });

  return {content, mapping};
}

// restore: accetta contenuto che può contenere i placeholder come testo,
// oppure come commenti HTML <!--KEY--> oppure come span con data-placeholder.
function restorePlaceholders(content, mapping) {
  for (let k of Object.keys(mapping)) {
    const esc = escapeForRegex(k);
    // 1) comment form <!--KEY-->
    content = content.replace(new RegExp('<!--\\s*' + esc + '\\s*-->', 'g'), mapping[k]);
    // 2) span form <span data-jsp="KEY">...</span> o <span data-placeholder="KEY">...</span>
    content = content.replace(new RegExp('<span[^>]+(?:data-jsp|data-placeholder)=[\\\'\\"]' + esc + '[\\\'\\"][^>]*>[\\s\\S]*?<\\/span>', 'g'), mapping[k]);
    // 3) raw key text fallback
    content = content.replace(new RegExp(esc, 'g'), mapping[k]);
  }
  return content;
}

// Produce una versione "visuale" del contenuto: sostituisce ogni KEY con un commento invisibile
function makeVisualContent(content, mapping) {
  // mapping keys like __JSP_PLACEHOLDER_0__
  for (let k of Object.keys(mapping)) {
    const esc = escapeForRegex(k);
    // sostituisci ogni occorrenza con un commento visibile solo nell'HTML ma invisibile nella preview
    content = content.replace(new RegExp(esc, 'g'), `<!--${k}-->`);
  }
  return content;
}

// Serve static assets of the webapp under /app
app.use('/app', express.static(WEBAPP_DIR));

// Endpoint assets: lista CSS e immagini rilevate nella webapp
app.get('/assets/list', (req, res) => {
  const cssDir = path.join(WEBAPP_DIR, 'Css');
  const imgDir = path.join(WEBAPP_DIR, 'images');

  const css = [];
  const imgs = [];

  try {
    if (fs.existsSync(cssDir)) {
      fs.readdirSync(cssDir).forEach(f => {
        if (f.toLowerCase().endsWith('.css')) css.push('/app/Css/' + f);
      });
    }
  } catch(e){}

  function walkImages(dir, relPrefix='') {
    if (!fs.existsSync(dir)) return;
    fs.readdirSync(dir, { withFileTypes: true }).forEach(it => {
      const full = path.join(dir, it.name);
      if (it.isDirectory()) walkImages(full, relPrefix + it.name + '/');
      else if (it.isFile()) imgs.push('/app/images/' + relPrefix + it.name);
    });
  }
  try {
    walkImages(imgDir, '');
  } catch(e){}

  res.json({ css, imgs });
});

// Lista JSP (relative)
app.get('/list', (req,res)=>{
  try {
    const files = listJspFiles(WEBAPP_DIR);
    res.json({files});
  } catch(e) {
    res.status(500).json({error: String(e)});
  }
});

// Carica un file JSP (inline includes statici, poi estrazione placeholder, e costruzione contenuto "visuale")
app.get('/load', (req,res)=>{
  const file = req.query.file;
  if (!file) return res.status(400).json({error:'file missing'});
  const safe = file.replace(/\.\./g, ''); // semplice sanificazione
  const fp = path.join(WEBAPP_DIR, safe);
  if (!fs.existsSync(fp)) return res.status(404).json({error:'not found', path: fp});
  let raw = fs.readFileSync(fp,'utf8');

  // inline includes statici (porta anche i <link> e altri elementi da navbar/footer)
  try {
    raw = inlineIncludes(raw, path.dirname(fp), 0);
  } catch(e) {
    console.warn('inlineIncludes failed for', fp, e.message);
  }

  const extracted = extractPlaceholders(raw);
  const visual = makeVisualContent(extracted.content, extracted.mapping);

  // rispondi con entrambe le versioni:
  // - contentVisual: quello che useremo per la preview (placeholder invisibili)
  // - rawWithPlaceholders: versione originale con placeholder come testo (utile se vuoi mostrare i placeholder)
  res.json({ok:true, contentVisual: visual, contentRaw: extracted.content, mapping: extracted.mapping});
});

// Salva (backup automatico). Il client deve inviare la versione modificata (in cui i placeholder sono comment/span)
// quindi qui ripristiniamo i placeholder reali prima di scrivere sul file.
app.post('/save', (req,res)=>{
  try {
    const {file, content, mapping} = req.body;
    if (!file) return res.status(400).json({error:'missing file'});
    const safe = file.replace(/\.\./g, '');
    const fp = path.join(WEBAPP_DIR, safe);
    if (!fs.existsSync(fp)) return res.status(404).json({error:'not found'});
    const bak = fp + '.bak-' + Date.now();
    fs.copyFileSync(fp, bak);

    // restore placeholders from la versione inviata
    const restored = restorePlaceholders(content, mapping || {});
    fs.writeFileSync(fp, restored, 'utf8');
    return res.json({ok:true, backup: path.basename(bak)});
  } catch(e) {
    console.error(e);
    return res.status(500).json({ok:false, error:String(e)});
  }
});

// serve editor static
app.use('/', express.static(path.join(__dirname, 'static')));
const PORT = 3001;
app.listen(PORT, ()=>console.log('editor running on http://localhost:' + PORT + '/editor.html'));
