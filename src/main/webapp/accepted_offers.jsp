<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.entity.Offer" %>
<%@ page import="com.entity.User" %>
<%@ page import="com.control.OfferControl" %>

<%
    // Recupera l'utente dalla sessione
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("customerlogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Scambi Conclusi - UninaSwap</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="Css/w3.css">
    <link rel="stylesheet" href="Css/abc.css">
    <style>
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
            display: grid;
            grid-template-columns: 280px 1fr;
            gap: 30px;
        }

        .sidebar {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
            padding: 25px;
            height: fit-content;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            border-radius: 10px;
            margin-bottom: 8px;
            text-decoration: none;
            color: #64748b;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .sidebar a i {
            margin-right: 12px;
            width: 20px;
            text-align: center;
        }

        .sidebar a.active {
            background: #667eea;
            color: white;
            transform: translateX(5px);
        }

        .sidebar a:hover:not(.active) {
            background: #f1f5f9;
            color: #334155;
            transform: translateX(5px);
        }

        .content {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            padding: 40px;
        }

        .page-title {
            font-size: 2em;
            color: #1e293b;
            margin-bottom: 30px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .page-title i {
            color: #667eea;
        }

        .offer-card {
            border-left: 5px solid #10b981;
            background: #f8fafc;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            transition: transform 0.3s ease;
        }

        .offer-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .offer-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .offer-type {
            background: #10b981;
            color: white;
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .offer-status {
            color: #059669;
            font-weight: 700;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .offer-description {
            color: #475569;
            line-height: 1.6;
            margin-bottom: 15px;
            font-size: 1.05em;
        }

        .offer-price {
            color: #667eea;
            font-weight: 800;
            font-size: 1.25em;
            margin-bottom: 20px;
        }

        .offer-actions {
            display: flex;
            gap: 12px;
        }

        .btn {
            padding: 12px 20px;
            border-radius: 10px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            border: none;
            cursor: pointer;
        }

        .btn-view {
            background: #f1f5f9;
            color: #475569;
        }

        .btn-view:hover {
            background: #e2e8f0;
        }

        .btn-review {
            background: #667eea;
            color: white;
        }

        .btn-review:hover {
            background: #5a67d8;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }

        .empty-state i {
            font-size: 5em;
            color: #cbd5e1;
            margin-bottom: 20px;
        }

        .empty-state h3 {
            color: #64748b;
            font-size: 1.5em;
            margin-bottom: 10px;
        }

        .empty-state p {
            color: #94a3b8;
        }

        @media (max-width: 900px) {
            .container {
                grid-template-columns: 1fr;
            }

            .sidebar {
                display: none;
            }
        }
    </style>
</head>

<body style="background: #f1f5f9; min-height: 100vh; font-family: 'Inter', sans-serif;">

    <jsp:include page="navbar.jsp" />

    <div class="container">
        <div class="sidebar">
            <a href="received_offers.jsp"><i class="fas fa-inbox"></i> Mie Offerte</a>
            <a href="my_ads.jsp"><i class="fas fa-layer-group"></i> I Miei Annunci</a>
            <a href="accepted_offers.jsp" class="active"><i class="fas fa-check-circle"></i> Scambi Conclusi</a>
            <a href="user_profile.jsp?userId=<%= user.getId() %>"><i class="fas fa-cog"></i> Impostazioni</a>
        </div>

        <div class="content">
            <h2 class="page-title"><i class="fas fa-handshake"></i> Scambi Conclusi</h2>

            <%
                try {
                    OfferControl offerControl = new OfferControl();
                    List<Offer> acceptedOffers = offerControl.getAcceptedOffers(user.getId());

                    if (acceptedOffers != null && !acceptedOffers.isEmpty()) {
                        for (Offer o : acceptedOffers) {
            %>
                            <div class="offer-card">
                                <div class="offer-header">
                                    <span class="offer-type">
                                        <%
                                            if ("SALE_BID".equals(o.getType())) {
                                                out.print("Vendita Conclusa");
                                            } else if ("EXCHANGE_BID".equals(o.getType())) {
                                                out.print("Scambio Concluso");
                                            } else if ("GIFT_BID".equals(o.getType())) {
                                                out.print("Regalo Consegnato");
                                            }
                                        %>
                                    </span>
                                    <span class="offer-status">
                                        <i class="fas fa-check-circle"></i>
                                        <%= o.getStatus() %>
                                    </span>
                                </div>

                                <div class="offer-description">
                                    <%= o.getDescription() %>
                                </div>

                                <% if (o.getPrice() != null) { %>
                                    <div class="offer-price">€<%= o.getPrice() %></div>
                                <% } %>

                                <div class="offer-actions">
                                    <a href="view_ad.jsp?adId=<%= o.getAdId() %>" class="btn btn-view">
                                        <i class="fas fa-eye"></i> Vedi Annuncio
                                    </a>
                                    <a href="create_review.jsp?offerId=<%= o.getId() %>" class="btn btn-review">
                                        <i class="fas fa-star"></i> Lascia Feedback
                                    </a>
                                </div>
                            </div>
            <%
                        }
                    } else {
            %>
                        <div class="empty-state">
                            <i class="fas fa-handshake-slash"></i>
                            <h3>Nessuno scambio concluso</h3>
                            <p>Non hai ancora portato a termine nessuna trattativa.</p>
                            <a href="view_ads.jsp" class="btn btn-review" style="margin-top:20px; display:inline-flex;">
                                Inizia a cercare
                            </a>
                        </div>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                    <div class="empty-state" style="color: #dc2626;">
                        <i class="fas fa-exclamation-triangle"></i>
                        <h3>Errore nel caricamento</h3>
                        <p>Si è verificato un errore nel caricamento degli scambi conclusi.</p>
                    </div>
            <%
                }
            %>
        </div>
    </div>

</body>
</html>