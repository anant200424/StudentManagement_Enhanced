<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.student.model.*,com.student.dao.*,java.util.*" %>
<%
  Student student=(Student)session.getAttribute("student");
  if(student==null){response.sendRedirect("login.jsp");return;}
  EnrollmentDAO dao=new EnrollmentDAO();
  List<Map<String,String>> enrollments=dao.getByStudent(student.getId());
%>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><title>My Enrollments — EduSphere</title>
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
.alert-ok{padding:12px 16px;border-radius:10px;font-size:.85rem;margin-bottom:20px;display:flex;align-items:center;gap:10px;background:rgba(0,212,170,.1);border:1px solid rgba(0,212,170,.2);color:var(--teal);}
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(280px,1fr));gap:18px;max-width:1000px;}
.ec{background:var(--card);border:1px solid var(--border);border-radius:14px;padding:24px;transition:all .3s;position:relative;overflow:hidden;}
.ec::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;background:linear-gradient(90deg,var(--accent),var(--teal));}
.ec:hover{transform:translateY(-4px);}
.ec-icon{width:44px;height:44px;border-radius:12px;background:rgba(79,142,247,.14);color:var(--accent);display:flex;align-items:center;justify-content:center;font-size:1.1rem;margin-bottom:14px;}
.ec-name{font-family:'Clash Display',sans-serif;font-size:1.05rem;font-weight:600;color:#fff;margin-bottom:6px;}
.ec-dur{font-size:.8rem;color:var(--muted);}
.ec-fee{font-size:.88rem;font-weight:700;color:var(--gold);margin-top:8px;}
.badge{display:inline-block;padding:3px 10px;border-radius:12px;font-size:.68rem;font-weight:700;margin-top:10px;}
.ba{background:rgba(79,142,247,.12);color:var(--accent);}
.enroll-btn{display:inline-flex;align-items:center;gap:8px;padding:12px 22px;border-radius:10px;background:linear-gradient(135deg,var(--accent),var(--teal));color:#fff;text-decoration:none;font-weight:700;font-size:.88rem;margin-top:28px;transition:all .3s;}
.enroll-btn:hover{transform:translateY(-2px);box-shadow:0 8px 24px rgba(79,142,247,.3);}
.empty{text-align:center;padding:60px 20px;color:var(--muted);}
.empty i{font-size:3rem;margin-bottom:16px;opacity:.3;}
</style></head><body>
<a href="studentDashboard.jsp" class="back"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
<h1 class="pt"><i class="fas fa-book-open" style="color:var(--teal);"></i> My Enrollments</h1>
<p class="ps">Courses you are enrolled in — <%=student.getName()%></p>
<%if("true".equals(request.getParameter("enrolled"))){%><div class="alert-ok"><i class="fas fa-check-circle"></i> Successfully enrolled in course!</div><%}%>
<%if(enrollments.isEmpty()){%>
  <div class="empty"><i class="fas fa-book"></i><br><br>You are not enrolled in any course yet.</div>
  <a href="EnrollmentServlet" class="enroll-btn"><i class="fas fa-plus"></i> Browse & Enroll Courses</a>
<%}else{%>
  <div class="grid">
    <%for(Map<String,String> e:enrollments){%>
    <div class="ec">
      <div class="ec-icon"><i class="fas fa-graduation-cap"></i></div>
      <div class="ec-name"><%=e.get("courseName")%></div>
      <div class="ec-dur"><i class="fas fa-clock"></i> <%=e.get("duration")%></div>
      <div class="ec-fee"><i class="fas fa-rupee-sign"></i> <%=String.format("%.0f",Double.parseDouble(e.get("fee")))%> / year</div>
      <span class="badge ba"><%=e.get("status")%></span>
    </div>
    <%}%>
  </div>
  <a href="EnrollmentServlet" class="enroll-btn"><i class="fas fa-plus"></i> Enroll in More Courses</a>
<%}%>
</body></html>
