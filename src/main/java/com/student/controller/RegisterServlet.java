package com.student.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.student.dao.StudentDAO;
import com.student.model.Student;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String firstName  = req.getParameter("firstName");
        String lastName   = req.getParameter("lastName");
        String email      = req.getParameter("email");
        String password   = req.getParameter("password");
        String confirm    = req.getParameter("confirmPassword");
        String course     = req.getParameter("course");
        String phone      = req.getParameter("phone");
        String address    = req.getParameter("address");
        String fatherName = req.getParameter("fatherName");
        String motherName = req.getParameter("motherName");

        if (password == null || !password.equals(confirm)) {
            req.setAttribute("error", "Passwords do not match!");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        StudentDAO dao = new StudentDAO();
        if (dao.emailExists(email)) {
            req.setAttribute("error", "Email already registered! Please login.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        Student s = new Student();
        s.setName(firstName + " " + lastName);
        s.setEmail(email);
        s.setPassword(password);
        s.setCourse(course   != null ? course      : "");
        s.setPhone(phone     != null ? phone       : "");
        s.setAddress(address != null ? address     : "");
        s.setFatherName(fatherName != null ? fatherName : "N/A");
        s.setMotherName(motherName != null ? motherName : "N/A");
        s.setRegId("REG" + System.currentTimeMillis());

        if (dao.register(s)) {
            resp.sendRedirect("login.jsp?registered=true");
        } else {
            req.setAttribute("error", "Registration failed. Try again.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect("register.jsp");
    }
}
