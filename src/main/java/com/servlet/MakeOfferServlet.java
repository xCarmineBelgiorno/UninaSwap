package com.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.Offer;
import com.entity.User;

public class MakeOfferServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            // Recupera i parametri dal form
            String adIdParam = request.getParameter("adId");
            String offerType = request.getParameter("offerType");
            String price = request.getParameter("price");
            String exchangeItem = request.getParameter("exchangeItem");
            String motivation = request.getParameter("motivation");
            String message = request.getParameter("message");

            System.out.println("=== CREAZIONE OFFERTA ===");
            System.out.println("Ad ID: " + adIdParam);
            System.out.println("Tipo Offerta: " + offerType);
            System.out.println("Prezzo: " + price);
            System.out.println("Oggetto Scambio: " + exchangeItem);
            System.out.println("Motivazione: " + motivation);
            System.out.println("Messaggio: " + message);

            // Validazioni base
            if (adIdParam == null || adIdParam.trim().isEmpty()) {
                request.setAttribute("error", "ID annuncio mancante");
                request.getRequestDispatcher("make_offer.jsp").forward(request, response);
                return;
            }

            if (offerType == null || offerType.trim().isEmpty()) {
                request.setAttribute("error", "Tipo di offerta mancante");
                request.getRequestDispatcher("make_offer.jsp").forward(request, response);
                return;
            }

            // Controlla se l'utente è loggato
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect("customerlogin.jsp");
                return;
            }
            User user = (User) session.getAttribute("user");

            // Controlla se l'utente ha già un'offerta PENDING per questo annuncio
            com.control.OfferControl offerControl = new com.control.OfferControl();

            boolean hasPending = offerControl.hasPendingOffer(Long.parseLong(adIdParam), user.getId());

            if (hasPending) {
                request.setAttribute("error",
                        "Hai già un'offerta pendente per questo annuncio. " +
                                "Ritirala dalla sezione 'Offerte inviate' se vuoi inviarne una nuova.");
                request.getRequestDispatcher("make_offer.jsp").forward(request, response);
                return;
            }

            // Crea l'oggetto Offer
            Offer offer = new Offer();
            offer.setAdId(Long.parseLong(adIdParam));
            offer.setUserId(user.getId());
            offer.setType(offerType);
            offer.setStatus("PENDING");

            // Imposta la descrizione in base al tipo di offerta
            if ("SALE_BID".equals(offerType)) {
                if (price == null || price.trim().isEmpty()) {
                    request.setAttribute("error", "Prezzo richiesto per offerta di acquisto");
                    request.getRequestDispatcher("make_offer.jsp").forward(request, response);
                    return;
                }
                try {
                    offer.setPrice(new BigDecimal(price));
                    offer.setDescription("Offerta di acquisto: €" + price + (message != null ? " - " + message : ""));
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Prezzo non valido");
                    request.getRequestDispatcher("make_offer.jsp").forward(request, response);
                    return;
                }
            } else if ("EXCHANGE_BID".equals(offerType)) {
                if (exchangeItem == null || exchangeItem.trim().isEmpty()) {
                    request.setAttribute("error", "Descrizione oggetto di scambio richiesta");
                    request.getRequestDispatcher("make_offer.jsp").forward(request, response);
                    return;
                }
                offer.setDescription("Offerta di scambio: " + exchangeItem + (message != null ? " - " + message : ""));
            } else if ("GIFT_BID".equals(offerType)) {
                if (motivation == null || motivation.trim().isEmpty()) {
                    request.setAttribute("error", "Lettera motivazionale richiesta");
                    request.getRequestDispatcher("make_offer.jsp").forward(request, response);
                    return;
                }
                offer.setDescription("Richiesta regalo: " + motivation + (message != null ? " - " + message : ""));
            }

            // Salva l'offerta nel database tramite Control
            // Nota: il DAO si occupa già di inviare la notifica all'owner
            boolean success = offerControl.createOffer(offer);

            if (success) {
                System.out.println("=== OFFERTA CREATA CON SUCCESSO ===");
                response.sendRedirect("view_ads.jsp?offer_sent=1");
            } else {
                System.out.println("=== ERRORE NELLA CREAZIONE DELL'OFFERTA ===");
                request.setAttribute("error", "Errore durante l'invio dell'offerta. Riprova.");
                request.getRequestDispatcher("make_offer.jsp").forward(request, response);
            }

        } catch (Exception e) {
            System.out.println("=== ERRORE CRITICO nella creazione offerta: " + e.getMessage() + " ===");
            e.printStackTrace();
            request.setAttribute("error", "Errore del server: " + e.getMessage());
            request.getRequestDispatcher("make_offer.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("view_ads.jsp");
    }
}
