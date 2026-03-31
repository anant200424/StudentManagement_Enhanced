<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.student.model.*,com.student.dao.*,java.util.*" %>
<%
  Admin admin=(Admin)session.getAttribute("admin");
  if(admin==null){response.sendRedirect("adminLogin.jsp");return;}
  CourseDAO dao=new CourseDAO();
  List<Course> courses=dao.getAll();
%>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><title>Manage Courses — EduSphere Admin</title>
<link href="https://fonts.googleapis.com/css2?family=Clash+Display:wght@500;700&family=Satoshi:wght@400;500;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<style>
:root{--navy:#0a0f2c;--card:#0f1530;--accent:#4f8ef7;--teal:#00d4aa;--gold:#f5c842;--rose:#ff6b8a;--purple:#7b6cf6;--border:rgba(255,255,255,.08);--text:#e8eaf6;--muted:#8892b0;}
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Satoshi',sans-serif;background:var(--navy);color:var(--text);min-height:100vh;padding:36px 40px;background-image:radial-gradient(ellipse 60% 50% at 20% 20%,#1a2a6c28,transparent);}
.back{display:inline-flex;align-items:center;gap:8px;color:var(--muted);text-decoration:none;font-size:.85rem;margin-bottom:24px;transition:color .2s;}
.back:hover{color:var(--accent);}
.pt{font-family:'Clash Display',sans-serif;font-size:1.9rem;font-weight:700;color:#fff;margin-bottom:6px;}
.ps{color:var(--muted);font-size:.9rem;margin-bottom:28px;}
.layout{display:grid;grid-template-columns:2fr 1fr;gap:24px;max-width:1000px;}
.card{background:var(--card);border:1px solid var(--border);border-radius:14px;padding:22px;}
.ct{font-family:'Clash Display',sans-serif;font-size:.95rem;font-weight:600;color:#fff;margin-bottom:18px;}
table{width:100%;border-collapse:collapse;}
th{font-size:.7rem;font-weight:700;letter-spacing:.8px;text-transform:uppercase;color:var(--muted);padding:10px 12px;text-align:left;border-bottom:1px solid var(--border);}
td{padding:12px;font-size:.84rem;color:var(--text);border-bottom:1px solid var(--border);}
tr:last-child td{border-bottom:none;}
tr:hover td{background:rgba(255,255,255,.02);}
.btn-d{padding:5px 11px;border-radius:7px;font-size:.73rem;font-weight:600;border:none;cursor:pointer;font-family:'Satoshi',sans-serif;background:rgba(255,107,138,.12);color:var(--rose);text-decoration:none;display:inline-block;}
.btn-d:hover{background:rgba(255,107,138,.25);}
.fg{margin-bottom:14px;}
.fl{display:block;font-size:.8rem;font-weight:600;color:var(--muted);margin-bottom:7px;}
.fi{width:100%;padding:10px 12px;background:rgba(255,255,255,.05);border:1.5px solid var(--border);border-radius:9px;color:var(--text);font-size:.87rem;font-family:'Satoshi',sans-serif;outline:none;transition:all .2s;}
.fi::placeholder{color:#4a5568;}
.fi:focus{border-color:var(--accent);}
.btn{width:100%;padding:12px;border-radius:9px;border:none;background:linear-gradient(135deg,var(--accent),var(--purple));color:#fff;font-family:'Satoshi',sans-serif;font-size:.9rem;font-weight:700;cursor:pointer;transition:all .3s;margin-top:6px;}
.btn:hover{transform:translateY(-1px);}
.aok{padding:10px 14px;border-radius:9px;font-size:.83rem;margin-bottom:14px;display:flex;align-items:center;gap:9px;background:rgba(0,212,170,.1);border:1px solid rgba(0,212,170,.2);color:var(--teal);}
</style></head><body>
<a href="adminDashboard.jsp" class="back"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
<h1 class="pt"><i class="fas fa-book" style="color:var(--teal);"></i> Manage Courses</h1>
<p class="ps">View all courses and add new ones</p>
<div class="layout">
  <div class="card">
    <div class="ct">All Courses (<%=courses.size()%>)</div>
    <table>
      <thead><tr><th>#</th><th>Course</th><th>Duration</th><th>Fee/Year</th><th>Action</th></tr></thead>
      <tbody>
      <%int i=1;for(Course c:courses){%>
        <tr>
          <td><%=i++%></td>
          <td><%=c.getCourseName()%></td>
          <td><%=c.getDuration()%></td>
          <td style="color:var(--gold);font-weight:700;">₹<%=String.format("%.0f",c.getFee())%></td>
          <td><a href="AdminCourseServlet?action=delete&id=<%=c.getId()%>" class="btn-d" onclick="return confirm('Delete this course?')"><i class="fas fa-trash"></i></a></td>
        </tr>
      <%}%>
      </tbody>
    </table>
  </div>
  <div class="card">
    <div class="ct">Add New Course</div>
    <%if("true".equals(request.getParameter("added"))){%><div class="aok"><i class="fas fa-check-circle"></i> Course added!</div><%}%>
    <form action="AdminCourseServlet" method="post">
      <input type="hidden" name="action" value="add">
      <div class="fg"><label class="fl">Course Name</label><input type="text" name="courseName" class="fi" placeholder="e.g. B.Tech CSE" required></div>
      <div class="fg"><label class="fl">Duration</label><input type="text" name="duration" class="fi" placeholder="e.g. 4 Years" required></div>
      <div class="fg"><label class="fl">Fee per Year (₹)</label><input type="number" name="fee" class="fi" placeholder="e.g. 80000" required></div>
      <div class="fg"><label class="fl">Description</label><input type="text" name="description" class="fi" placeholder="Short description"></div>
      <button type="submit" class="btn"><i class="fas fa-plus"></i> Add Course</button>
    </form>
  </div>
</div>
</body></html>
