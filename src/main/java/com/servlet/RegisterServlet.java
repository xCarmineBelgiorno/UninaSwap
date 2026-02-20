package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.User;

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            // Recupera i parametri dal form
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String faculty = request.getParameter("faculty");
            String year = request.getParameter("year");
            String phone = request.getParameter("phone");

            // Validazioni base
            if (firstName == null || firstName.trim().isEmpty()) {
                request.setAttribute("error", "Il nome è obbligatorio");
                request.getRequestDispatcher("customer_reg.jsp").forward(request, response);
                return;
            }

            if (lastName == null || lastName.trim().isEmpty()) {
                request.setAttribute("error", "Il cognome è obbligatorio");
                request.getRequestDispatcher("customer_reg.jsp").forward(request, response);
                return;
            }

            if (email == null || email.trim().isEmpty()) {
                request.setAttribute("error", "L'email è obbligatoria");
                request.getRequestDispatcher("customer_reg.jsp").forward(request, response);
                return;
            }

            if (password == null || password.trim().isEmpty()) {
                request.setAttribute("error", "La password è obbligatoria");
                request.getRequestDispatcher("customer_reg.jsp").forward(request, response);
                return;
            }

            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Le password non coincidono");
                request.getRequestDispatcher("customer_reg.jsp").forward(request, response);
                return;
            }

            if (faculty == null || faculty.trim().isEmpty()) {
                request.setAttribute("error", "La facoltà è obbligatoria");
                request.getRequestDispatcher("customer_reg.jsp").forward(request, response);
                return;
            }

            // Crea l'oggetto User
            User user = new User();
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setEmail(email);
            user.setPassword(password); // In produzione dovrebbe essere criptata
            user.setFaculty(faculty);
            user.setYear(year != null ? year : "");
            user.setPhone(phone != null ? phone : "");
            user.setRole("STUDENT");

            // Salva l'utente nel database
            // Delegare la logica al Control
            com.control.AuthenticationControl authControl = new com.control.AuthenticationControl();
            boolean success = authControl.register(user);

            if (success) {
                // Registrazione riuscita
                request.setAttribute("success", "Registrazione completata con successo! Ora puoi accedere.");
                request.getRequestDispatcher("customerlogin.jsp").forward(request, response);
            } else {
                // Errore nella registrazione
                request.setAttribute("error", "Errore durante la registrazione. Riprova.");
                request.getRequestDispatcher("customer_reg.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore del server: " + e.getMessage());
            request.getRequestDispatcher("customer_reg.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Reindirizza alla pagina di registrazione se si accede via GET
        response.sendRedirect("customer_reg.jsp");
    }
}
