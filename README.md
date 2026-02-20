# UninaSwap 🎓
Progetto di OO e BDD

**Piattaforma di Scambio Universitario** - Un'applicazione web per studenti universitari che permette di scambiare, vendere o regalare oggetti tra utenti dell'ateneo.

## 🚀 Caratteristiche Principali

### ✅ Funzionalità Core
- **Registrazione e Autenticazione** - Sistema di login sicuro con username/password
- **Gestione Annunci** - Pubblicazione di annunci di vendita, scambio o regalo
- **Sistema di Offerte** - Invio di offerte corrispondenti agli annunci
- **Gestione Transazioni** - Completamento sicuro degli scambi
- **Sistema di Recensioni** - Valutazioni post-transazione
- **Report e Statistiche** - Grafici con JFreeChart per analisi dati

### 🎯 Tipi di Annunci
- **Vendita** - Prezzo fisso in Euro
- **Scambio** - Richiesta di oggetti specifici in cambio
- **Regalo** - Distribuzione gratuita con eventuali condizioni

### 🖼️ Gestione Immagini
- Upload multiplo di immagini per annunci
- Drag & drop support
- Preview in tempo reale
- Validazione formato e dimensione

### 🔍 Ricerca e Filtri
- Filtro per categoria
- Filtro per tipo di annuncio
- Ricerca full-text
- Paginazione risultati

## 🛠️ Tecnologie Utilizzate

### Backend
- **Java 8** - Linguaggio principale
- **Servlets** - Gestione richieste HTTP
- **JSP** - Template engine
- **Maven** - Gestione dipendenze e build

### Database
- **PostgreSQL** - Database principale
- **SQLite** - Database di sviluppo
- **Trigger e Procedure** - Logica di business lato DB

### Frontend
- **Bootstrap 4** - Framework CSS
- **JavaScript ES6** - Interattività client-side
- **JFreeChart** - Grafici e statistiche
- **Responsive Design** - Compatibilità mobile

<<<<<<< HEAD
=======

>>>>>>> 3f4da7f (Update README.md)
## 📋 Requisiti di Sistema

- **Java**: JDK 8 o superiore
- **Database**: PostgreSQL 12+ o SQLite 3
- **Server**: Apache Tomcat 9+ o Jetty 9+
- **Browser**: Chrome, Firefox, Safari, Edge (versione moderna)

## 🚀 Installazione e Setup

### 1. Clona il Repository
```bash
git clone https://github.com/xCarmineBelgiorno/uninaswap.git
cd uninaswap
```

### 2. Configura il Database
```bash
# Per PostgreSQL
psql -U postgres -d postgres -f src/main/resources/uninaswap_schema.sql

# Per SQLite (sviluppo)
sqlite3 uninaswap.db < src/main/resources/uninaswap_schema.sql
```

### 3. Configura la Connessione Database
Modifica `src/main/java/com/conn/DBConnect.java` con i tuoi parametri di connessione.

### 4. Build e Deploy
```bash
# Compila il progetto
mvn clean compile

# Avvia con Jetty (sviluppo)
mvn jetty:run

# Crea WAR per deployment
mvn package
```

### 5. Accedi all'Applicazione
- **URL**: http://localhost:8082
- **Porta predefinita**: 8082 (configurabile in pom.xml)

## 🗄️ Schema Database

### Tabelle Principali
- **users** - Utenti registrati
- **categories** - Categorie di oggetti
- **ads** - Annunci (tabella padre)
- **sale_ads** - Annunci di vendita
- **exchange_ads** - Annunci di scambio
- **gift_ads** - Annunci regalo
- **offers** - Offerte (tabella padre)
- **transactions** - Transazioni completate
- **reviews** - Recensioni post-transazione

### Relazioni Chiave
- Un utente può avere più annunci
- Un annuncio può ricevere più offerte
- Un'offerta accettata genera una transazione
- Le transazioni possono avere recensioni

<<<<<<< HEAD
=======


>>>>>>> 3f4da7f (Update README.md)
## 📊 Report e Statistiche

### Grafici Disponibili
- Numero totale di offerte per tipo
- Tasso di accettazione offerte
- Valore medio/min/max per vendite
- Statistiche utente (annunci, transazioni)

### Tecnologia Grafici
- **JFreeChart** per generazione grafici
- **Chart.js** per visualizzazione interattiva
- Export in formato PNG/PDF

## 🧪 Testing

### Test Unitari
```bash
mvn test
```

### Test di Integrazione
```bash
mvn verify
```

### Test Manuali
- Registrazione nuovo utente
- Creazione annuncio
- Invio offerta
- Accettazione offerta
- Completamento transazione

## 📝 API Endpoints

### Autenticazione
- `POST /registeruser` - Registrazione utente
- `POST /login` - Login utente
- `POST /logout` - Logout utente

### Annunci
- `GET /ads` - Lista annunci con filtri
- `POST /ads` - Creazione nuovo annuncio
- `GET /ads/{slug}` - Dettagli annuncio
- `PUT /ads/{id}` - Modifica annuncio
- `DELETE /ads/{id}` - Eliminazione annuncio

### Offerte
- `POST /ads/{id}/offers` - Invio offerta
- `PUT /offers/{id}` - Modifica offerta
- `POST /offers/{id}/accept` - Accettazione offerta
- `POST /offers/{id}/withdraw` - Ritiro offerta

### Report
- `GET /reports/summary` - Statistiche generali
- `GET /reports/user/{id}` - Statistiche utente
- `GET /reports/charts` - Dati per grafici

<<<<<<< HEAD
=======


>>>>>>> 3f4da7f (Update README.md)
## 🤝 Contribuire

### Come Contribuire
1. Fork del repository
2. Crea un branch per la feature (`git checkout -b feature/AmazingFeature`)
3. Commit delle modifiche (`git commit -m 'Add some AmazingFeature'`)
4. Push al branch (`git push origin feature/AmazingFeature`)
5. Apri una Pull Request

### Linee Guida
- Segui le convenzioni di naming Java
- Aggiungi test per nuove funzionalità
- Aggiorna la documentazione
- Mantieni la compatibilità con le versioni precedenti

## 📄 Licenza

Questo progetto è sotto licenza **MIT**. Vedi il file `LICENSE` per i dettagli.

## 👥 Autori

- **Team UninaSwap** - Sviluppo iniziale
- **Studenti Universitari** - Testing e feedback

## 🙏 Ringraziamenti

- Università degli Studi di Napoli Federico II
- Comunità open source Java
- Tutti i beta tester e contributori

## 📞 Supporto

- **Email**: support@uninaswap.it
- **Issues**: [GitHub Issues](https://github.com/xCarmineBelgiorno/uninaswap/issues)
- **Documentazione**: [Wiki](https://github.com/xCarmineBelgiorno/uninaswap/wiki)

## 🔄 Changelog

### v1.0.0 (2024-01-XX)
- ✅ Sistema di registrazione e login
- ✅ Gestione annunci (vendita/scambio/regalo)
- ✅ Sistema di offerte
- ✅ Gestione transazioni
- ✅ Sistema di recensioni
- ✅ Report e statistiche
- ✅ Interfaccia responsive

---

**UninaSwap** - Connettiamo gli studenti universitari attraverso lo scambio di oggetti! 🎓✨
