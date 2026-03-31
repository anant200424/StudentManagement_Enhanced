<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.student.model.*,com.student.dao.*,java.util.*" %>
<%
  Admin admin=(Admin)session.getAttribute("admin");
  if(admin==null){response.sendRedirect("adminLogin.jsp");return;}
  StudentDAO sdao=new StudentDAO();
  CourseDAO cdao=new CourseDAO();
  PaymentDAO pdao=new PaymentDAO();
  EnrollmentDAO edao=new EnrollmentDAO();
  int totalStudents=sdao.count();
  int totalCourses=cdao.count();
  int totalEnroll=edao.count();
  double totalPaid=pdao.getTotalCollected();
  List<Student> students=sdao.getAll();
  List<Payment> payments=pdao.getAll();
%>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><title>AdminDashboard — EduSphere</title>
<link href="https://fonts.googleapis.com/css2?family=Clash+Display:wght@500;600;700&family=Satoshi:wght@400;500;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
:root{--navy:#0a0f2c;--sb:#080d26;--card:#0f1530;--accent:#4f8ef7;--teal:#00d4aa;--gold:#f5c842;--rose:#ff6b8a;--purple:#7b6cf6;--green:#34d399;--border:rgba(255,255,255,.07);--text:#e8eaf6;--muted:#8892b0;}
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Satoshi',sans-serif;background:var(--navy);color:var(--text);display:flex;min-height:100vh;}
.sb{width:250px;min-height:100vh;background:var(--sb);border-right:1px solid var(--border);padding:22px 0;display:flex;flex-direction:column;position:fixed;top:0;left:0;z-index:50;}
.sb-brand{display:flex;align-items:center;gap:10px;padding:0 22px 22px;border-bottom:1px solid var(--border);}
.brand-ic{width:34px;height:34px;border-radius:9px;background:linear-gradient(135deg,var(--purple),var(--accent));display:flex;align-items:center;justify-content:center;color:#fff;font-size:.95rem;}
.brand-txt{font-family:'Clash Display',sans-serif;font-size:1.05rem;font-weight:700;background:linear-gradient(135deg,var(--accent),var(--teal));-webkit-background-clip:text;-webkit-text-fill-color:transparent;}
.brand-sub{font-size:.62rem;color:var(--muted);-webkit-text-fill-color:var(--muted);}
.sec{padding:16px 22px 5px;font-size:.6rem;font-weight:700;letter-spacing:1.5px;text-transform:uppercase;color:#2a3460;}
.ni{display:flex;align-items:center;gap:10px;padding:9px 22px;font-size:.85rem;color:var(--muted);text-decoration:none;transition:all .2s;}
.ni:hover{color:#fff;background:rgba(255,255,255,.03);}
.ni.active{color:var(--accent);background:rgba(79,142,247,.08);border-right:3px solid var(--accent);}
.ni-ic{width:16px;text-align:center;}
.sb-bot{margin-top:auto;padding:16px 22px;border-top:1px solid var(--border);}
.ai-info{display:flex;align-items:center;gap:10px;margin-bottom:13px;}
.av{width:34px;height:34px;border-radius:50%;background:linear-gradient(135deg,var(--rose),var(--purple));display:flex;align-items:center;justify-content:center;font-weight:700;font-size:.82rem;color:#fff;flex-shrink:0;}
.an{font-size:.84rem;font-weight:600;color:#fff;}
.ar{font-size:.68rem;color:var(--muted);}
.lo-btn{display:flex;align-items:center;gap:8px;width:100%;padding:8px 12px;border-radius:8px;border:1px solid rgba(255,107,138,.2);background:rgba(255,107,138,.08);color:var(--rose);font-size:.78rem;font-weight:600;cursor:pointer;font-family:'Satoshi',sans-serif;text-decoration:none;transition:all .2s;justify-content:center;}
.lo-btn:hover{background:rgba(255,107,138,.18);}
.main{margin-left:250px;flex:1;padding:26px 34px;}
.topbar{display:flex;justify-content:space-between;align-items:center;margin-bottom:28px;}
.topbar h1{font-family:'Clash Display',sans-serif;font-size:1.55rem;font-weight:700;color:#fff;}
.topbar p{font-size:.84rem;color:var(--muted);margin-top:3px;}
.sg{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:22px;}
.sc{background:var(--card);border:1px solid var(--border);border-radius:13px;padding:20px;position:relative;overflow:hidden;transition:all .3s;}
.sc:hover{transform:translateY(-3px);}
.sc::after{content:'';position:absolute;top:0;left:0;right:0;height:2px;}
.sc.c1::after{background:linear-gradient(90deg,var(--accent),var(--purple));}
.sc.c2::after{background:linear-gradient(90deg,var(--teal),var(--green));}
.sc.c3::after{background:linear-gradient(90deg,var(--gold),var(--rose));}
.sc.c4::after{background:linear-gradient(90deg,var(--purple),var(--accent));}
.sc-top{display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:12px;}
.si{width:38px;height:38px;border-radius:9px;display:flex;align-items:center;justify-content:center;font-size:.95rem;}
.si.b{background:rgba(79,142,247,.15);color:var(--accent);}
.si.t{background:rgba(0,212,170,.15);color:var(--teal);}
.si.g{background:rgba(245,200,66,.15);color:var(--gold);}
.si.p{background:rgba(123,108,246,.15);color:var(--purple);}
.tr{font-size:.7rem;padding:3px 7px;border-radius:10px;font-weight:700;}
.tu{background:rgba(52,211,153,.1);color:var(--green);}
.sv{font-family:'Clash Display',sans-serif;font-size:1.8rem;font-weight:700;color:#fff;}
.sl{font-size:.76rem;color:var(--muted);margin-top:2px;}
.g2{display:grid;grid-template-columns:3fr 2fr;gap:20px;margin-bottom:20px;}
.g3{display:grid;grid-template-columns:2fr 1fr;gap:20px;margin-bottom:20px;}
.card{background:var(--card);border:1px solid var(--border);border-radius:13px;padding:20px;}
.ch{display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;}
.ct{font-family:'Clash Display',sans-serif;font-size:.92rem;font-weight:600;color:#fff;}
.ca{font-size:.76rem;color:var(--accent);text-decoration:none;}
.ca:hover{color:var(--teal);}
table{width:100%;border-collapse:collapse;}
th{font-size:.7rem;font-weight:700;letter-spacing:.8px;text-transform:uppercase;color:var(--muted);padding:9px 12px;text-align:left;border-bottom:1px solid var(--border);}
td{padding:11px 12px;font-size:.83rem;color:var(--text);border-bottom:1px solid var(--border);}
tr:last-child td{border-bottom:none;}
tr:hover td{background:rgba(255,255,255,.015);}
.badge{padding:3px 9px;border-radius:11px;font-size:.66rem;font-weight:700;}
.bs{background:rgba(52,211,153,.12);color:var(--green);}
.bp{background:rgba(255,107,138,.12);color:var(--rose);}
.ba{background:rgba(79,142,247,.12);color:var(--accent);}
.ab-btn{padding:5px 11px;border-radius:7px;font-size:.73rem;font-weight:600;border:none;cursor:pointer;font-family:'Satoshi',sans-serif;transition:all .2s;text-decoration:none;display:inline-block;}
.btn-e{background:rgba(79,142,247,.12);color:var(--accent);}
.btn-e:hover{background:rgba(79,142,247,.25);}
.btn-d{background:rgba(255,107,138,.12);color:var(--rose);}
.btn-d:hover{background:rgba(255,107,138,.25);}
.qa-grid{display:grid;grid-template-columns:1fr 1fr;gap:9px;}
.qa{display:flex;align-items:center;gap:10px;padding:12px;border-radius:10px;border:1px solid var(--border);background:rgba(255,255,255,.02);text-decoration:none;transition:all .2s;}
.qa:hover{border-color:var(--accent);background:rgba(79,142,247,.05);}
.qa-ic{width:30px;height:30px;border-radius:8px;display:flex;align-items:center;justify-content:center;font-size:.82rem;flex-shrink:0;}
.qa-txt{font-size:.8rem;font-weight:600;color:#fff;}
.ai-item{display:flex;align-items:flex-start;gap:9px;padding:10px 0;border-bottom:1px solid var(--border);}
.ai-item:last-child{border-bottom:none;}
.ai-dot{width:7px;height:7px;border-radius:50%;flex-shrink:0;margin-top:5px;}
.ai-msg{font-size:.8rem;color:var(--muted);line-height:1.5;}
.ai-msg strong{color:#fff;}
</style></head><body>
<aside class="sb">
  <div class="sb-brand"><div class="brand-ic"><i class="fas fa-graduation-cap"></i></div><div><div class="brand-txt">EduSphere</div><div class="brand-sub">Admin Panel</div></div></div>
  <div class="sec">Overview</div>
  <a href="adminDashboard.jsp" class="ni active"><span class="ni-ic"><i class="fas fa-th-large"></i></span> Dashboard</a>
  <div class="sec">Students</div>
  <a href="StudentServlet" class="ni"><span class="ni-ic"><i class="fas fa-users"></i></span> All Students</a>
  <div class="sec">Academics</div>
  <a href="adminEnrollments.jsp" class="ni"><span class="ni-ic"><i class="fas fa-list-check"></i></span> Enrollments</a>
  <a href="adminCourses.jsp" class="ni"><span class="ni-ic"><i class="fas fa-book"></i></span> Courses</a>
  <div class="sec">Finance</div>
  <a href="adminPayments.jsp" class="ni"><span class="ni-ic"><i class="fas fa-rupee-sign"></i></span> All Payments</a>
  <div class="sec">System</div>
  <a href="home.jsp" class="ni"><span class="ni-ic"><i class="fas fa-home"></i></span> Home Page</a>
  <div class="sb-bot">
    <div class="ai-info"><div class="av">A</div><div><div class="an"><%=admin.getName()%></div><div class="ar">Super Admin</div></div></div>
    <a href="AdminLogoutServlet" class="lo-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
  </div>
</aside>
<main class="main">
  <div class="topbar"><div><h1>Admin Dashboard</h1><p>Institution overview — <%=new java.util.Date().toString().substring(0,10)%></p></div><div class="av">A</div></div>
  <div class="sg">
    <div class="sc c1"><div class="sc-top"><div class="si b"><i class="fas fa-users"></i></div><span class="tr tu">Live</span></div><div class="sv"><%=totalStudents%></div><div class="sl">Total Students</div></div>
    <div class="sc c2"><div class="sc-top"><div class="si t"><i class="fas fa-book"></i></div><span class="tr tu">Active</span></div><div class="sv"><%=totalCourses%></div><div class="sl">Total Courses</div></div>
    <div class="sc c3"><div class="sc-top"><div class="si g"><i class="fas fa-rupee-sign"></i></div><span class="tr tu">Collected</span></div><div class="sv">₹<%=String.format("%.0f",totalPaid/1000)%>K</div><div class="sl">Fees Collected</div></div>
    <div class="sc c4"><div class="sc-top"><div class="si p"><i class="fas fa-list"></i></div><span class="tr tu">Total</span></div><div class="sv"><%=totalEnroll%></div><div class="sl">Enrollments</div></div>
  </div>
  <div class="g2">
    <div class="card">
      <div class="ch"><span class="ct">Fee Collection Trend</span></div>
      <canvas id="barChart" height="220"></canvas>
    </div>
    <div class="card">
      <div class="ch"><span class="ct">Payment Status</span></div>
      <canvas id="pieChart" height="180"></canvas>
    </div>
  </div>
  <div class="g3">
    <div class="card">
      <div class="ch"><span class="ct">Recent Students</span><a href="StudentServlet" class="ca">View All →</a></div>
      <table>
        <thead><tr><th>Name</th><th>Email</th><th>Course</th><th>Actions</th></tr></thead>
        <tbody>
        <%int cnt=0;for(Student s:students){if(cnt++>=5)break;%>
          <tr>
            <td><%=s.getName()%></td>
            <td style="font-size:.78rem;color:var(--muted);"><%=s.getEmail()%></td>
            <td><%=s.getCourse()!=null?s.getCourse():"—"%></td>
            <td>
              <a href="StudentServlet?action=edit&id=<%=s.getId()%>" class="ab-btn btn-e">Edit</a>
              <a href="StudentServlet?action=delete&id=<%=s.getId()%>" class="ab-btn btn-d" onclick="return confirm('Delete this student?')">Del</a>
            </td>
          </tr>
        <%}%>
        </tbody>
      </table>
    </div>
    <div style="display:flex;flex-direction:column;gap:18px;">
      <div class="card">
        <div class="ch"><span class="ct">Quick Actions</span></div>
        <div class="qa-grid">
          <a href="StudentServlet" class="qa"><div class="qa-ic" style="background:rgba(79,142,247,.14);color:var(--accent);"><i class="fas fa-users"></i></div><span class="qa-txt">Students</span></a>
          <a href="adminPayments.jsp" class="qa"><div class="qa-ic" style="background:rgba(245,200,66,.14);color:var(--gold);"><i class="fas fa-rupee-sign"></i></div><span class="qa-txt">Payments</span></a>
          <a href="adminEnrollments.jsp" class="qa"><div class="qa-ic" style="background:rgba(0,212,170,.14);color:var(--teal);"><i class="fas fa-list"></i></div><span class="qa-txt">Enrollments</span></a>
          <a href="adminCourses.jsp" class="qa"><div class="qa-ic" style="background:rgba(123,108,246,.14);color:var(--purple);"><i class="fas fa-book"></i></div><span class="qa-txt">Courses</span></a>
        </div>
      </div>
      <div class="card">
        <div class="ch"><span class="ct" style="color:var(--teal);"><i class="fas fa-robot"></i> AI Alerts</span></div>
        <div class="ai-item"><div class="ai-dot" style="background:var(--rose);"></div><div class="ai-msg"><strong>Performance Risk:</strong> Check students with attendance below 75%.</div></div>
        <div class="ai-item"><div class="ai-dot" style="background:var(--gold);"></div><div class="ai-msg"><strong>Fees Due:</strong> Follow up on pending fee payments.</div></div>
        <div class="ai-item"><div class="ai-dot" style="background:var(--teal);"></div><div class="ai-msg"><strong>Enrollment Trend:</strong> CSE has highest demand this semester.</div></div>
      </div>
    </div>
  </div>
</main>
<script>
new Chart(document.getElementById('barChart').getContext('2d'),{type:'bar',data:{labels:['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],datasets:[{label:'Fees (₹K)',data:[80,120,100,150,180,140,200,160,190,220,170,210],backgroundColor:'rgba(79,142,247,.65)',borderRadius:5}]},options:{responsive:true,plugins:{legend:{labels:{color:'#8892b0',font:{family:'Satoshi'}}}},scales:{x:{grid:{color:'rgba(255,255,255,.03)'},ticks:{color:'#8892b0'}},y:{grid:{color:'rgba(255,255,255,.03)'},ticks:{color:'#8892b0'}}}}});
new Chart(document.getElementById('pieChart').getContext('2d'),{type:'doughnut',data:{labels:['Paid','Pending'],datasets:[{data:[74,26],backgroundColor:['rgba(0,212,170,.7)','rgba(255,107,138,.7)'],borderColor:['#00d4aa','#ff6b8a'],borderWidth:2}]},options:{cutout:'72%',plugins:{legend:{display:false}},responsive:true}});
</script>
</body></html>
