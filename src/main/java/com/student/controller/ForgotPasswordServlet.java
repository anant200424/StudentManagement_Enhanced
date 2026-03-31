package com.student.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.student.dao.StudentDAO;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect("forgotPassword.jsp");
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("verify".equals(action)) {
            String email   = req.getParameter("email");
            StudentDAO dao = new StudentDAO();
            if (dao.emailExists(email)) {
                req.getSession().setAttribute("resetEmail", email);
                req.getSession().setAttribute("resetType",  "STUDENT");
                resp.sendRedirect("resetPassword.jsp");
            } else {
                req.setAttribute("error", "No account found with this email!");
                req.getRequestDispatcher("forgotPassword.jsp").forward(req, resp);
            }

        } else if ("reset".equals(action)) {
            HttpSession session = req.getSession(false);
            String email        = (String) session.getAttribute("resetEmail");
            String newPassword  = req.getParameter("newPassword");
            String confirm      = req.getParameter("confirmPassword");

            if (email == null) {
                resp.sendRedirect("forgotPassword.jsp");
                return;
            }
            if (!newPassword.equals(confirm)) {
                req.setAttribute("error", "Passwords do not match!");
                req.getRequestDispatcher("resetPassword.jsp").forward(req, resp);
                return;
            }

            StudentDAO dao = new StudentDAO();
            if (dao.updatePassword(email, newPassword)) {
                session.removeAttribute("resetEmail");
                session.removeAttribute("resetType");
                resp.sendRedirect("login.jsp?reset=true");
            } else {
                req.setAttribute("error", "Something went wrong. Try again.");
                req.getRequestDispatcher("resetPassword.jsp").forward(req, resp);
            }
        }
    }
}
