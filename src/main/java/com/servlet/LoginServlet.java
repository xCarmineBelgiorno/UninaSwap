package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.User;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            // Recupera i parametri dal form
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            System.out.println("=== LOGIN ATTEMPT ===");
            System.out.println("Email: " + email);
            System.out.println("Password: " + password);

            // Validazioni base
            if (email == null || email.trim().isEmpty()) {
                System.out.println("ERRORE: Email vuota");
                request.setAttribute("error", "L'email è obbligatoria");
                request.getRequestDispatcher("customerlogin.jsp").forward(request, response);
                return;
            }

            if (password == null || password.trim().isEmpty()) {
                System.out.println("ERRORE: Password vuota");
                request.setAttribute("error", "La password è obbligatoria");
                request.getRequestDispatcher("customerlogin.jsp").forward(request, response);
                return;
            }

            System.out.println("Validazioni superate, tentativo di autenticazione DB...");

            // Delegare la logica al Control
            com.control.AuthenticationControl authControl = new com.control.AuthenticationControl();
            User user = authControl.login(email, password);

            System.out.println("Risultato autenticazione: " + (user != null ? "SUCCESSO" : "FALLITO"));

            if (user != null) {
                // Login riuscito
                System.out.println("Login riuscito per utente: " + user.getFirstName() + " " + user.getLastName());

                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId());
                session.setAttribute("userEmail", user.getEmail());
                session.setAttribute("userName", user.getFirstName() + " " + user.getLastName());

                System.out.println("Sessione creata, reindirizzamento alla dashboard...");

                // Reindirizza alla dashboard dell'utente
                response.sendRedirect("user_dashboard.jsp");
            } else {
                // Login fallito
                System.out.println("Login fallito - credenziali non valide");
                request.setAttribute("error", "Email o password non corretti");
                request.getRequestDispatcher("customerlogin.jsp").forward(request, response);
            }

        } catch (Exception e) {
            System.out.println("ERRORE CRITICO nel login: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Errore del server: " + e.getMessage());
            request.getRequestDispatcher("customerlogin.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Reindirizza alla pagina di login se si accede via GET
        response.sendRedirect("customerlogin.jsp");
    }
}
