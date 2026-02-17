<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.entity.SimpleAd" %>
            <%@ page import="com.entity.User" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>I Miei Annunci - UninaSwap</title>
                    <link rel="stylesheet" href="Css/w3.css">
                    <link rel="stylesheet" href="Css/abc.css">
                    <style>
                        .container {
                            max-width: 1200px;
                            margin: 0 auto;
                            padding: 20px;
                            display: grid;
                            grid-template-columns: 250px 1fr;
                            gap: 30px;
                        }

                        .sidebar {
                            background: white;
                            padding: 20px;
                            border-radius: 10px;
                            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                            height: fit-content;
                        }

                        .sidebar a {
                            display: block;
                            padding: 10px;
                            color: #555;
                            text-decoration: none;
                            border-radius: 5px;
                            margin-bottom: 5px;
                            transition: background 0.3s;
                        }

                        .sidebar a:hover,
                        .sidebar a.active {
                            background: #f0f2f5;
                            color: #667eea;
                            font-weight: bold;
                        }

                        .main-content {
                            background: white;
                            padding: 30px;
                            border-radius: 10px;
                            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                        }

                        .page-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 30px;
                            padding-bottom: 15px;
                            border-bottom: 1px solid #eee;
                        }

                        .page-title {
                            margin: 0;
                            color: #333;
                        }

                        .btn-new {
                            background: #667eea;
                            color: white;
                            padding: 10px 20px;
                            border-radius: 5px;
                            text-decoration: none;
                            font-weight: bold;
                        }

                        .ad-card {
                            background: #fff;
                            border-radius: 12px;
                            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
                            padding: 15px;
                            margin-bottom: 15px;
                            display: grid;
                            grid-template-columns: 140px 1fr;
                            gap: 15px;
                        }

                        .ad-thumb {
                            width: 140px;
                            height: 100px;
                            background: #f1f1f1;
                            border-radius: 10px;
                            object-fit: cover;
                        }

                        .ad-info h3 {
                            margin: 0 0 6px 0;
                            color: #333;
                        }

                        .ad-meta {
                            font-size: 14px;
                            color: #666;
                            margin-bottom: 10px;
                        }

                        .ad-actions {
                            display: flex;
                            gap: 10px;
                            margin-top: 10px;
                        }

                        .btn-sm {
                            padding: 5px 10px;
                            font-size: 12px;
                            border-radius: 4px;
                            text-decoration: none;
                            color: white;
                        }

                        .btn-view {
                            background: #6c757d;
                        }

                        .btn-offers {
                            background: #28a745;
                        }

                        .btn-close {
                            background: #dc3545;
                        }

                        .status-badge {
                            padding: 3px 8px;
                            border-radius: 4px;
                            font-size: 11px;
                            font-weight: bold;
                            text-transform: uppercase;
                            background: #eee;
                            color: #555;
                        }

                        .status-active {
                            background: #d1e7dd;
                            color: #0f5132;
                        }

                        @media (max-width: 768px) {
                            .container {
                                grid-template-columns: 1fr;
                            }

                            .ad-card {
                                grid-template-columns: 1fr;
                            }

                            .ad-thumb {
                                width: 100%;
                                height: 180px;
                            }
                        }
                    </style>
                </head>

                <body style="background: #f8f9fa; min-height: 100vh;">

                    <jsp:include page="navbar.jsp" />

                    <% User user=(User) session.getAttribute("user"); if (user==null) {
                        response.sendRedirect("login.jsp"); return; } %>

                        <div class="container">
                            <div class="sidebar">
                                <a href="received_offers.jsp">Mie Offerte</a>
                                <a href="my_ads.jsp" class="active">I Miei Annunci</a>
                                <a href="accepted_offers.jsp">Scambi Conclusi</a>
                                <a href="user_profile.jsp?userId=<%= user.getId() %>">Impostazioni</a>
                            </div>

                            <div class="main-content">
                                <div class="page-header">
                                    <h2 class="page-title">Gestisci i tuoi Annunci</h2>
                                    <a href="create_ad.jsp" class="btn-new">+ Nuovo Annuncio</a>
                                </div>

                                <% com.control.AdControl adControl=new com.control.AdControl(); com.control.OfferControl
                                    offerControl=new com.control.OfferControl(); List<SimpleAd> ads =
                                    adControl.getAdsByUserId(user.getId());

                                    if (ads != null && !ads.isEmpty()) {
                                    for (SimpleAd ad : ads) {
                                    int pending = offerControl.countPendingOffers(ad.getId());

                                    // FIX: Calcolo l'immagine su una riga
                                    String imagePath = (ad.getImageUrl() != null &&
                                    !ad.getImageUrl().trim().isEmpty()) ? ad.getImageUrl() : "default_ad.png";
                                    %>

                                    <div class="ad-card">
                                        <img class="ad-thumb" src="images/<%= imagePath %>" alt="<%= ad.getTitle() %>">
                                        <div class="ad-info">
                                            <div
                                                style="display: flex; justify-content: space-between; align-items: start;">
                                                <h3>
                                                    <%= ad.getTitle() %>
                                                </h3>
                                                <span class="status-badge <%= " ACTIVE".equals(ad.getStatus())
                                                    ? "status-active" : "" %>">
                                                    <%= ad.getStatus() %>
                                                </span>
                                            </div>

                                            <div class="ad-meta">
                                                <span>Prezzo: <%= ad.getType().equals("GIFT") ? "Regalo" : "€" +
                                                        ad.getPrice() %></span>
                                                <span style="margin: 0 10px;">•</span>
                                                <span>Visualizzazioni: 0</span>
                                                <span style="margin: 0 10px;">•</span>
                                                <span>Offerte Pendenti: <strong>
                                                        <%= pending %>
                                                    </strong></span>
                                            </div>

                                            <div class="ad-actions">
                                                <a href="view_ad.jsp?adId=<%= ad.getId() %>"
                                                    class="btn-sm btn-view">Vedi
                                                    Annuncio</a>
                                                <a href="edit_ad.jsp?id=<%= ad.getId() %>" class="btn-sm btn-view"
                                                    style="background-color: #ffc107; color: #333;">Modifica</a>
                                                <a href="deleteAd?id=<%= ad.getId() %>" class="btn-sm btn-close"
                                                    onclick="return confirm('Sei sicuro di voler eliminare questo annuncio? Questa azione non può essere annullata.')">Elimina</a>
                                                <a href="ad_offers.jsp?adId=<%= ad.getId() %>"
                                                    class="btn-sm btn-offers">Gestisci Offerte (<%= pending %>
                                                        )</a>
                                            </div>
                                        </div>
                                    </div>

                                    <% } } else { %>
                                        <div style="text-align: center; padding: 40px; color: #666;">
                                            <p>Non hai ancora pubblicato nessun annuncio.</p>
                                            <a href="create_ad.jsp"
                                                style="color: #667eea; font-weight: bold; text-decoration: none;">Inizia
                                                ora!</a>
                                        </div>
                                        <% } %>
                            </div>
                        </div>

                </body>

                </html>