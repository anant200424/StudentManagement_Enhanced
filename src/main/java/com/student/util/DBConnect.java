package com.student.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {

    private static final String URL      = "jdbc:mysql://localhost:3306/studentmanagement?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String USER     = "root";
    private static final String PASSWORD = "Anant@1234";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("DB Connected OK!");
        } catch (Exception e) {
            System.out.println("DB Connection FAILED: " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }
}
