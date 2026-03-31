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

@WebServlet("/StudentServlet")
public class StudentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            resp.sendRedirect("adminLogin.jsp");
            return;
        }

        String action      = req.getParameter("action");
        StudentDAO dao     = new StudentDAO();

        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.delete(id);
            resp.sendRedirect("manageStudents.jsp?deleted=true");

        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            req.setAttribute("student", dao.getById(id));
            req.getRequestDispatcher("editStudent.jsp").forward(req, resp);

        } else {
            req.setAttribute("students", dao.getAll());
            req.getRequestDispatcher("manageStudents.jsp").forward(req, resp);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            resp.sendRedirect("adminLogin.jsp");
            return;
        }

        Student s = new Student();
        s.setId(Integer.parseInt(req.getParameter("id")));
        s.setName(req.getParameter("name"));
        s.setEmail(req.getParameter("email"));
        s.setCourse(req.getParameter("course"));
        s.setAddress(req.getParameter("address"));
        s.setPhone(req.getParameter("phone"));
        s.setFatherName(req.getParameter("fatherName"));
        s.setMotherName(req.getParameter("motherName"));

        StudentDAO dao = new StudentDAO();
        dao.update(s);
        resp.sendRedirect("manageStudents.jsp?updated=true");
    }
}
