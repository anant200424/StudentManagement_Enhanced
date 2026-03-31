package com.student.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.student.dao.CourseDAO;
import com.student.dao.EnrollmentDAO;
import com.student.model.Student;

@WebServlet("/EnrollmentServlet")
public class EnrollmentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        CourseDAO courseDAO = new CourseDAO();
        req.setAttribute("courses", courseDAO.getAll());
        req.getRequestDispatcher("enrollCourse.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        Student student  = (Student) session.getAttribute("student");
        int courseId     = Integer.parseInt(req.getParameter("courseId"));

        EnrollmentDAO dao = new EnrollmentDAO();
        boolean ok        = dao.enroll(student.getId(), courseId);

        if (ok) {
            resp.sendRedirect("myEnrollments.jsp?enrolled=true");
        } else {
            resp.sendRedirect("enrollCourse.jsp?error=Already+enrolled+in+this+course");
        }
    }
}
