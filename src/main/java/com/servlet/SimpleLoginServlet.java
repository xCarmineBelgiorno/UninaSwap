package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SimpleLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        // Recupera i parametri
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Login Result</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>Risultato Login</h1>");
        out.println("<p>Email ricevuta: " + email + "</p>");
        out.println("<p>Password ricevuta: " + password + "</p>");
        
        // Login hardcoded per test
        if ("test@unina.it".equals(email) && "password123".equals(password)) {
            out.println("<h2 style='color: green;'>✅ LOGIN RIUSCITO!</h2>");
            out.println("<p>Credenziali corrette!</p>");
            
            // Crea sessione
            HttpSession session = request.getSession();
            session.setAttribute("userEmail", email);
            session.setAttribute("userName", "Mario Rossi");
            
            out.println("<p>Sessione creata!</p>");
            out.println("<p><a href='user_dashboard.jsp'>Vai alla Dashboard</a></p>");
        } else {
            out.println("<h2 style='color: red;'>❌ LOGIN FALLITO!</h2>");
            out.println("<p>Credenziali sbagliate!</p>");
            out.println("<p>Usa: test@unina.it / password123</p>");
        }
        
        out.println("<p><a href='customerlogin.jsp'>Torna al Login</a></p>");
        out.println("</body>");
        out.println("</html>");
    }
}
