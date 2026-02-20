package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/simpletest")
public class SimpleTestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Test Semplice</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>✅ SERVLET FUNZIONA!</h1>");
        out.println("<p>Se vedi questa pagina, i servlet funzionano correttamente.</p>");
        out.println("<p><a href='customerlogin.jsp'>Torna al Login</a></p>");
        out.println("</body>");
        out.println("</html>");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Test POST</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>✅ POST FUNZIONA!</h1>");
        out.println("<p>Parametri ricevuti:</p>");
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        out.println("<p>Email: " + (email != null ? email : "NULL") + "</p>");
        out.println("<p>Password: " + (password != null ? password : "NULL") + "</p>");
        
        out.println("<p><a href='customerlogin.jsp'>Torna al Login</a></p>");
        out.println("</body>");
        out.println("</html>");
    }
}
