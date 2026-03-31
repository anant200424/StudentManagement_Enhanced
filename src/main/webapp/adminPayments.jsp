<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.student.model.*,com.student.dao.*,java.util.*" %>
<%
  Admin admin=(Admin)session.getAttribute("admin");
  if(admin==null){response.sendRedirect("adminLogin.jsp");return;}
  PaymentDAO dao=new PaymentDAO();
  List<Payment> payments=dao.getAll();
  double total=dao.getTotalCollected();
%>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><title>All Payments — EduSphere Admin</title>
<link href="https://fonts.googleapis.com/css2?family=Clash+Display:wght@500;700&family=Satoshi:wght@400;500;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<style>
:root{--navy:#0a0f2c;--card:#0f1530;--accent:#4f8ef7;--teal:#00d4aa;--gold:#f5c842;--rose:#ff6b8a;--green:#34d399;--border:rgba(255,255,255,.08);--text:#e8eaf6;--muted:#8892b0;}
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Satoshi',sans-serif;background:var(--navy);color:var(--text);min-height:100vh;padding:36px 40px;background-image:radial-gradient(ellipse 60% 50% at 20% 20%,#2a1a6c28,transparent);}
.back{display:inline-flex;align-items:center;gap:8px;color:var(--muted);text-decoration:none;font-size:.85rem;margin-bottom:24px;transition:color .2s;}
.back:hover{color:var(--accent);}
.pt{font-family:'Clash Display',sans-serif;font-size:1.9rem;font-weight:700;color:#fff;margin-bottom:6px;}
.ps{color:var(--muted);font-size:.9rem;margin-bottom:28px;}
.sum-box{display:inline-flex;align-items:center;gap:12px;padding:16px 24px;border-radius:13px;background:var(--card);border:1px solid var(--border);margin-bottom:24px;}
.sum-ic{width:40px;height:40px;border-radius:10px;background:rgba(245,200,66,.15);color:var(--gold);display:flex;align-items:center;justify-content:center;font-size:1.1rem;}
.sum-lbl{font-size:.78rem;color:var(--muted);}
.sum-val{font-family:'Clash Display',sans-serif;font-size:1.4rem;font-weight:700;color:var(--gold);}
.card{background:var(--card);border:1px solid var(--border);border-radius:14px;padding:22px;overflow-x:auto;}
table{width:100%;border-collapse:collapse;min-width:750px;}
th{font-size:.7rem;font-weight:700;letter-spacing:.8px;text-transform:uppercase;color:var(--muted);padding:10px 14px;text-align:left;border-bottom:1px solid var(--border);}
td{padding:12px 14px;font-size:.84rem;color:var(--text);border-bottom:1px solid var(--border);}
tr:last-child td{border-bottom:none;}
tr:hover td{background:rgba(255,255,255,.02);}
.badge{padding:3px 10px;border-radius:11px;font-size:.67rem;font-weight:700;}
.bs{background:rgba(52,211,153,.12);color:var(--green);}
.bp{background:rgba(255,107,138,.12);color:var(--rose);}
.empty{text-align:center;padding:60px;color:var(--muted);}
</style></head><body>
<a href="adminDashboard.jsp" class="back"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
<h1 class="pt"><i class="fas fa-rupee-sign" style="color:var(--gold);"></i> All Payments</h1>
<p class="ps">Complete fee payment records across all students</p>
<div class="sum-box">
  <div class="sum-ic"><i class="fas fa-rupee-sign"></i></div>
  <div><div class="sum-lbl">Total Collected</div><div class="sum-val">₹<%=String.format("%.2f",total)%></div></div>
</div>
<div class="card">
<%if(payments.isEmpty()){%>
  <div class="empty"><i class="fas fa-receipt" style="font-size:2.5rem;opacity:.3;"></i><br><br>No payments found.</div>
<%}else{%>
  <table>
    <thead><tr><th>#</th><th>Student</th><th>Fee Type</th><th>Amount</th><th>Status</th><th>Payment ID</th><th>Date</th></tr></thead>
    <tbody>
    <%int i=1;for(Payment p:payments){%>
      <tr>
        <td><%=i++%></td>
        <td><%=p.getStudentName()!=null?p.getStudentName():"—"%></td>
        <td><%=p.getFeeType()%></td>
        <td style="font-weight:700;color:var(--green);">₹<%=String.format("%.2f",p.getAmount())%></td>
        <td><span class="badge <%="SUCCESS".equals(p.getStatus())?"bs":"bp"%>"><%=p.getStatus()%></span></td>
        <td style="font-size:.75rem;color:var(--muted);"><%=p.getRazorpayPaymentId()!=null?p.getRazorpayPaymentId():"N/A"%></td>
        <td style="font-size:.78rem;color:var(--muted);"><%=p.getPaidAt()!=null?p.getPaidAt().toString().substring(0,16):""%></td>
      </tr>
    <%}%>
    </tbody>
  </table>
<%}%>
</div>
</body></html>
