package com.student.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.student.dao.StudentDAO;
import com.student.model.Student;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email    = req.getParameter("email");
        String password = req.getParameter("password");
        StudentDAO dao  = new StudentDAO();
        Student student = dao.validateLogin(email, password);
        if (student != null) {
            HttpSession session = req.getSession();
            session.setAttribute("student", student);
            session.setAttribute("studentId",   student.getId());
            session.setAttribute("studentName", student.getName());
            resp.sendRedirect("studentDashboard.jsp");
        } else {
            req.setAttribute("error", "Invalid email or password!");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect("login.jsp");
    }
}
