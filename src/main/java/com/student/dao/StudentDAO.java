package com.student.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.student.model.Student;
import com.student.util.DBConnect;

public class StudentDAO {

    // LOGIN - checks email and password
    public Student validateLogin(String email, String password) {
        Student student = null;
        try {
            Connection conn = DBConnect.getConnection();
            if (conn == null) {
                System.out.println("DB CONNECTION IS NULL!");
                return null;
            }
            String sql = "SELECT * FROM student WHERE email=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email.trim());
            ps.setString(2, password.trim());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                student = mapRow(rs);
                System.out.println("LOGIN SUCCESS: " + email);
            } else {
                System.out.println("LOGIN FAILED: no match for " + email);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("LOGIN ERROR: " + e.getMessage());
            e.printStackTrace();
        }
        return student;
    }

    // REGISTER - insert new student
    public boolean register(Student s) {
        try {
            Connection conn = DBConnect.getConnection();
            if (conn == null) {
                System.out.println("DB CONNECTION IS NULL!");
                return false;
            }
            String sql = "INSERT INTO student (name, email, password, course, address, phone, father_name, mother_name, reg_id) VALUES (?,?,?,?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, s.getName());
            ps.setString(2, s.getEmail());
            ps.setString(3, s.getPassword());
            ps.setString(4, s.getCourse()     != null ? s.getCourse()     : "");
            ps.setString(5, s.getAddress()    != null ? s.getAddress()    : "");
            ps.setString(6, s.getPhone()      != null ? s.getPhone()      : "");
            ps.setString(7, s.getFatherName() != null ? s.getFatherName() : "N/A");
            ps.setString(8, s.getMotherName() != null ? s.getMotherName() : "N/A");
            ps.setString(9, s.getRegId()      != null ? s.getRegId()      : "REG001");
            int rows = ps.executeUpdate();
            conn.close();
            System.out.println("REGISTER: inserted " + rows + " rows for " + s.getEmail());
            return rows > 0;
        } catch (Exception e) {
            System.out.println("REGISTER ERROR: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // GET ALL students
    public List<Student> getAll() {
        List<Student> list = new ArrayList<Student>();
        try {
            Connection conn = DBConnect.getConnection();
            if (conn == null) return list;
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM student ORDER BY id DESC");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // GET BY ID
    public Student getById(int id) {
        try {
            Connection conn = DBConnect.getConnection();
            if (conn == null) return null;
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM student WHERE id=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Student s = mapRow(rs);
                conn.close();
                return s;
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // GET BY EMAIL
    public Student getByEmail(String email) {
        try {
            Connection conn = DBConnect.getConnection();
            if (conn == null) return null;
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM student WHERE email=?");
            ps.setString(1, email.trim());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Student s = mapRow(rs);
                conn.close();
                return s;
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // CHECK EMAIL EXISTS
    public boolean emailExists(String email) {
        try {
            Connection conn = DBConnect.getConnection();
            if (conn == null) return false;
            PreparedStatement ps = conn.prepareStatement("SELECT id FROM student WHERE email=?");
            ps.setString(1, email.trim());
            ResultSet rs = ps.executeQuery();
            boolean exists = rs.next();
            conn.close();
            System.out.println("EMAIL EXISTS CHECK [" + email + "]: " + exists);
            return exists;
        } catch (Exception e) {
            System.out.println("EMAIL EXISTS ERROR: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // UPDATE PASSWORD
    public boolean updatePassword(String email, String newPassword) {
        try {
            Connection conn = DBConnect.getConnection();
            if (conn == null) return false;
            PreparedStatement ps = conn.prepareStatement("UPDATE student SET password=? WHERE email=?");
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

    // UPDATE student details
    public boolean update(Student s) {
        try {
            Connection conn = DBConnect.getConnection();
            if (conn == null) return false;
            String sql = "UPDATE student SET name=?, email=?, course=?, address=?, phone=?, father_name=?, mother_name=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, s.getName());
            ps.setString(2, s.getEmail());
            ps.setString(3, s.getCourse());
            ps.setString(4, s.getAddress());
            ps.setString(5, s.getPhone());
            ps.setString(6, s.getFatherName());
            ps.setString(7, s.getMotherName());
            ps.setInt(8,    s.getId());
            ps.executeUpdate();
            conn.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // DELETE student
    public boolean delete(int id) {
        try {
            Connection conn = DBConnect.getConnection();
            if (conn == null) return false;
            PreparedStatement ps = conn.prepareStatement("DELETE FROM student WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            conn.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // COUNT students
    public int count() {
        try {
            Connection conn = DBConnect.getConnection();
            if (conn == null) return 0;
            ResultSet rs = conn.prepareStatement("SELECT COUNT(*) FROM student").executeQuery();
            if (rs.next()) {
                int c = rs.getInt(1);
                conn.close();
                return c;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // MAP ResultSet row to Student object
    private Student mapRow(ResultSet rs) throws Exception {
        Student s = new Student();
        s.setId(rs.getInt("id"));
        s.setName(rs.getString("name"));
        s.setEmail(rs.getString("email"));
        s.setPassword(rs.getString("password"));
        try { s.setCourse(rs.getString("course")); }           catch (Exception e) {}
        try { s.setAddress(rs.getString("address")); }         catch (Exception e) {}
        try { s.setPhone(rs.getString("phone")); }             catch (Exception e) {}
        try { s.setFatherName(rs.getString("father_name")); }  catch (Exception e) {}
        try { s.setMotherName(rs.getString("mother_name")); }  catch (Exception e) {}
        try { s.setRegId(rs.getString("reg_id")); }            catch (Exception e) {}
        return s;
    }
}
