package com.agrowastex;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Modern MySQL 8+ URL for Mac
            String url = "jdbc:mysql://localhost:3306/AgroWasteX?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
            
            // Use the password that actually works in your terminal
            con = DriverManager.getConnection(url, "root", "agrowaste123");
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}