<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.entity.SimpleAd" %>
<%@ page import="com.dao.AdDAO" %>
<%@ page import="com.conn.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fai un'Offerta - UninaSwap</title>
<link rel="stylesheet" href="Css/w3.css">
<link rel="stylesheet" href="Css/abc.css">
<style>
.offer-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
}

.page-title {
    text-align: center;
    color: #333;
    margin-bottom: 30px;
    font-size: 2.5em;
}

.ad-preview {
    background: white;
    border-radius: 15px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    padding: 25px;
    margin-bottom: 30px;
}

.ad-title {
    font-size: 1.5em;
    font-weight: bold;
    color: #333;
    margin-bottom: 15px;
}

.ad-description {
    color: #666;
    margin-bottom: 15px;
    line-height: 1.6;
}

.ad-meta {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
}

.ad-price {
    font-size: 1.3em;
    font-weight: bold;
    color: #667eea;
}

.ad-type {
    padding: 8px 15px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: bold;
    text-transform: uppercase;
}

.ad-type.sale {
    background: #ff6b6b;
    color: white;
}

.ad-type.exchange {
    background: #4ecdc4;
    color: white;
}

.ad-type.gift {
    background: #45b7d1;
    color: white;
}

.offer-form {
    background: white;
    border-radius: 15px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    padding: 30px;
}

.form-title {
    color: #667eea;
    margin-bottom: 25px;
    font-size: 1.8em;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold;
    color: #555;
}

.form-control, .form-select {
    width: 100%;
    padding: 12px 15px;
    border: 2px solid #e9ecef;
    border-radius: 8px;
    font-size: 16px;
    transition: border-color 0.3s ease;
}

.form-control:focus, .form-select:focus {
    outline: none;
    border-color: #667eea;
    box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
}

.btn-submit {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border: none;
    border-radius: 8px;
    padding: 15px 30px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: transform 0.3s ease;
    width: 100%;
}

.btn-submit:hover {
    transform: translateY(-2px);
}

.btn-back {
    background: #6c757d;
    color: white;
    border: none;
    border-radius: 8px;
    padding: 12px 25px;
    font-size: 14px;
    text-decoration: none;
    display: inline-block;
    margin-bottom: 20px;
    transition: background 0.3s ease;
}

.btn-back:hover {
    background: #5a6268;
    color: white;
    text-decoration: none;
}

.error-message {
    background: #f8d7da;
    color: #721c24;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
    border: 1px solid #f5c6cb;
}

.success-message {
    background: #d4edda;
    color: #155724;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
    border: 1px solid #c3e6cb;
}

@media (max-width: 768px) {
    .offer-container {
        padding: 15px;
    }
    
    .ad-meta {
        flex-direction: column;
        gap: 10px;
        align-items: flex-start;
    }
}
</style>
</head>
<body style="background: #f8f9fa; min-height: 100vh;">

<jsp:include page="navbar.jsp" />

