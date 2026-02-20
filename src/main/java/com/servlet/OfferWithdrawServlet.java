package com.servlet;

import com.entity.Offer;
import com.entity.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class OfferWithdrawServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/customerlogin.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        String offerIdParam = request.getParameter("offerId");
        String back = request.getParameter("back");
        if (offerIdParam == null) {
            response.sendRedirect("/sent_offers.jsp?error=missing_offer");
            return;
        }
        try {
            Long offerId = Long.parseLong(offerIdParam);
            com.control.OfferControl offerControl = new com.control.OfferControl();
            Offer offer = offerControl.getOfferById(offerId);

            if (offer == null || !offer.getUserId().equals(user.getId())) {
                response.sendRedirect("/sent_offers.jsp?error=forbidden");
                return;
            }
            if (!"PENDING".equals(offer.getStatus())) {
                response.sendRedirect("/sent_offers.jsp?error=not_pending");
                return;
            }

            // Logica di ritiro e notifica delegata al Control
            boolean ok = offerControl.withdrawOffer(offerId);

            String redirect = back != null ? back : "/sent_offers.jsp";
            if (!redirect.startsWith("/"))
                redirect = "/" + redirect;
            response.sendRedirect(
                    redirect + (redirect.contains("?") ? "&" : "?") + (ok ? "success=1&action=withdrawn" : "error=1"));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/sent_offers.jsp?error=exception");
        }
    }
}
