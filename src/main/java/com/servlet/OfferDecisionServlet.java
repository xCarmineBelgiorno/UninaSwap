package com.servlet;

import com.entity.Offer;
import com.entity.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class OfferDecisionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("customerlogin.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");

        String action = request.getParameter("action"); // accept | reject
        String offerIdParam = request.getParameter("offerId");
        String backTo = request.getParameter("back"); // received_offers.jsp or view_ad.jsp?adId=...

        if (offerIdParam == null || offerIdParam.trim().isEmpty()) {
            String errorRedirect = backTo != null ? backTo : "/received_offers.jsp?error=missing_offer";
            if (!errorRedirect.startsWith("/")) {
                errorRedirect = "/" + errorRedirect;
            }
            response.sendRedirect(errorRedirect);
            return;
        }

        try {
            Long offerId = Long.parseLong(offerIdParam);
            com.control.OfferControl offerControl = new com.control.OfferControl();
            Offer offer = offerControl.getOfferById(offerId);

            if (offer == null) {
                String errorRedirect = backTo != null ? backTo : "/received_offers.jsp?error=offer_not_found";
                if (!errorRedirect.startsWith("/")) {
                    errorRedirect = "/" + errorRedirect;
                }
                response.sendRedirect(errorRedirect);
                return;
            }

            // Verifica che l'utente sia owner dell'annuncio
            Long ownerId = offerControl.getAdOwnerId(offer.getAdId());

            if (ownerId == null || !ownerId.equals(user.getId())) {
                response.sendRedirect("/received_offers.jsp?error=forbidden");
                return;
            }

            boolean ok = false;
            if ("accept".equalsIgnoreCase(action)) {
                ok = offerControl.acceptOffer(offerId);
            } else if ("reject".equalsIgnoreCase(action)) {
                ok = offerControl.rejectOffer(offerId);
            }

            // Le notifiche sono gestite all'interno del DAO chiamato dal Control

            Long adId = offer.getAdId();
            String redirect = backTo != null ? backTo : ("view_ad.jsp?adId=" + adId);
            // Ensure redirect starts with / to make it absolute
            if (!redirect.startsWith("/")) {
                redirect = "/" + redirect;
            }
            if (ok) {
                String actionMsg = "accept".equalsIgnoreCase(action) ? "accepted" : "rejected";
                response.sendRedirect(
                        redirect + (redirect.contains("?") ? "&" : "?") + "success=1&action=" + actionMsg);
            } else {
                response.sendRedirect(redirect + (redirect.contains("?") ? "&" : "?") + "error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/received_offers.jsp?error=exception");
        }
    }
}
