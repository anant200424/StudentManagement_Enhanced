package com.student.controller;

import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.student.dao.EnrollmentDAO;

@WebServlet("/AdminEnrollmentDeleteServlet")
public class AdminEnrollmentDeleteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            resp.sendRedirect("adminLogin.jsp");
            return;
        }
        int id = Integer.parseInt(req.getParameter("id"));
        new EnrollmentDAO().delete(id);
        resp.sendRedirect("adminEnrollments.jsp");
    }
}
