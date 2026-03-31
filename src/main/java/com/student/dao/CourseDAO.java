package com.student.dao;

import java.sql.*;
import java.util.*;
import com.student.model.Course;
import com.student.util.DBConnect;

public class CourseDAO {

    public List<Course> getAll() {
        List<Course> list = new ArrayList<Course>();
        try {
            Connection conn = DBConnect.getConnection();
            ResultSet rs = conn.prepareStatement("SELECT * FROM courses ORDER BY id").executeQuery();
            while (rs.next()) list.add(map(rs));
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public Course getById(int id) {
        try {
            Connection conn = DBConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM courses WHERE id=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) { Course c = map(rs); conn.close(); return c; }
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public boolean add(Course c) {
        try {
            Connection conn = DBConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO courses (course_name,duration,fee,description) VALUES (?,?,?,?)");
            ps.setString(1, c.getCourseName());
            ps.setString(2, c.getDuration());
            ps.setDouble(3, c.getFee());
            ps.setString(4, c.getDescription());
            ps.executeUpdate();
            conn.close();
            return true;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public boolean delete(int id) {
        try {
            Connection conn = DBConnect.getConnection();
            PreparedStatement ps = conn.prepareStatement("DELETE FROM courses WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            conn.close();
            return true;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public int count() {
        try {
            Connection conn = DBConnect.getConnection();
            ResultSet rs = conn.prepareStatement("SELECT COUNT(*) FROM courses").executeQuery();
            if (rs.next()) { int c = rs.getInt(1); conn.close(); return c; }
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    private Course map(ResultSet rs) throws SQLException {
        Course c = new Course();
        c.setId(rs.getInt("id"));
        c.setCourseName(rs.getString("course_name"));
        c.setDuration(rs.getString("duration"));
        c.setFee(rs.getDouble("fee"));
        try { c.setDescription(rs.getString("description")); } catch (Exception e) {}
        return c;
    }
}
