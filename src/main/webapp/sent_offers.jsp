<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="java.sql.*" %>
            <%@ page import="com.entity.Offer" %>
                <%@ page import="com.dao.OfferDAO" %>
                    <%@ page import="com.conn.DBConnect" %>
                        <%@ page import="com.entity.User" %>
                            <!DOCTYPE html>
                            <html>

                            <head>
                                <meta charset="UTF-8">
                                <title>Offerte Inviate - UninaSwap</title>
                                <link rel="stylesheet" href="Css/w3.css">
                                <link rel="stylesheet" href="Css/abc.css">
                                <style>
                                    .container {
                                        max-width: 1200px;
                                        margin: 0 auto;
                                        padding: 20px;
                                        display: grid;
                                        grid-template-columns: 260px 1fr;
                                        gap: 20px;
                                    }

                                    .sidebar {
                                        background: white;
                                        border-radius: 12px;
                                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
                                        padding: 20px;
                                    }

                                    .sidebar a {
                                        display: block;
                                        padding: 12px 15px;
                                        border-radius: 8px;
                                        margin-bottom: 8px;
                                        text-decoration: none;
                                        color: #333;
                                    }

                                    .sidebar a.active,
                                    .sidebar a:hover {
                                        background: #f1f3ff;
                                        color: #4a57e8;
                                    }

                                    .content {
                                        background: white;
                                        border-radius: 12px;
                                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
                                        padding: 25px;
                                    }

                                    .page-title {
                                        font-size: 1.8em;
                                        color: #333;
                                        margin-bottom: 20px;
                                    }

                                    .offer-card {
                                        border-left: 4px solid #667eea;
                                        background: #f8f9fa;
                                        border-radius: 10px;
                                        padding: 15px;
                                        margin-bottom: 15px;
                                    }

                                    .offer-header {
                                        display: flex;
                                        justify-content: space-between;
                                        align-items: center;
                                        margin-bottom: 8px;
                                    }

                                    .offer-type {
                                        background: #667eea;
                                        color: white;
                                        padding: 4px 10px;
                                        border-radius: 12px;
                                        font-size: 12px;
                                        font-weight: bold;
                                    }

                                    .btn {
                                        padding: 10px 14px;
                                        border: none;
                                        border-radius: 8px;
                                        cursor: pointer;
                                        text-decoration: none;
                                        display: inline-block;
                                    }

                                    .btn-view {
                                        background: #6c757d;
                                        color: white;
                                    }

                                    .btn-withdraw {
                                        background: #ff9800;
                                        color: white;
                                    }

                                    .btn-review {
                                        background: #28a745;
                                        color: white;
                                    }

                                    .review-sent {
                                        background: #e9f7ef;
                                        color: #2f855a;
                                        padding: 8px 12px;
                                        border-radius: 8px;
                                        font-size: 13px;
                                        font-weight: bold;
                                    }

                                    .empty {
                                        text-align: center;
                                        color: #777;
                                        padding: 40px 20px;
                                    }

                                    @media (max-width: 900px) {
                                        .container {
                                            grid-template-columns: 1fr;
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
                                            <a href="sent_offers.jsp" class="active">Offerte inviate</a>
                                            <a href="my_ads.jsp">Miei Annunci</a>
                                            <a href="accepted_offers.jsp">Scambi Conclusi</a>
                                            <a href="user_profile.jsp?userId=<%= user.getId() %>">Impostazioni</a>
                                        </div>

                                        <div class="content">
                                            <h2 class="page-title">Offerte Inviate</h2>

                                            <% String success=request.getParameter("success"); String
                                                action=request.getParameter("action"); if ("1".equals(success)) { String
                                                message="" ; if ("accepted".equals(action)) {
                                                message="🎉 Una tua offerta è stata accettata! Controlla i dettagli." ;
                                                } else if ("rejected".equals(action)) {
                                                message="❌ Una tua offerta è stata rifiutata." ; } else if
                                                ("withdrawn".equals(action)) {
                                                message="ℹ️ Offerta ritirata correttamente." ; } else if
                                                ("reviewed".equals(action)) {
                                                message="✅ Recensione inviata con successo!" ; } %>
                                                <div class="notice" id="success-notice"
                                                    style="background:#e9f7ef;border:1px solid #bce5c6;color:#2f855a;padding:12px 15px;border-radius:10px;margin-bottom:15px;">
                                                    <%= message %>
                                                </div>
                                                <script>
                                                    setTimeout(function () {
                                                        document.getElementById('success-notice').style.display = 'none';
                                                    }, 4000);
                                                </script>
                                                <% } %>

                                                    <% OfferDAO offerDAO=new OfferDAO(DBConnect.getConn()); List<Offer>
                                                        offers = offerDAO.getOffersByUserId(user.getId());
                                                        if (offers != null && !offers.isEmpty()) {
                                                        for (Offer o : offers) {
                                                        // Controlla se esiste già una recensione per questa offerta
                                                        boolean reviewExists = false;
                                                        try {
                                                        Connection conn = DBConnect.getConn();
                                                        PreparedStatement ps = conn.prepareStatement(
                                                        "SELECT 1 FROM reviews r " +
                                                        "JOIN transactions t ON r.transaction_id = t.id " +
                                                        "WHERE t.offer_id = ? AND r.reviewer_id = ?"
                                                        );
                                                        ps.setLong(1, o.getId());
                                                        ps.setLong(2, user.getId());
                                                        ResultSet rs = ps.executeQuery();
                                                        reviewExists = rs.next();
                                                        } catch (Exception e) {
                                                        e.printStackTrace();
                                                        }
                                                        %>
                                                        <div class="offer-card">
                                                            <div class="offer-header">
                                                                <span class="offer-type">
                                                                    <% if ("SALE_BID".equals(o.getType())) { %>Offerta
                                                                        Acquisto<% } %>
                                                                            <% if ("EXCHANGE_BID".equals(o.getType())) {
                                                                                %>Offerta Scambio<% } %>
                                                                                    <% if
                                                                                        ("GIFT_BID".equals(o.getType()))
                                                                                        { %>Richiesta Regalo<% } %>
                                                                </span>
                                                                <span style="color:#666; font-size: 13px;">Stato:
                                                                    <strong>
                                                                        <%= o.getStatus() %>
                                                                    </strong></span>
                                                            </div>
                                                            <div style="margin-bottom:8px;">
                                                                <%= o.getDescription() %>
                                                            </div>
                                                            <% if (o.getPrice() !=null) { %>
                                                                <div style="color:#667eea; font-weight:bold;">Prezzo
                                                                    offerto: €<%= o.getPrice() %>
                                                                </div>
                                                                <% } %>
                                                                    <div style="display:flex; gap:10px;">
                                                                        <a href="view_ad.jsp?adId=<%= o.getAdId() %>"
                                                                            class="btn btn-view">Vedi annuncio</a>
                                                                        <% if ("PENDING".equals(o.getStatus())) { %>
                                                                            <form method="post" action="offer/withdraw"
                                                                                onsubmit="return confirm('Vuoi ritirare questa offerta?');">
                                                                                <input type="hidden" name="offerId"
                                                                                    value="<%= o.getId() %>" />
                                                                                <input type="hidden" name="back"
                                                                                    value="sent_offers.jsp" />
                                                                                <button type="submit"
                                                                                    class="btn btn-withdraw">Ritira
                                                                                    offerta</button>
                                                                            </form>
                                                                            <% } %>
                                                                                <% if ("ACCEPTED".equals(o.getStatus()))
                                                                                    { %>
                                                                                    <% if (reviewExists) { %>
                                                                                        <span class="review-sent">✅
                                                                                            Recensione inviata!</span>
                                                                                        <% } else { %>
                                                                                            <a href="create_review.jsp?offerId=<%= o.getId() %>"
                                                                                                class="btn btn-review">Lascia
                                                                                                recensione</a>
                                                                                            <% } %>
                                                                                                <% } %>
                                                                    </div>
                                                        </div>
                                                        <% } } else { %>
                                                            <div class="empty">Non hai inviato nessuna offerta.</div>
                                                            <% } %>
                                        </div>
                                    </div>

                            </body>

                            </html>