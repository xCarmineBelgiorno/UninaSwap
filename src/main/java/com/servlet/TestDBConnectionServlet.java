package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.conn.DBConnect;

public class TestDBConnectionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Test Database Connection</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>Test Connessione Database</h1>");
        
        try {
            // Test connessione
            Connection conn = DBConnect.getConn();
            if (conn != null && !conn.isClosed()) {
                out.println("<p style='color: green;'>✅ Connessione al database riuscita!</p>");
                
                // Test metadati database
                DatabaseMetaData metaData = conn.getMetaData();
                out.println("<h2>Informazioni Database:</h2>");
                out.println("<ul>");
                out.println("<li><strong>Database:</strong> " + metaData.getDatabaseProductName() + " " + metaData.getDatabaseProductVersion() + "</li>");
                out.println("<li><strong>Driver:</strong> " + metaData.getDriverName() + " " + metaData.getDriverVersion() + "</li>");
                out.println("<li><strong>URL:</strong> " + conn.getMetaData().getURL() + "</li>");
                out.println("</ul>");
                
                // Test tabelle
                out.println("<h2>Test Tabelle:</h2>");
                Statement stmt = conn.createStatement();
                
                // Test tabella users
                try {
                    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM users");
                    if (rs.next()) {
                        int count = rs.getInt(1);
                        out.println("<p style='color: green;'>✅ Tabella 'users' esiste - " + count + " utenti</p>");
                    }
                } catch (Exception e) {
                    out.println("<p style='color: red;'>❌ Tabella 'users' non esiste o errore: " + e.getMessage() + "</p>");
                }
                
                // Test tabella ads
                try {
                    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM ads");
                    if (rs.next()) {
                        int count = rs.getInt(1);
                        out.println("<p style='color: green;'>✅ Tabella 'ads' esiste - " + count + " annunci</p>");
                    }
                } catch (Exception e) {
                    out.println("<p style='color: red;'>❌ Tabella 'ads' non esiste o errore: " + e.getMessage() + "</p>");
                }
                
                // Test tabella categories
                try {
                    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM categories");
                    if (rs.next()) {
                        int count = rs.getInt(1);
                        out.println("<p style='color: green;'>✅ Tabella 'categories' esiste - " + count + " categorie</p>");
                    }
                } catch (Exception e) {
                    out.println("<p style='color: red;'>❌ Tabella 'categories' non esiste o errore: " + e.getMessage() + "</p>");
                }
                
                stmt.close();
                conn.close();
                
            } else {
                out.println("<p style='color: red;'>❌ Connessione al database fallita!</p>");
            }
            
        } catch (Exception e) {
            out.println("<p style='color: red;'>❌ Errore durante il test: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
        
        out.println("<hr>");
        out.println("<h2>Azioni:</h2>");
        out.println("<ul>");
        out.println("<li><a href='index.jsp'>Torna alla Homepage</a></li>");
        out.println("<li><a href='customer_reg.jsp'>Prova Registrazione</a></li>");
        out.println("<li><a href='customerlogin.jsp'>Prova Login</a></li>");
        out.println("</ul>");
        
        out.println("</body>");
        out.println("</html>");
    }
}
