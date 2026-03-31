package com.student.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.student.dao.CourseDAO;
import com.student.model.Course;

@WebServlet("/AdminCourseServlet")
public class AdminCourseServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            resp.sendRedirect("adminLogin.jsp");
            return;
        }
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            new CourseDAO().delete(id);
        }
        resp.sendRedirect("adminCourses.jsp");
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            resp.sendRedirect("adminLogin.jsp");
            return;
        }
        Course c = new Course();
        c.setCourseName(req.getParameter("courseName"));
        c.setDuration(req.getParameter("duration"));
        c.setDescription(req.getParameter("description"));
        try {
            c.setFee(Double.parseDouble(req.getParameter("fee")));
        } catch (Exception e) {
            c.setFee(0);
        }
        new CourseDAO().add(c);
        resp.sendRedirect("adminCourses.jsp?added=true");
    }
}