<div class="offer-container">
    <a href="view_ads.jsp" class="btn-back">← Torna agli Annunci</a>
    
    <h1 class="page-title">Fai un'Offerta</h1>
    
    <%
    // Recupera l'ID dell'annuncio dalla query string
    String adIdParam = request.getParameter("adId");
    SimpleAd ad = null;
    
    if (adIdParam != null && !adIdParam.trim().isEmpty()) {
        try {
            long adId = Long.parseLong(adIdParam);
            AdDAO adDAO = new AdDAO(DBConnect.getConn());
            ad = adDAO.getAdById(adId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    String error = (String) request.getAttribute("error");
    if (error != null) {
    %>
        <div class="error-message"><%= error %></div>
    <%
    }
    
    if (ad == null) {
    %>
        <div class="error-message">
            <h3>Errore</h3>
            <p>Annuncio non trovato o ID non valido.</p>
            <a href="view_ads.jsp" class="btn-back">Torna agli Annunci</a>
        </div>
    <%
    } else {
    %>
        <!-- Anteprima dell'annuncio -->
        <div class="ad-preview">
            <h2 class="ad-title"><%= ad.getTitle() %></h2>
            <p class="ad-description"><%= ad.getDescription() %></p>
            
            <div class="ad-meta">
                <span class="ad-price">
                    <% if(ad.getType().equals("GIFT")) { %>
                        Gratis
                    <% } else { %>
                        €<%= ad.getPrice() != null ? ad.getPrice() : "Da concordare" %>
                    <% } %>
                </span>
                <span class="ad-type <%= ad.getType().toLowerCase() %>">
                    <% if(ad.getType().equals("SALE")) { %>Vendita<% } %>
                    <% if(ad.getType().equals("EXCHANGE")) { %>Scambio<% } %>
                    <% if(ad.getType().equals("GIFT")) { %>Regalo<% } %>
                </span>
            </div>
            
            <p><strong>📍 Consegna:</strong> <%= ad.getLocation() %></p>
            <p><strong>⏰ Orario:</strong> <%= ad.getPickupTime() %></p>
        </div>
        
        <!-- Form per l'offerta -->
        <div class="offer-form">
            <h3 class="form-title">Invia la tua Offerta</h3>
            
            <% boolean adClosed = ad.getStatus() != null && !"ACTIVE".equals(ad.getStatus()); %>
            <% if (adClosed) { %>
                <div class="error-message">Questo annuncio è chiuso. Non è più possibile inviare offerte.</div>
            <% } else { %>
            <form method="post" action="makeoffer" id="offerForm">
                <input type="hidden" name="adId" value="<%= ad.getId() %>">
                
                <div class="form-group">
                    <label for="offerType">Tipo di Offerta *</label>
                    <select class="form-select" id="offerType" name="offerType" required>
                        <option value="">Seleziona tipo</option>
                        <% if(ad.getType().equals("SALE")) { %>
                            <option value="SALE_BID">Offerta di Acquisto</option>
                        <% } %>
                        <% if(ad.getType().equals("EXCHANGE")) { %>
                            <option value="EXCHANGE_BID">Offerta di Scambio</option>
                        <% } %>
                        <% if(ad.getType().equals("GIFT")) { %>
                            <option value="GIFT_BID">Richiesta di Regalo</option>
                        <% } %>
                    </select>
                </div>
                
                <div id="priceFields" class="form-group" style="display: none;">
                    <label for="price">Prezzo Proposto (€) *</label>
                    <input type="number" class="form-control" id="price" name="price" 
                           step="0.01" min="0" placeholder="0.00">
                </div>
                
                <div id="exchangeFields" class="form-group" style="display: none;">
                    <label for="exchangeItem">Cosa offri in cambio? *</label>
                    <textarea class="form-control" id="exchangeItem" name="exchangeItem" 
                              rows="4" placeholder="Descrivi l'oggetto che vuoi scambiare..."></textarea>
                </div>
                
                <div id="giftFields" class="form-group" style="display: none;">
                    <label for="motivation">Lettera Motivazionale *</label>
                    <textarea class="form-control" id="motivation" name="motivation" 
                              rows="4" placeholder="Spiega perché vorresti ricevere questo regalo..."></textarea>
                </div>
                
                <div class="form-group">
                    <label for="message">Messaggio (opzionale)</label>
                    <textarea class="form-control" id="message" name="message" 
                              rows="3" placeholder="Aggiungi un messaggio personale..."></textarea>
                </div>
                
                <button type="submit" class="btn-submit">Invia Offerta</button>
            </form>
            <% } %>
        </div>
        
        <script>
        // Mostra/nascondi campi specifici in base al tipo di offerta
        document.getElementById('offerType') && document.getElementById('offerType').addEventListener('change', function() {
            const priceFields = document.getElementById('priceFields');
            const exchangeFields = document.getElementById('exchangeFields');
            const giftFields = document.getElementById('giftFields');
            
            // Nascondi tutti i campi
            priceFields.style.display = 'none';
            exchangeFields.style.display = 'none';
            giftFields.style.display = 'none';
            
            // Mostra i campi appropriati
            if (this.value === 'SALE_BID') {
                priceFields.style.display = 'block';
            } else if (this.value === 'EXCHANGE_BID') {
                exchangeFields.style.display = 'block';
            } else if (this.value === 'GIFT_BID') {
                giftFields.style.display = 'block';
            }
        });
        
        // Validazione del form
        document.getElementById('offerForm') && document.getElementById('offerForm').addEventListener('submit', function(e) {
            const offerType = document.getElementById('offerType').value;
            
            if (offerType === 'SALE_BID') {
                const price = document.getElementById('price').value;
                if (!price || parseFloat(price) <= 0) {
                    e.preventDefault();
                    alert('Inserisci un prezzo valido per l\'offerta!');
                    return false;
                }
            }
            
            if (offerType === 'EXCHANGE_BID') {
                const exchangeItem = document.getElementById('exchangeItem').value;
                if (!exchangeItem.trim()) {
                    e.preventDefault();
                    alert('Descrivi cosa offri in cambio!');
                    return false;
                }
            }
            
            if (offerType === 'GIFT_BID') {
                const motivation = document.getElementById('motivation').value;
                if (!motivation.trim()) {
                    e.preventDefault();
                    alert('Scrivi una lettera motivazionale!');
                    return false;
                }
            }
        });
        </script>
    <%
    }
    %>
</div>

</body>
</html>
