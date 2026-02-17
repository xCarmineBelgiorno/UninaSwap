<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.entity.Offer" %>
            <%@ page import="com.dao.OfferDAO" %>
                <%@ page import="com.conn.DBConnect" %>
                    <%@ page import="com.entity.User" %>
                        <!DOCTYPE html>
                        <html>

                        <head>
                            <meta charset="UTF-8">
                            <title>Mie Offerte Ricevute - UninaSwap</title>
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

                                .offer-actions {
                                    display: flex;
                                    gap: 10px;
                                    margin-top: 10px;
                                }

                                .btn {
                                    padding: 10px 14px;
                                    border: none;
                                    border-radius: 8px;
                                    cursor: pointer;
                                    text-decoration: none;
                                    display: inline-block;
                                }

                                .btn-accept {
                                    background: #28a745;
                                    color: white;
                                }

                                .btn-reject {
                                    background: #dc3545;
                                    color: white;
                                }

                                .btn-view {
                                    background: #6c757d;
                                    color: white;
                                }

                                .notice {
                                    padding: 12px 15px;
                                    background: #e9f7ef;
                                    border: 1px solid #bce5c6;
                                    color: #2f855a;
                                    border-radius: 10px;
                                    margin-bottom: 15px;
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
                                        <a href="received_offers.jsp" class="active">Mie Offerte</a>
                                        <a href="sent_offers.jsp">Offerte inviate</a>
                                        <a href="my_ads.jsp">Miei Annunci</a>
                                        <a href="accepted_offers.jsp">Scambi Conclusi</a>
                                        <a href="user_profile.jsp?userId=<%= user.getId() %>">Impostazioni</a>
                                    </div>

                                    <div class="content">
                                        <h2 class="page-title">Offerte Ricevute</h2>

                                        <% OfferDAO offerDAO=new OfferDAO(DBConnect.getConn()); List<Offer> offers =
                                            offerDAO.getOffersReceivedByOwnerId(user.getId());
                                            String success = request.getParameter("success");
                                            String action = request.getParameter("action");
                                            String error = request.getParameter("error");
                                            if ("1".equals(success)) {
                                            String message = "";
                                            if ("accepted".equals(action)) {
                                            message = "🎉 Offerta accettata! La transazione è stata creata.";
                                            } else if ("rejected".equals(action)) {
                                            message = "❌ Offerta rifiutata e rimossa.";
                                            } else {
                                            message = "✅ Azione eseguita con successo!";
                                            }
                                            %>
                                            <div class="notice" id="success-notice">
                                                <%= message %>
                                            </div>
                                            <script>
                                                setTimeout(function () {
                                                    document.getElementById('success-notice').style.display = 'none';
                                                }, 4000);
                                            </script>
                                            <% } else if (error !=null) { %>
                                                <div class="notice"
                                                    style="background:#fdecea;border-color:#facdcd;color:#b42318;">❌ Si
                                                    è verificato un errore.</div>
                                                <% } if (offers !=null && !offers.isEmpty()) { for (Offer o : offers) {
                                                    %>
                                                    <div class="offer-card">
                                                        <div class="offer-header">
                                                            <span class="offer-type">
                                                                <% if ("SALE_BID".equals(o.getType())) { %>Offerta
                                                                    Acquisto<% } %>
                                                                        <% if ("EXCHANGE_BID".equals(o.getType())) { %>
                                                                            Offerta Scambio<% } %>
                                                                                <% if ("GIFT_BID".equals(o.getType())) {
                                                                                    %>Richiesta Regalo<% } %>
                                                            </span>
                                                            <span style="color:#666; font-size: 13px;">Stato: <strong>
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
                                                                <div class="offer-actions">
                                                                    <form method="post" action="offer/decision"
                                                                        style="display:inline;"
                                                                        onsubmit="return confirmAccept()">
                                                                        <input type="hidden" name="offerId"
                                                                            value="<%= o.getId() %>" />
                                                                        <input type="hidden" name="action"
                                                                            value="accept" />
                                                                        <input type="hidden" name="back"
                                                                            value="received_offers.jsp" />
                                                                        <button type="submit" class="btn btn-accept" <%
                                                                            if (!"PENDING".equals(o.getStatus())) {
                                                                            %>disabled<% } %> >✅ Accetta</button>
                                                                    </form>
                                                                    <form method="post" action="offer/decision"
                                                                        style="display:inline;"
                                                                        onsubmit="return confirmReject()">
                                                                        <input type="hidden" name="offerId"
                                                                            value="<%= o.getId() %>" />
                                                                        <input type="hidden" name="action"
                                                                            value="reject" />
                                                                        <input type="hidden" name="back"
                                                                            value="received_offers.jsp" />
                                                                        <button type="submit" class="btn btn-reject" <%
                                                                            if (!"PENDING".equals(o.getStatus())) {
                                                                            %>disabled<% } %> >❌ Rifiuta</button>
                                                                    </form>
                                                                    <a href="view_ad.jsp?adId=<%= o.getAdId() %>"
                                                                        class="btn btn-view">👁️ Vedi annuncio</a>
                                                                </div>
                                                    </div>
                                                    <% } } else { %>
                                                        <div class="empty">Non hai ancora ricevuto offerte.</div>
                                                        <% } %>
                                    </div>
                                </div>

                                <script>
                                    function confirmAccept() {
                                        return confirm('🎉 Sei sicuro di voler accettare questa offerta?\n\n✅ L\'offerta sarà accettata\n✅ Verrà creata una transazione\n✅ L\'annuncio sarà marcato come venduto (se è una vendita)\n✅ Tutte le altre offerte saranno rifiutate automaticamente\n\nQuesta azione non può essere annullata.');
                                    }

                                    function confirmReject() {
                                        return confirm('❌ Sei sicuro di voler rifiutare questa offerta?\n\nL\'offerta verrà rifiutata e rimossa dalla lista.\nL\'utente riceverà una notifica del rifiuto.');
                                    }
                                </script>

                        </body>

                        </html>