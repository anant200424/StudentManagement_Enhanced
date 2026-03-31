<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.student.model.*,com.student.dao.*,java.util.*" %>
<%
  Admin admin=(Admin)session.getAttribute("admin");
  if(admin==null){response.sendRedirect("adminLogin.jsp");return;}
  EnrollmentDAO dao=new EnrollmentDAO();
  List<Map<String,String>> enrollments=dao.getAll();
%>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><title>All Enrollments — EduSphere Admin</title>
<link href="https://fonts.googleapis.com/css2?family=Clash+Display:wght@500;700&family=Satoshi:wght@400;500;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<style>
:root{--navy:#0a0f2c;--card:#0f1530;--accent:#4f8ef7;--teal:#00d4aa;--rose:#ff6b8a;--green:#34d399;--border:rgba(255,255,255,.08);--text:#e8eaf6;--muted:#8892b0;}
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Satoshi',sans-serif;background:var(--navy);color:var(--text);min-height:100vh;padding:36px 40px;background-image:radial-gradient(ellipse 60% 50% at 20% 20%,#1a2a6c28,transparent);}
.back{display:inline-flex;align-items:center;gap:8px;color:var(--muted);text-decoration:none;font-size:.85rem;margin-bottom:24px;transition:color .2s;}
.back:hover{color:var(--accent);}
.pt{font-family:'Clash Display',sans-serif;font-size:1.9rem;font-weight:700;color:#fff;margin-bottom:6px;}
.ps{color:var(--muted);font-size:.9rem;margin-bottom:28px;}
.total-badge{background:rgba(0,212,170,.12);color:var(--teal);padding:6px 16px;border-radius:20px;font-size:.82rem;font-weight:700;margin-bottom:20px;display:inline-block;}
.card{background:var(--card);border:1px solid var(--border);border-radius:14px;padding:22px;overflow-x:auto;}
table{width:100%;border-collapse:collapse;min-width:680px;}
th{font-size:.7rem;font-weight:700;letter-spacing:.8px;text-transform:uppercase;color:var(--muted);padding:10px 14px;text-align:left;border-bottom:1px solid var(--border);}
td{padding:12px 14px;font-size:.84rem;color:var(--text);border-bottom:1px solid var(--border);}
tr:last-child td{border-bottom:none;}
tr:hover td{background:rgba(255,255,255,.02);}
.badge{padding:3px 10px;border-radius:11px;font-size:.67rem;font-weight:700;}
.ba{background:rgba(79,142,247,.12);color:var(--accent);}
.btn-d{padding:5px 11px;border-radius:7px;font-size:.73rem;font-weight:600;border:none;cursor:pointer;font-family:'Satoshi',sans-serif;background:rgba(255,107,138,.12);color:var(--rose);text-decoration:none;display:inline-block;transition:all .2s;}
.btn-d:hover{background:rgba(255,107,138,.25);}
.empty{text-align:center;padding:60px;color:var(--muted);}
</style></head><body>
<a href="adminDashboard.jsp" class="back"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
<h1 class="pt"><i class="fas fa-list-check" style="color:var(--teal);"></i> All Enrollments</h1>
<p class="ps">All student course enrollments</p>
<div class="total-badge"><%=enrollments.size()%> Enrollments</div>
<div class="card">
<%if(enrollments.isEmpty()){%>
  <div class="empty"><i class="fas fa-list" style="font-size:2.5rem;opacity:.3;"></i><br><br>No enrollments found.</div>
<%}else{%>
  <table>
    <thead><tr><th>#</th><th>Student</th><th>Email</th><th>Course</th><th>Date</th><th>Status</th><th>Action</th></tr></thead>
    <tbody>
    <%int i=1;for(Map<String,String> e:enrollments){%>
      <tr>
        <td><%=i++%></td>
        <td><%=e.get("studentName")%></td>
        <td style="font-size:.78rem;color:var(--muted);"><%=e.get("email")%></td>
        <td><%=e.get("courseName")%></td>
        <td style="font-size:.78rem;color:var(--muted);"><%=e.get("date")!=null?e.get("date").substring(0,10):""%></td>
        <td><span class="badge ba"><%=e.get("status")%></span></td>
        <td><a href="AdminEnrollmentDeleteServlet?id=<%=e.get("id")%>" class="btn-d" onclick="return confirm('Remove enrollment?')"><i class="fas fa-trash"></i> Remove</a></td>
      </tr>
    <%}%>
    </tbody>
  </table>
<%}%>
</div>
</body></html>
