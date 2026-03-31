package com.student.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.student.model.Admin;
import com.student.util.DBConnect;

public class AdminDAO {

    // LOGIN
    public Admin validateLogin(String email, String password) {
        try {
            Connection conn = DBConnect.getConnection();
            if (conn == null) {
                System.out.println("ADMIN LOGIN: DB connection is null!");
                return null;
            }
            String sql = "SELECT * FROM admin WHERE email=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email.trim());
            ps.setString(2, password.trim());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Admin a = new Admin();
                a.setId(rs.getInt("id"));
                a.setName(rs.getString("name"));
                a.setEmail(rs.getString("email"));
                a.setPassword(rs.getString("password"));
                conn.close();
                System.out.println("ADMIN LOGIN SUCCESS: " + email);
                return a;
            } else {
                System.out.println("ADMIN LOGIN FAILED: no match for " + email);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("ADMIN LOGIN ERROR: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // UPDATE PASSWORD
    public boolean updatePassword(String email, String newPassword) {
        try {
            Connection conn = DBConnect.getConnection();
            if (conn == null) return false;
            PreparedStatement ps = conn.prepareStatement("UPDATE admin SET password=? WHERE email=?");
            ps.setString(1, newPassword.trim());
            ps.setString(2, email.trim());
            int rows = ps.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // EMAIL EXISTS
    public boolean emailExists(String email) {
        try {
            Connection conn = DBConnect.getConnection();
            if (conn == null) return false;
            PreparedStatement ps = conn.prepareStatement("SELECT id FROM admin WHERE email=?");
            ps.setString(1, email.trim());
            ResultSet rs = ps.executeQuery();
            boolean exists = rs.next();
            conn.close();
            System.out.println("ADMIN EMAIL EXISTS [" + email + "]: " + exists);
            return exists;
        } catch (Exception e) {
            System.out.println("ADMIN EMAIL EXISTS ERROR: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
