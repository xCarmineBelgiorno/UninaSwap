package com.conn;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {
    private static Connection conn = null;

    public static Connection getConn() {
        try {
            System.out.println("=== TENTATIVO CONNESSIONE DATABASE (MySQL) ===");
            // Driver MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("✅ Driver MySQL caricato con successo");

            // Parametri di connessione (modificare se necessario)
            // Assumiamo root/root o password vuota.
            // Spesso in locale è root, oppure root e password vuota.
            // Provo con root/root.
            String url = "jdbc:mysql://localhost:3306/ecommerce?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
            String user = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "root";
            String password = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : "";

            System.out.println("URL: " + url);
            System.out.println("User: " + user);

            conn = DriverManager.getConnection(url, user, password);

            System.out.println("✅ Connessione al database riuscita!");
            if (conn != null) {
                System.out.println("Database: " + conn.getMetaData().getDatabaseProductName());
                System.out.println("Versione: " + conn.getMetaData().getDatabaseProductVersion());
            }

        } catch (Exception e) {
            System.out.println("❌ ERRORE CONNESSIONE DATABASE: " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }
}
