<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.entity.SimpleAd" %>
        <%@ page import="com.entity.User" %>
            <%@ page import="com.control.AdControl" %>
                <%@ page import="com.dao.UserDAO" %>
                    <%@ page import="com.conn.DBConnect" %>
                        <% String idParam=request.getParameter("adId"); if (idParam==null) {
                            response.sendRedirect("view_ads.jsp"); return; } Long adId=Long.parseLong(idParam);
                            AdControl adControl=new AdControl(); SimpleAd ad=adControl.getAdById(adId); if (ad==null) {
                            response.sendRedirect("view_ads.jsp"); return; } UserDAO userDAO=new
                            UserDAO(DBConnect.getConn()); User owner=userDAO.getUserById(ad.getUserId()); %>

                            <!DOCTYPE html>
                            <html>

                            <head>
                                <meta charset="UTF-8">
                                <title>
                                    <%= ad.getTitle() %> - UninaSwap
                                </title>
                                <link rel="stylesheet"
                                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                                <link rel="stylesheet" href="Css/w3.css">
                                <link rel="stylesheet" href="Css/abc.css">
                                <style>
                                    .ad-detail-container {
                                        max-width: 1000px;
                                        margin: 40px auto;
                                        padding: 0 20px;
                                    }

                                    .ad-grid {
                                        display: grid;
                                        grid-template-columns: 1fr 1fr;
                                        gap: 40px;
                                        background: white;
                                        padding: 30px;
                                        border-radius: 20px;
                                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
                                    }

                                    .ad-image-section {
                                        position: relative;
                                    }

                                    .main-image-container {
                                        width: 100%;
                                        height: 400px;
                                        border-radius: 15px;
                                        overflow: hidden;
                                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                                        margin-bottom: 15px;
                                        background: #f8fafc;
                                        display: flex;
                                        align-items: center;
                                        justify-content: center;
                                    }

                                    .main-image-container img {
                                        max-width: 100%;
                                        max-height: 100%;
                                        object-fit: contain;
                                    }

                                    .thumbnail-grid {
                                        display: flex;
                                        gap: 10px;
                                        overflow-x: auto;
                                        padding-bottom: 10px;
                                    }

                                    .thumbnail {
                                        width: 80px;
                                        height: 80px;
                                        border-radius: 8px;
                                        cursor: pointer;
                                        border: 2px solid transparent;
                                        transition: border-color 0.2s;
                                        object-fit: cover;
                                    }

                                    .thumbnail:hover,
                                    .thumbnail.active {
                                        border-color: #667eea;
                                    }

                                    .ad-info-section {
                                        display: flex;
                                        flex-direction: column;

                                    }

                                    .ad-header {
                                        margin-bottom: 25px;
                                    }

                                    .ad-category {
                                        display: inline-block;
                                        background: #e0e7ff;
                                        color: #4f46e5;
                                        padding: 5px 12px;
                                        border-radius: 20px;
                                        font-size: 0.85em;
                                        font-weight: bold;
                                        margin-bottom: 15px;
                                        text-transform: uppercase;
                                    }

                                    .ad-title {
                                        font-size: 2.2em;
                                        font-weight: bold;
                                        color: #1e293b;
                                        margin-bottom: 10px;
                                        line-height: 1.2;
                                    }

                                    .ad-price {
                                        font-size: 1.8em;
                                        color: #667eea;
                                        font-weight: bold;
                                    }

                                    .ad-description {
                                        color: #475569;
                                        line-height: 1.6;
                                        margin-bottom: 30px;
                                        font-size: 1.1em;
                                        white-space: pre-wrap;
                                    }

                                    .ad-meta-info {
                                        background: #f8fafc;
                                        padding: 20px;
                                        border-radius: 12px;
                                        margin-bottom: 30px;
                                    }

                                    .meta-item {
                                        display: flex;
                                        align-items: center;
                                        gap: 10px;
                                        margin-bottom: 10px;
                                        color: #64748b;
                                    }

                                    .meta-item i {
                                        color: #667eea;
                                        width: 20px;
                                    }

                                    .owner-section {
                                        display: flex;
                                        align-items: center;
                                        gap: 15px;
                                        padding-top: 20px;
                                        border-top: 1px solid #e2e8f0;
                                        margin-bottom: 30px;
                                    }

                                    .owner-avatar {
                                        width: 50px;
                                        height: 50px;
                                        background: #667eea;
                                        color: white;
                                        border-radius: 50%;
                                        display: flex;
                                        align-items: center;
                                        justify-content: center;
                                        font-weight: bold;
                                        font-size: 1.2em;
                                    }

                                    .owner-name {
                                        font-weight: bold;
                                        color: #1e293b;
                                    }

                                    .owner-label {
                                        color: #64748b;
                                        font-size: 0.85em;
                                    }

                                    .ad-actions {
                                        margin-top: auto;
                                    }

                                    .btn-offer {
                                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                        color: white;
                                        display: block;
                                        text-align: center;
                                        padding: 15px;
                                        border-radius: 12px;
                                        text-decoration: none;
                                        font-weight: bold;
                                        font-size: 1.1em;
                                        transition: transform 0.2s, box-shadow 0.2s;
                                    }

                                    .btn-offer:hover {
                                        transform: translateY(-2px);
                                        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
                                    }

                                    @media (max-width: 850px) {
                                        .ad-grid {
                                            grid-template-columns: 1fr;
                                        }
                                    }
                                </style>
                            </head>

                            <body style="background-color: #f1f5f9;">

                                <jsp:include page="navbar.jsp" />

                                <div class="ad-detail-container">
                                    <a href="view_ads.jsp"
                                        style="display: inline-block; margin-bottom: 20px; color: #64748b; text-decoration: none;">
                                        <i class="fas fa-arrow-left"></i> Torna agli annunci
                                    </a>

                                    <div class="ad-grid">
                                        <div class="ad-image-section">
                                            <div class="main-image-container">
                                                <% String mainImg=(ad.getImageUrl() !=null &&
                                                    !ad.getImageUrl().isEmpty()) ? "images/" + ad.getImageUrl()
                                                    : "images/default_ad.png" ; %>
                                                    <img id="mainImage" src="<%= mainImg %>" alt="<%= ad.getTitle() %>">
                                            </div>

                                            <% if (ad.getImageUrls() !=null && ad.getImageUrls().size()> 1) { %>
                                                <div class="thumbnail-grid">
                                                    <% for (String imgUrl : ad.getImageUrls()) { %>
                                                        <img src="images/<%= imgUrl %>" class="thumbnail"
                                                            onclick="document.getElementById('mainImage').src=this.src; document.querySelectorAll('.thumbnail').forEach(t => t.classList.remove('active')); this.classList.add('active');"
                                                            alt="Thumbnail">
                                                        <% } %>
                                                </div>
                                                <% } %>
                                        </div>

                                        <div class="ad-info-section">
                                            <div class="ad-header">
                                                <span class="ad-category">
                                                    <%= ad.getCategory().getName() %>
                                                </span>
                                                <h1 class="ad-title">
                                                    <%= ad.getTitle() %>
                                                </h1>
                                                <div class="ad-price">
                                                    <% if("GIFT".equals(ad.getType())) { %>
                                                        Gratis (Regalo)
                                                        <% } else { %>
                                                            €<%= ad.getPrice() %>
                                                                <% } %>
                                                </div>
                                            </div>

                                            <div class="ad-description">
                                                <%= ad.getDescription() %>
                                            </div>

                                            <div class="ad-meta-info">
                                                <div class="meta-item">
                                                    <i class="fas fa-tag"></i>
                                                    <span>Tipo: <%= ad.getType() %></span>
                                                </div>
                                                <div class="meta-item">
                                                    <i class="fas fa-map-marker-alt"></i>
                                                    <span>Luogo: <%= ad.getLocation() %></span>
                                                </div>
                                                <div class="meta-item">
                                                    <i class="fas fa-clock"></i>
                                                    <span>Disponibilità: <%= ad.getPickupTime() %></span>
                                                </div>
                                            </div>

                                            <% if (owner !=null) { %>
                                                <div class="owner-section">
                                                    <div class="owner-avatar">
                                                        <%= owner.getFirstName().substring(0, 1) %>
                                                            <%= owner.getLastName().substring(0, 1) %>
                                                    </div>
                                                    <div>
                                                        <div class="owner-label">Venditore</div>
                                                        <div class="owner-name">
                                                            <%= owner.getFullName() %>
                                                        </div>
                                                    </div>
                                                </div>
                                                <% } %>

                                                    <div class="ad-actions">
                                                        <% User currentUser=(User) session.getAttribute("user"); if
                                                            (currentUser !=null &&
                                                            currentUser.getId().equals(ad.getUserId())) { %>
                                                            <a href="edit_ad.jsp?adId=<%= ad.getId() %>"
                                                                class="btn-offer" style="background: #64748b;">
                                                                <i class="fas fa-edit"></i> Modifica il tuo annuncio
                                                            </a>
                                                            <% } else if (ad.getStatus() !=null && "ACTIVE"
                                                                .equals(ad.getStatus())) { %>
                                                                <a href="make_offer.jsp?adId=<%= ad.getId() %>"
                                                                    class="btn-offer">
                                                                    <i class="fas fa-handshake"></i> Fai un'Offerta
                                                                </a>
                                                                <% } else { %>
                                                                    <div class="w3-panel w3-amber w3-round w3-padding">
                                                                        Questo annuncio non è più disponibile. (Stato:
                                                                        <%= ad.getStatus() %>)
                                                                    </div>
                                                                    <% } %>
                                                    </div>
                                        </div>
                                    </div>
                                </div>

                            </body>

                            </html>