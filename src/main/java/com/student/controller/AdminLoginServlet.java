package com.student.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.student.dao.AdminDAO;
import com.student.model.Admin;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email    = req.getParameter("email");
        String password = req.getParameter("password");
        AdminDAO dao    = new AdminDAO();
        Admin admin     = dao.validateLogin(email, password);
        if (admin != null) {
            HttpSession session = req.getSession();
            session.setAttribute("admin",     admin);
            session.setAttribute("adminId",   admin.getId());
            session.setAttribute("adminName", admin.getName());
            resp.sendRedirect("adminDashboard.jsp");
        } else {
            req.setAttribute("error", "Invalid admin credentials!");
            req.getRequestDispatcher("adminLogin.jsp").forward(req, resp);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect("adminLogin.jsp");
    }
}
