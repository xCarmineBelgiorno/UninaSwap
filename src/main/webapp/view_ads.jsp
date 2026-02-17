<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.entity.SimpleAd" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>UninaSwap - Visualizza Annunci</title>
                <link rel="stylesheet" href="Css/w3.css">
                <link rel="stylesheet" href="Css/abc.css">
                <style>
                    .ads-container {
                        max-width: 1200px;
                        margin: 0 auto;
                        padding: 20px;
                    }

                    .page-title {
                        text-align: center;
                        color: #333;
                        margin-bottom: 40px;
                        font-size: 2.5em;
                    }

                    .filters {
                        background: white;
                        padding: 20px;
                        border-radius: 10px;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                        margin-bottom: 30px;
                    }

                    .filter-row {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                        gap: 20px;
                        align-items: end;
                    }

                    .filter-group {
                        display: flex;
                        flex-direction: column;
                    }

                    .filter-group label {
                        margin-bottom: 8px;
                        font-weight: bold;
                        color: #555;
                    }

                    .filter-group select,
                    .filter-group input {
                        padding: 10px;
                        border: 2px solid #ddd;
                        border-radius: 5px;
                        font-size: 14px;
                    }

                    .filter-group select:focus,
                    .filter-group input:focus {
                        outline: none;
                        border-color: #667eea;
                    }

                    .filter-btn {
                        background: #667eea;
                        color: white;
                        padding: 12px 25px;
                        border: none;
                        border-radius: 5px;
                        cursor: pointer;
                        font-size: 16px;
                        transition: background 0.3s ease;
                    }

                    .filter-btn:hover {
                        background: #5a6fd8;
                    }

                    .ads-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                        gap: 25px;
                    }

                    .ad-card {
                        background: white;
                        border-radius: 15px;
                        overflow: hidden;
                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                        transition: transform 0.3s ease, box-shadow 0.3s ease;
                    }

                    .ad-card:hover {
                        transform: translateY(-5px);
                        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
                    }

                    .ad-image {
                        width: 100%;
                        height: 200px;
                        object-fit: cover;
                    }

                    .ad-content {
                        padding: 20px;
                    }

                    .ad-title {
                        font-size: 1.3em;
                        font-weight: bold;
                        color: #333;
                        margin-bottom: 10px;
                        line-height: 1.3;
                    }

                    .ad-description {
                        color: #666;
                        margin-bottom: 15px;
                        line-height: 1.5;
                        display: -webkit-box;
                        -webkit-line-clamp: 3;
                        -webkit-box-orient: vertical;
                        overflow: hidden;
                    }

                    .ad-meta {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 15px;
                    }

                    .ad-price {
                        font-size: 1.2em;
                        font-weight: bold;
                        color: #667eea;
                    }

                    .ad-type {
                        padding: 5px 12px;
                        border-radius: 15px;
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

                    .ad-location {
                        color: #888;
                        font-size: 14px;
                        margin-bottom: 15px;
                    }

                    .ad-actions {
                        display: flex;
                        gap: 10px;
                    }

                    .btn-primary {
                        background: #667eea;
                        color: white;
                        padding: 8px 16px;
                        border: none;
                        border-radius: 5px;
                        text-decoration: none;
                        font-size: 14px;
                        transition: background 0.3s ease;
                    }

                    .btn-primary:hover {
                        background: #5a6fd8;
                    }

                    .btn-secondary {
                        background: #6c757d;
                        color: white;
                        padding: 8px 16px;
                        border: none;
                        border-radius: 5px;
                        text-decoration: none;
                        font-size: 14px;
                        transition: background 0.3s ease;
                    }

                    .btn-secondary:hover {
                        background: #5a6268;
                    }

                    .status-badge {
                        padding: 4px 10px;
                        border-radius: 8px;
                        font-size: 12px;
                        font-weight: bold;
                    }

                    .status-sold {
                        background: #fde68a;
                        color: #92400e;
                    }

                    .status-closed {
                        background: #e5e7eb;
                        color: #374151;
                    }

                    .no-ads {
                        text-align: center;
                        padding: 60px 20px;
                        color: #666;
                    }

                    .no-ads h3 {
                        margin-bottom: 20px;
                        color: #333;
                    }

                    @media (max-width: 768px) {
                        .filter-row {
                            grid-template-columns: 1fr;
                        }

                        .ads-grid {
                            grid-template-columns: 1fr;
                        }
                    }
                </style>
            </head>

            <body style="background: #f8f9fa; min-height: 100vh;">

                <jsp:include page="navbar.jsp" />

                <div class="ads-container">
                    <h1 class="page-title">Annunci Disponibili</h1>

                    <div class="filters">
                        <form method="get" action="view_ads.jsp">
                            <div class="filter-row">
                                <div class="filter-group">
                                    <label for="category">Categoria</label>
                                    <select id="category" name="category">
                                        <option value="">Tutte le categorie</option>
                                        <option value="Libri">Libri</option>
                                        <option value="Elettronica">Elettronica</option>
                                        <option value="Abbigliamento">Abbigliamento</option>
                                        <option value="Sport">Sport</option>
                                        <option value="Casa">Casa</option>
                                        <option value="Altro">Altro</option>
                                    </select>
                                </div>
                                <div class="filter-group">
                                    <label for="type">Tipo Annuncio</label>
                                    <select id="type" name="type">
                                        <option value="">Tutti i tipi</option>
                                        <option value="SALE">Vendita</option>
                                        <option value="EXCHANGE">Scambio</option>
                                        <option value="GIFT">Regalo</option>
                                    </select>
                                </div>
                                <div class="filter-group">
                                    <label for="maxPrice">Prezzo Massimo</label>
                                    <input type="number" id="maxPrice" name="maxPrice" placeholder="€" min="0">
                                </div>
                                <div class="filter-group">
                                    <button type="submit" class="filter-btn">Filtra</button>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="ads-grid">
                        <% try { com.control.AdControl adControl=new com.control.AdControl(); List<SimpleAd> ads
                            = adControl.getAllAds();

                            if(ads != null && !ads.isEmpty()) {
                            for(SimpleAd ad : ads) {
                            boolean adClosed = ad.getStatus() != null && !"ACTIVE".equals(ad.getStatus());
                            String imagePath = (ad.getImageUrl() != null && !ad.getImageUrl().trim().isEmpty())
                            ? ad.getImageUrl() : "default_ad.png";
                            %>
                            <div class="ad-card">
                                <img src="images/<%= imagePath %>" alt="<%= ad.getTitle() %>" class="ad-image">

                                <div class="ad-content">
                                    <h3 class="ad-title">
                                        <%= ad.getTitle() %>
                                    </h3>
                                    <p class="ad-description">
                                        <%= ad.getDescription() %>
                                    </p>

                                    <div class="ad-meta">
                                        <span class="ad-price">
                                            <% if(ad.getType().equals("GIFT")) { %>Gratis<% } else { %>€<%=
                                                        ad.getPrice() %>
                                                        <% } %>
                                        </span>
                                        <span class="ad-type <%= ad.getType().toLowerCase() %>">
                                            <% if(ad.getType().equals("SALE")) { %>Vendita<% } %>
                                                    <% if(ad.getType().equals("EXCHANGE")) { %>Scambio<% } %>
                                                            <% if(ad.getType().equals("GIFT")) { %>Regalo<% } %>
                                        </span>
                                    </div>

                                    <div class="ad-location">📍 <%= ad.getLocation() %> • <%= ad.getPickupTime() %>
                                    </div>

                                    <div class="ad-actions">
                                        <a href="view_ad.jsp?adId=<%= ad.getId() %>" class="btn-primary">Visualizza</a>
                                        <% if (!adClosed) { %>
                                            <a href="make_offer.jsp?adId=<%= ad.getId() %>" class="btn-secondary">Fai
                                                un'Offerta</a>
                                            <% } else { %>
                                                <span class="status-badge status-closed">
                                                    <% if ("SOLD".equals(ad.getStatus())) { %>Venduto<% } else { %>
                                                            Chiuso<% } %>
                                                </span>
                                                <% } %>
                                    </div>
                                </div>
                            </div>
                            <% } } else { %>
                                <div class="no-ads">
                                    <h3>Nessun annuncio disponibile</h3>
                                    <p>Sii il primo a pubblicare un annuncio su UninaSwap!</p>
                                    <a href="create_ad.jsp" class="btn-primary"
                                        style="margin-top: 20px; display: inline-block;">Crea Annuncio</a>
                                </div>
                                <% } } catch(Exception e) { %>
                                    <div class="no-ads">
                                        <h3>Errore nel caricamento degli annunci</h3>
                                        <p>Riprova più tardi o contatta il supporto.</p>
                                    </div>
                                    <% } %>
                    </div>
                </div>

            </body>

            </html>