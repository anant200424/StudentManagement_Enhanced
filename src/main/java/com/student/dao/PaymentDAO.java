package com.student.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.student.model.Payment;
import com.student.util.DBConnect;

public class PaymentDAO {

    public boolean save(int studentId, String feeType, double amount, String payId, String orderId) {
        try {
            Connection conn = DBConnect.getConnection();
            if (conn == null) return false;
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO payments (student_id,fee_type,amount,razorpay_payment_id,razorpay_order_id,status) VALUES (?,?,?,?,?,'SUCCESS')");
            ps.setInt(1, studentId);
            ps.setString(2, feeType);
            ps.setDouble(3, amount);
            ps.setString(4, payId != null ? payId : "N/A");
            ps.setString(5, orderId != null ? orderId : "N/A");
            ps.executeUpdate();
            conn.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Payment> getByStudent(int studentId) {
        List<Payment> list = new ArrayList<Payment>();
        try {
            Connection conn = DBConnect.getConnection();
            if (conn == null) return list;
            PreparedStatement ps = conn.prepareStatement(
                "SELECT p.*, s.name FROM payments p JOIN student s ON p.student_id=s.id WHERE p.student_id=? ORDER BY p.paid_at DESC");
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Payment> getAll() {
        List<Payment> list = new ArrayList<Payment>();
        try {
            Connection conn = DBConnect.getConnection();
            if (conn == null) return list;
            ResultSet rs = conn.prepareStatement(
                "SELECT p.*, s.name FROM payments p JOIN student s ON p.student_id=s.id ORDER BY p.paid_at DESC").executeQuery();
            while (rs.next()) list.add(map(rs));
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public double getTotalCollected() {
        try {
            Connection conn = DBConnect.getConnection();
            if (conn == null) return 0;
            ResultSet rs = conn.prepareStatement(
                "SELECT COALESCE(SUM(amount),0) FROM payments WHERE status='SUCCESS'").executeQuery();
            if (rs.next()) {
                double total = rs.getDouble(1);
                conn.close();
                return total;
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countByStudent(int studentId) {
        try {
            Connection conn = DBConnect.getConnection();
            if (conn == null) return 0;
            PreparedStatement ps = conn.prepareStatement(
                "SELECT COUNT(*) FROM payments WHERE student_id=? AND status='SUCCESS'");
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int c = rs.getInt(1);
                conn.close();
                return c;
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Payment map(ResultSet rs) throws SQLException {
        Payment p = new Payment();
        p.setId(rs.getInt("id"));
        p.setStudentId(rs.getInt("student_id"));
        p.setFeeType(rs.getString("fee_type"));
        p.setAmount(rs.getDouble("amount"));
        p.setStatus(rs.getString("status"));
        p.setPaidAt(rs.getTimestamp("paid_at"));
        try { p.setStudentName(rs.getString("name")); } catch (Exception e) {}
        try { p.setRazorpayPaymentId(rs.getString("razorpay_payment_id")); } catch (Exception e) {}
        try { p.setRazorpayOrderId(rs.getString("razorpay_order_id")); } catch (Exception e) {}
        return p;
    }
}
