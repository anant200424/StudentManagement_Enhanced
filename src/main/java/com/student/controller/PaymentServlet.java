package com.student.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.student.dao.PaymentDAO;
import com.student.model.Student;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        req.getRequestDispatcher("payFees.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        Student student        = (Student) session.getAttribute("student");
        int     studentId      = student.getId();
        String  feeType        = req.getParameter("feeType");
        String  amountStr      = req.getParameter("amount");
        String  razorpayPayId  = req.getParameter("razorpay_payment_id");
        String  razorpayOrdId  = req.getParameter("razorpay_order_id");

        if (feeType == null)       feeType       = "Fee Payment";
        if (razorpayPayId == null) razorpayPayId = "N/A";
        if (razorpayOrdId == null) razorpayOrdId = "N/A";

        double amount = 0;
        try { amount = Double.parseDouble(amountStr); } catch (Exception e) { amount = 0; }

        PaymentDAO dao = new PaymentDAO();
        boolean ok     = dao.save(studentId, feeType, amount, razorpayPayId, razorpayOrdId);

        if (ok) {
            resp.sendRedirect("paymentHistory.jsp?success=true");
        } else {
            resp.sendRedirect("payFees.jsp?error=true");
        }
    }
}
