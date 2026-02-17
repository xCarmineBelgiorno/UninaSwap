<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.conn.DBConnect" %>
        <%@ page import="java.sql.*" %>
            <% Connection conn=DBConnect.getConn(); String msg="" ; if (conn !=null) { try { // Disable foreign key
                checks temporarily to allow cleanup PreparedStatement ps0=conn.prepareStatement("SET
                FOREIGN_KEY_CHECKS=0"); ps0.execute(); // Delete ads PreparedStatement ps=conn.prepareStatement("DELETE
                FROM ads"); int rows=ps.executeUpdate(); // Also clean related tables if needed (offers, notifications)
                PreparedStatement ps2=conn.prepareStatement("DELETE FROM offers"); int rows2=ps2.executeUpdate();
                PreparedStatement ps3=conn.prepareStatement("DELETE FROM notifications"); int rows3=ps3.executeUpdate();
                // Re-enable foreign key checks PreparedStatement ps4=conn.prepareStatement("SET FOREIGN_KEY_CHECKS=1");
                ps4.execute(); msg="<h1>Pulizia Completata con Successo</h1>" ; msg +="<p>Annunci eliminati: " + rows
                + "</p>" ; msg +="<p>Offerte eliminate: " + rows2 + "</p>" ; msg +="<p>Notifiche eliminate: " + rows3
                + "</p>" ; msg +="<br><a href='index.jsp'>Torna alla Home</a>" ; } catch (Exception e) {
                msg="<h1>Errore durante la pulizia</h1><p>" + e.getMessage() + "</p>" ; e.printStackTrace(); } } else {
                msg="<h1>Errore Connessione DB</h1>" ; } %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Reset DB</title>
                    <link rel="stylesheet" href="Css/w3.css">
                </head>

                <body class="w3-container w3-padding-64 w3-center">
                    <%= msg %>
                </body>

                </html>