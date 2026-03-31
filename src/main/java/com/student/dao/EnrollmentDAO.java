package com.student.dao;

import java.sql.*;
import java.util.*;
import com.student.util.DBConnect;

public class EnrollmentDAO {

    public boolean enroll(int studentId, int courseId) {
        try {
            Connection conn = DBConnect.getConnection();
            // Check if already enrolled
            PreparedStatement check = conn.prepareStatement(
                "SELECT id FROM enrollments WHERE student_id=? AND course_id=?");
            check.setInt(1, studentId); check.setInt(2, courseId);
            if (check.executeQuery().next()) { conn.close(); return false; }

            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO enrollments (student_id, course_id) VALUES (?,?)");
            ps.setInt(1, studentId); ps.setInt(2, courseId);
            ps.executeUpdate();
            conn.close();
            return true;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public List<Map<String,String>> getByStudent(int studentId) {
        List<Map<String,String>> list = new ArrayList<Map<String,String>>();
        try {
            Connection conn = DBConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "SELECT e.id, c.course_name, c.duration, c.fee, e.enrollment_date, e.status " +
                "FROM enrollments e JOIN courses c ON e.course_id=c.id WHERE e.student_id=? ORDER BY e.enrollment_date DESC");
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String,String> row = new LinkedHashMap<String,String>();
                row.put("id",          String.valueOf(rs.getInt("id")));
                row.put("courseName",  rs.getString("course_name"));
                row.put("duration",    rs.getString("duration"));
                row.put("fee",         String.valueOf(rs.getDouble("fee")));
                row.put("date",        rs.getTimestamp("enrollment_date").toString());
                row.put("status",      rs.getString("status"));
                list.add(row);
            }
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Map<String,String>> getAll() {
        List<Map<String,String>> list = new ArrayList<Map<String,String>>();
        try {
            Connection conn = DBConnect.getConnection();
            ResultSet rs = conn.prepareStatement(
                "SELECT e.id, s.name, s.email, c.course_name, e.enrollment_date, e.status " +
                "FROM enrollments e JOIN student s ON e.student_id=s.id JOIN courses c ON e.course_id=c.id ORDER BY e.enrollment_date DESC").executeQuery();
            while (rs.next()) {
                Map<String,String> row = new LinkedHashMap<String,String>();
                row.put("id",          String.valueOf(rs.getInt("id")));
                row.put("studentName", rs.getString("name"));
                row.put("email",       rs.getString("email"));
                row.put("courseName",  rs.getString("course_name"));
                row.put("date",        rs.getTimestamp("enrollment_date").toString());
                row.put("status",      rs.getString("status"));
                list.add(row);
            }
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public int count() {
        try {
            Connection conn = DBConnect.getConnection();
            ResultSet rs = conn.prepareStatement("SELECT COUNT(*) FROM enrollments").executeQuery();
            if (rs.next()) { int c = rs.getInt(1); conn.close(); return c; }
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public boolean delete(int id) {
        try {
            Connection conn = DBConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement("DELETE FROM enrollments WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            conn.close();
            return true;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}
