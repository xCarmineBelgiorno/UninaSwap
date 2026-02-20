package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.SimpleAd;
import com.entity.User;

@WebServlet("/deleteAd")
public class DeleteAdServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long adId = Long.parseLong(req.getParameter("id"));
            com.control.AdControl adControl = new com.control.AdControl();
            SimpleAd ad = adControl.getAdById(adId);

            HttpSession session = req.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null) {
                session.setAttribute("failedMsg", "Devi effettuare il login per eliminare un annuncio");
                resp.sendRedirect("login.jsp");
                return;
            }

            if (ad != null && ad.getUserId().equals(user.getId())) {
                boolean f = adControl.deleteAd(adId);
                if (f) {
                    session.setAttribute("succMsg", "Annuncio eliminato con successo");
                } else {
                    session.setAttribute("failedMsg", "Errore durante l'eliminazione dell'annuncio");
                }
            } else {
                session.setAttribute("failedMsg", "Non hai i permessi per eliminare questo annuncio");
            }

            resp.sendRedirect("my_ads.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = req.getSession();
            session.setAttribute("failedMsg", "Errore del server");
            resp.sendRedirect("my_ads.jsp");
        }
    }
}
