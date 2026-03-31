<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.student.model.*,com.student.dao.*,java.util.*" %>
<%
  Admin admin=(Admin)session.getAttribute("admin");
  if(admin==null){response.sendRedirect("adminLogin.jsp");return;}
  StudentDAO dao=new StudentDAO();
  List<Student> students=(List<Student>)request.getAttribute("students");
  if(students==null) students=dao.getAll();
%>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><title>Manage Students — EduSphere</title>
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
.alert{padding:11px 16px;border-radius:10px;font-size:.84rem;margin-bottom:18px;display:flex;align-items:center;gap:10px;}
.aok{background:rgba(0,212,170,.1);border:1px solid rgba(0,212,170,.2);color:var(--teal);}
.ae{background:rgba(255,107,138,.1);border:1px solid rgba(255,107,138,.2);color:var(--rose);}
.toprow{display:flex;justify-content:space-between;align-items:center;margin-bottom:18px;}
.search{padding:10px 14px;background:rgba(255,255,255,.05);border:1.5px solid var(--border);border-radius:9px;color:var(--text);font-size:.87rem;font-family:'Satoshi',sans-serif;outline:none;width:280px;transition:all .2s;}
.search:focus{border-color:var(--accent);}
.search::placeholder{color:#4a5568;}
.card{background:var(--card);border:1px solid var(--border);border-radius:14px;padding:22px;overflow-x:auto;}
table{width:100%;border-collapse:collapse;min-width:700px;}
th{font-size:.7rem;font-weight:700;letter-spacing:.8px;text-transform:uppercase;color:var(--muted);padding:10px 14px;text-align:left;border-bottom:1px solid var(--border);}
td{padding:12px 14px;font-size:.84rem;color:var(--text);border-bottom:1px solid var(--border);}
tr:last-child td{border-bottom:none;}
tr:hover td{background:rgba(255,255,255,.02);}
.av{width:32px;height:32px;border-radius:50%;background:linear-gradient(135deg,var(--accent),var(--teal));display:inline-flex;align-items:center;justify-content:center;font-size:.8rem;font-weight:700;color:#fff;flex-shrink:0;margin-right:8px;}
.ab{padding:5px 11px;border-radius:7px;font-size:.73rem;font-weight:600;border:none;cursor:pointer;font-family:'Satoshi',sans-serif;transition:all .2s;text-decoration:none;display:inline-block;margin-right:4px;}
.btn-e{background:rgba(79,142,247,.12);color:var(--accent);}
.btn-e:hover{background:rgba(79,142,247,.25);}
.btn-d{background:rgba(255,107,138,.12);color:var(--rose);}
.btn-d:hover{background:rgba(255,107,138,.25);}
.empty{text-align:center;padding:60px;color:var(--muted);}
.total-badge{background:rgba(79,142,247,.12);color:var(--accent);padding:5px 14px;border-radius:20px;font-size:.8rem;font-weight:700;}
</style></head><body>
<a href="adminDashboard.jsp" class="back"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
<h1 class="pt"><i class="fas fa-users" style="color:var(--accent);"></i> Manage Students</h1>
<p class="ps">View, edit and delete student records</p>
<%String del=request.getParameter("deleted");String upd=request.getParameter("updated");%>
<%if("true".equals(del)){%><div class="alert aok"><i class="fas fa-check-circle"></i> Student deleted successfully.</div><%}%>
<%if("true".equals(upd)){%><div class="alert aok"><i class="fas fa-check-circle"></i> Student updated successfully.</div><%}%>
<div class="toprow">
  <span class="total-badge"><%=students.size()%> Students</span>
  <input type="text" class="search" id="searchBox" placeholder="Search by name or email..." onkeyup="filterTable()">
</div>
<div class="card">
<%if(students.isEmpty()){%>
  <div class="empty"><i class="fas fa-users" style="font-size:2.5rem;opacity:.3;"></i><br><br>No students found.</div>
<%}else{%>
  <table id="stuTable">
    <thead><tr><th>#</th><th>Student</th><th>Email</th><th>Course</th><th>Reg ID</th><th>Actions</th></tr></thead>
    <tbody>
    <%int i=1;for(Student s:students){%>
      <tr>
        <td><%=i++%></td>
        <td><span class="av"><%=s.getName().substring(0,1).toUpperCase()%></span><%=s.getName()%></td>
        <td style="color:var(--muted);font-size:.8rem;"><%=s.getEmail()%></td>
        <td><%=s.getCourse()!=null?s.getCourse():"—"%></td>
        <td style="color:var(--muted);font-size:.78rem;"><%=s.getRegId()!=null?s.getRegId():"—"%></td>
        <td>
          <a href="StudentServlet?action=edit&id=<%=s.getId()%>" class="ab btn-e"><i class="fas fa-edit"></i> Edit</a>
          <a href="StudentServlet?action=delete&id=<%=s.getId()%>" class="ab btn-d" onclick="return confirm('Delete <%=s.getName()%>?')"><i class="fas fa-trash"></i> Delete</a>
        </td>
      </tr>
    <%}%>
    </tbody>
  </table>
<%}%>
</div>
<script>
function filterTable(){
  var q=document.getElementById('searchBox').value.toLowerCase();
  document.querySelectorAll('#stuTable tbody tr').forEach(function(r){
    r.style.display=r.innerText.toLowerCase().includes(q)?'':'none';
  });
}
</script>
</body></html>
