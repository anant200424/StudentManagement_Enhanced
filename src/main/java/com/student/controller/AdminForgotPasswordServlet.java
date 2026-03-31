package com.student.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.student.dao.AdminDAO;

@WebServlet("/AdminForgotPasswordServlet")
public class AdminForgotPasswordServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect("adminForgotPassword.jsp");
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("verify".equals(action)) {
            String email  = req.getParameter("email");
            AdminDAO dao  = new AdminDAO();
            if (dao.emailExists(email)) {
                req.getSession().setAttribute("resetEmail", email);
                req.getSession().setAttribute("resetType",  "ADMIN");
                resp.sendRedirect("adminResetPassword.jsp");
            } else {
                req.setAttribute("error", "No admin account found with this email!");
                req.getRequestDispatcher("adminForgotPassword.jsp").forward(req, resp);
            }

        } else if ("reset".equals(action)) {
            HttpSession session = req.getSession(false);
            String email        = (String) session.getAttribute("resetEmail");
            String newPassword  = req.getParameter("newPassword");
            String confirm      = req.getParameter("confirmPassword");

            if (email == null) {
                resp.sendRedirect("adminForgotPassword.jsp");
                return;
            }
            if (!newPassword.equals(confirm)) {
                req.setAttribute("error", "Passwords do not match!");
                req.getRequestDispatcher("adminResetPassword.jsp").forward(req, resp);
                return;
            }

            AdminDAO dao = new AdminDAO();
            if (dao.updatePassword(email, newPassword)) {
                session.removeAttribute("resetEmail");
                session.removeAttribute("resetType");
                resp.sendRedirect("adminLogin.jsp?reset=true");
            } else {
                req.setAttribute("error", "Something went wrong. Try again.");
                req.getRequestDispatcher("adminResetPassword.jsp").forward(req, resp);
            }
        }
    }
}
