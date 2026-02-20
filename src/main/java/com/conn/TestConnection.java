package com.conn;

import java.sql.Connection;

public class TestConnection {
    public static void main(String[] args) {
        Connection conn = DBConnect.getConn();
        if (conn != null) {
            System.out.println("TEST RIUSCITO: Connessione ottenuta.");
        } else {
            System.out.println("TEST FALLITO: Connessione null.");
            System.exit(1);
        }
    }
}
