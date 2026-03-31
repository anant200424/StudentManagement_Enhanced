<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.student.model.*,com.student.dao.*,java.util.*" %>
<%
  Student student=(Student)session.getAttribute("student");
  if(student==null){response.sendRedirect("login.jsp");return;}
  PaymentDAO dao=new PaymentDAO();
  List<Payment> payments=dao.getByStudent(student.getId());
%>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><title>Payment History — EduSphere</title>
<link href="https://fonts.googleapis.com/css2?family=Clash+Display:wght@500;700&family=Satoshi:wght@400;500;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<style>
:root{--navy:#0a0f2c;--card:#0f1530;--accent:#4f8ef7;--teal:#00d4aa;--gold:#f5c842;--rose:#ff6b8a;--green:#34d399;--border:rgba(255,255,255,.08);--text:#e8eaf6;--muted:#8892b0;}
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Satoshi',sans-serif;background:var(--navy);color:var(--text);min-height:100vh;padding:36px 40px;background-image:radial-gradient(ellipse 60% 50% at 20% 20%,#1a2a6c28,transparent);}
.back{display:inline-flex;align-items:center;gap:8px;color:var(--muted);text-decoration:none;font-size:.85rem;margin-bottom:24px;transition:color .2s;}
.back:hover{color:var(--accent);}
.pt{font-family:'Clash Display',sans-serif;font-size:1.9rem;font-weight:700;color:#fff;margin-bottom:6px;}
.ps{color:var(--muted);font-size:.9rem;margin-bottom:32px;}
.alert{padding:12px 16px;border-radius:10px;font-size:.85rem;margin-bottom:20px;display:flex;align-items:center;gap:10px;background:rgba(0,212,170,.1);border:1px solid rgba(0,212,170,.2);color:var(--teal);}
.card{background:var(--card);border:1px solid var(--border);border-radius:16px;padding:26px;max-width:900px;}
table{width:100%;border-collapse:collapse;}
th{font-size:.72rem;font-weight:700;letter-spacing:.8px;text-transform:uppercase;color:var(--muted);padding:10px 14px;text-align:left;border-bottom:1px solid var(--border);}
td{padding:13px 14px;font-size:.86rem;color:var(--text);border-bottom:1px solid var(--border);}
tr:last-child td{border-bottom:none;}
tr:hover td{background:rgba(255,255,255,.02);}
.badge{padding:3px 10px;border-radius:12px;font-size:.68rem;font-weight:700;}
.bs{background:rgba(52,211,153,.12);color:var(--green);}
.bp{background:rgba(255,107,138,.12);color:var(--rose);}
.empty{text-align:center;padding:60px 20px;color:var(--muted);}
.empty i{font-size:3rem;margin-bottom:16px;opacity:.3;}
</style></head><body>
<a href="studentDashboard.jsp" class="back"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
<h1 class="pt"><i class="fas fa-receipt" style="color:var(--accent);"></i> Payment History</h1>
<p class="ps">All your fee payments — <%=student.getName()%></p>
<%if("true".equals(request.getParameter("success"))){%><div class="alert"><i class="fas fa-check-circle"></i> Payment recorded successfully!</div><%}%>
<div class="card">
<%if(payments.isEmpty()){%>
  <div class="empty"><i class="fas fa-receipt"></i><br>No payments found.<br><a href="PaymentServlet" style="color:var(--accent);font-size:.9rem;">Pay fees now →</a></div>
<%}else{%>
  <table>
    <thead><tr><th>#</th><th>Fee Type</th><th>Amount</th><th>Status</th><th>Payment ID</th><th>Date</th></tr></thead>
    <tbody>
    <%int i=1;for(Payment p:payments){%>
      <tr>
        <td><%=i++%></td>
        <td><%=p.getFeeType()%></td>
        <td style="font-weight:700;color:var(--green);">₹<%=String.format("%.2f",p.getAmount())%></td>
        <td><span class="badge <%="SUCCESS".equals(p.getStatus())?"bs":"bp"%>"><%=p.getStatus()%></span></td>
        <td style="font-size:.78rem;color:var(--muted);"><%=p.getRazorpayPaymentId()!=null?p.getRazorpayPaymentId():"N/A"%></td>
        <td style="font-size:.8rem;color:var(--muted);"><%=p.getPaidAt()!=null?p.getPaidAt().toString().substring(0,16):""%></td>
      </tr>
    <%}%>
    </tbody>
  </table>
<%}%>
</div>
</body></html>
