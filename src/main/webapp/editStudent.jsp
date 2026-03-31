<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.student.model.*" %>
<%
  Admin admin=(Admin)session.getAttribute("admin");
  if(admin==null){response.sendRedirect("adminLogin.jsp");return;}
  Student s=(Student)request.getAttribute("student");
  if(s==null){response.sendRedirect("StudentServlet");return;}
%>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><title>Edit Student — EduSphere</title>
<link href="https://fonts.googleapis.com/css2?family=Clash+Display:wght@500;700&family=Satoshi:wght@400;500;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<style>
:root{--navy:#0a0f2c;--card:#0f1530;--accent:#4f8ef7;--teal:#00d4aa;--gold:#f5c842;--rose:#ff6b8a;--purple:#7b6cf6;--border:rgba(255,255,255,.08);--text:#e8eaf6;--muted:#8892b0;}
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Satoshi',sans-serif;background:var(--navy);color:var(--text);min-height:100vh;display:flex;align-items:center;justify-content:center;padding:40px 20px;background-image:radial-gradient(ellipse 60% 50% at 20% 20%,#2a1a6c28,transparent);}
.card{width:100%;max-width:560px;background:var(--card);border:1px solid var(--border);border-radius:20px;padding:36px 38px;}
.back{display:inline-flex;align-items:center;gap:8px;color:var(--muted);text-decoration:none;font-size:.82rem;margin-bottom:22px;transition:color .2s;}
.back:hover{color:var(--accent);}
.ct{font-family:'Clash Display',sans-serif;font-size:1.5rem;font-weight:700;color:#fff;margin-bottom:6px;}
.cs{font-size:.86rem;color:var(--muted);margin-bottom:26px;}
.row2{display:grid;grid-template-columns:1fr 1fr;gap:14px;}
.fg{margin-bottom:16px;}
.fl{display:block;font-size:.8rem;font-weight:600;color:var(--muted);margin-bottom:7px;}
.iw{position:relative;}
.ii{position:absolute;left:13px;top:50%;transform:translateY(-50%);color:var(--muted);font-size:.83rem;pointer-events:none;}
.fi{width:100%;padding:11px 12px 11px 37px;background:rgba(255,255,255,.05);border:1.5px solid var(--border);border-radius:9px;color:var(--text);font-size:.88rem;font-family:'Satoshi',sans-serif;outline:none;transition:all .2s;}
.fi::placeholder{color:#4a5568;}
.fi:focus{border-color:var(--accent);}
select.fi{appearance:none;}
.btn{width:100%;padding:13px;border-radius:10px;border:none;background:linear-gradient(135deg,var(--accent),var(--purple));color:#fff;font-family:'Satoshi',sans-serif;font-size:.93rem;font-weight:700;cursor:pointer;transition:all .3s;display:flex;align-items:center;justify-content:center;gap:10px;margin-top:8px;box-shadow:0 6px 22px rgba(79,142,247,.3);}
.btn:hover{transform:translateY(-2px);}
</style></head><body>
<div class="card">
  <a href="StudentServlet" class="back"><i class="fas fa-arrow-left"></i> Back to Students</a>
  <h2 class="ct"><i class="fas fa-user-edit" style="color:var(--accent);"></i> Edit Student</h2>
  <p class="cs">Update student information — ID: <%=s.getId()%></p>
  <form action="StudentServlet" method="post">
    <input type="hidden" name="id" value="<%=s.getId()%>">
    <div class="row2">
      <div class="fg"><label class="fl">Full Name</label><div class="iw"><i class="fas fa-user ii"></i><input type="text" name="name" class="fi" value="<%=s.getName()%>" required></div></div>
      <div class="fg"><label class="fl">Email</label><div class="iw"><i class="fas fa-envelope ii"></i><input type="email" name="email" class="fi" value="<%=s.getEmail()%>" required></div></div>
    </div>
    <div class="row2">
      <div class="fg"><label class="fl">Phone</label><div class="iw"><i class="fas fa-phone ii"></i><input type="tel" name="phone" class="fi" value="<%=s.getPhone()!=null?s.getPhone():""%>"></div></div>
      <div class="fg"><label class="fl">Course</label><div class="iw"><i class="fas fa-book ii"></i>
        <select name="course" class="fi">
          <option <%="B.Tech CSE".equals(s.getCourse())?"selected":""%>>B.Tech CSE</option>
          <option <%="B.Tech ECE".equals(s.getCourse())?"selected":""%>>B.Tech ECE</option>
          <option <%="BCA".equals(s.getCourse())?"selected":""%>>BCA</option>
          <option <%="MBA".equals(s.getCourse())?"selected":""%>>MBA</option>
          <option <%="B.Sc IT".equals(s.getCourse())?"selected":""%>>B.Sc IT</option>
          <option <%="MCA".equals(s.getCourse())?"selected":""%>>MCA</option>
        </select>
      </div></div>
    </div>
    <div class="fg"><label class="fl">Address</label><div class="iw"><i class="fas fa-map-marker-alt ii"></i><input type="text" name="address" class="fi" value="<%=s.getAddress()!=null?s.getAddress():""%>"></div></div>
    <div class="row2">
      <div class="fg"><label class="fl">Father's Name</label><div class="iw"><i class="fas fa-user ii"></i><input type="text" name="fatherName" class="fi" value="<%=s.getFatherName()!=null?s.getFatherName():""%>"></div></div>
      <div class="fg"><label class="fl">Mother's Name</label><div class="iw"><i class="fas fa-user ii"></i><input type="text" name="motherName" class="fi" value="<%=s.getMotherName()!=null?s.getMotherName():""%>"></div></div>
    </div>
    <button type="submit" class="btn"><i class="fas fa-save"></i> Save Changes</button>
  </form>
</div>
</body></html>
