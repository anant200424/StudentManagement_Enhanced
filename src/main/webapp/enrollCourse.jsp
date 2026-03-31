<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.student.model.*,com.student.dao.*,java.util.*" %>
<%
  Student student=(Student)session.getAttribute("student");
  if(student==null){response.sendRedirect("login.jsp");return;}
  List<Course> courses=(List<Course>)request.getAttribute("courses");
  if(courses==null){courses=new CourseDAO().getAll();}
%>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><title>Enroll in Course — EduSphere</title>
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
.ae{padding:12px 16px;border-radius:10px;font-size:.85rem;margin-bottom:20px;display:flex;align-items:center;gap:10px;background:rgba(255,107,138,.1);border:1px solid rgba(255,107,138,.2);color:var(--rose);}
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(270px,1fr));gap:18px;max-width:1100px;}
.cc{background:var(--card);border:1px solid var(--border);border-radius:14px;padding:24px;transition:all .3s;position:relative;overflow:hidden;}
.cc::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;background:linear-gradient(90deg,var(--teal),var(--accent));}
.cc:hover{transform:translateY(-4px);border-color:rgba(79,142,247,.3);}
.cc-icon{width:44px;height:44px;border-radius:12px;background:rgba(0,212,170,.14);color:var(--teal);display:flex;align-items:center;justify-content:center;font-size:1.1rem;margin-bottom:14px;}
.cc-name{font-family:'Clash Display',sans-serif;font-size:1.05rem;font-weight:600;color:#fff;margin-bottom:6px;}
.cc-desc{font-size:.82rem;color:var(--muted);margin-bottom:10px;line-height:1.5;}
.cc-dur{font-size:.8rem;color:var(--muted);}
.cc-fee{font-size:.95rem;font-weight:700;color:var(--gold);margin-top:10px;margin-bottom:16px;}
.enroll-form button{width:100%;padding:11px;border-radius:9px;border:none;background:linear-gradient(135deg,var(--accent),var(--teal));color:#fff;font-family:'Satoshi',sans-serif;font-size:.88rem;font-weight:700;cursor:pointer;transition:all .3s;}
.enroll-form button:hover{transform:translateY(-1px);box-shadow:0 6px 20px rgba(79,142,247,.3);}
</style></head><body>
<a href="studentDashboard.jsp" class="back"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
<h1 class="pt"><i class="fas fa-graduation-cap" style="color:var(--teal);"></i> Browse Courses</h1>
<p class="ps">Select a course to enroll — <%=student.getName()%></p>
<%String err=request.getParameter("error");if(err!=null){%><div class="ae"><i class="fas fa-exclamation-circle"></i><%=err%></div><%}%>
<div class="grid">
<%for(Course c:courses){%>
  <div class="cc">
    <div class="cc-icon"><i class="fas fa-book"></i></div>
    <div class="cc-name"><%=c.getCourseName()%></div>
    <div class="cc-desc"><%=c.getDescription()!=null?c.getDescription():""%></div>
    <div class="cc-dur"><i class="fas fa-clock"></i> <%=c.getDuration()%></div>
    <div class="cc-fee"><i class="fas fa-rupee-sign"></i> <%=String.format("%.0f",c.getFee())%> / year</div>
    <form class="enroll-form" action="EnrollmentServlet" method="post">
      <input type="hidden" name="courseId" value="<%=c.getId()%>">
      <button type="submit"><i class="fas fa-plus-circle"></i> Enroll Now</button>
    </form>
  </div>
<%}%>
</div>
</body></html>
