package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.conn.DBConnect;
import com.dao.UserDAO;
import com.entity.User;

@WebServlet("/update_profile")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String faculty = request.getParameter("faculty");
            String year = request.getParameter("year");
            String phone = request.getParameter("phone");

            User user = new User();
            user.setId(id);
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setFaculty(faculty);
            user.setYear(year);
            user.setPhone(phone);

            UserDAO dao = new UserDAO(DBConnect.getConn());
            boolean f = dao.updateUser(user);

            HttpSession session = request.getSession();
            if (f) {
                // Update session object
                User updatedUser = dao.getUserById(id);
                session.setAttribute("user", updatedUser);
                session.setAttribute("succMsg", "Profilo aggiornato con successo!");
                response.sendRedirect("user_profile.jsp");
            } else {
                session.setAttribute("failedMsg", "Errore durante l'aggiornamento.");
                response.sendRedirect("edit_profile.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("edit_profile.jsp");
        }
    }
}
