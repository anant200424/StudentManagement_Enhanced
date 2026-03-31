<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.student.model.Student,com.student.dao.PaymentDAO,com.student.dao.EnrollmentDAO,java.util.*" %>
<%
  HttpSession sess=session;
  Student student=(Student)sess.getAttribute("student");
  if(student==null){response.sendRedirect("login.jsp");return;}
  PaymentDAO pdao=new PaymentDAO();
  EnrollmentDAO edao=new EnrollmentDAO();
  int payCount=pdao.countByStudent(student.getId());
  List<Map<String,String>> enrollments=edao.getByStudent(student.getId());
  List<com.student.model.Payment> payments=pdao.getByStudent(student.getId());
  String successMsg=request.getParameter("msg");
%>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Student Dashboard — EduSphere</title>
<link href="https://fonts.googleapis.com/css2?family=Clash+Display:wght@500;600;700&family=Satoshi:wght@400;500;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
:root{--navy:#0a0f2c;--sb:#0c1235;--card:#0f1530;--accent:#4f8ef7;--teal:#00d4aa;--gold:#f5c842;--rose:#ff6b8a;--purple:#7b6cf6;--green:#34d399;--border:rgba(255,255,255,.07);--text:#e8eaf6;--muted:#8892b0;}
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Satoshi',sans-serif;background:var(--navy);color:var(--text);display:flex;min-height:100vh;}
/* SIDEBAR */
.sb{width:250px;min-height:100vh;background:var(--sb);border-right:1px solid var(--border);padding:24px 0;display:flex;flex-direction:column;position:fixed;top:0;left:0;z-index:50;}
.sb-logo{font-family:'Clash Display',sans-serif;font-size:1.3rem;font-weight:700;padding:0 24px 24px;border-bottom:1px solid var(--border);background:linear-gradient(135deg,var(--accent),var(--teal));-webkit-background-clip:text;-webkit-text-fill-color:transparent;text-decoration:none;display:block;}
.sec{padding:16px 24px 6px;font-size:.62rem;font-weight:700;letter-spacing:1.5px;text-transform:uppercase;color:#2a3460;}
.ni{display:flex;align-items:center;gap:11px;padding:10px 24px;font-size:.86rem;color:var(--muted);text-decoration:none;transition:all .2s;}
.ni:hover{color:#fff;background:rgba(255,255,255,.03);}
.ni.active{color:var(--accent);background:rgba(79,142,247,.08);border-right:3px solid var(--accent);}
.ni-ic{width:16px;text-align:center;font-size:.85rem;}
.nb{padding:3px 8px;border-radius:12px;font-size:.65rem;font-weight:700;background:rgba(255,107,138,.15);color:var(--rose);margin-left:auto;}
.sb-bot{margin-top:auto;padding:18px 24px;border-top:1px solid var(--border);}
.uinfo{display:flex;align-items:center;gap:10px;margin-bottom:14px;}
.av{width:36px;height:36px;border-radius:50%;background:linear-gradient(135deg,var(--accent),var(--purple));display:flex;align-items:center;justify-content:center;font-weight:700;font-size:.88rem;color:#fff;flex-shrink:0;}
.uname{font-size:.86rem;font-weight:600;color:#fff;}
.urole{font-size:.7rem;color:var(--muted);}
.lo-btn{display:flex;align-items:center;gap:8px;width:100%;padding:9px 14px;border-radius:9px;border:1px solid rgba(255,107,138,.2);background:rgba(255,107,138,.08);color:var(--rose);font-size:.8rem;font-weight:600;cursor:pointer;font-family:'Satoshi',sans-serif;text-decoration:none;transition:all .2s;justify-content:center;}
.lo-btn:hover{background:rgba(255,107,138,.18);}
/* MAIN */
.main{margin-left:250px;flex:1;padding:28px 36px;}
.topbar{display:flex;justify-content:space-between;align-items:center;margin-bottom:28px;}
.topbar h1{font-family:'Clash Display',sans-serif;font-size:1.6rem;font-weight:700;color:#fff;}
.topbar p{font-size:.85rem;color:var(--muted);margin-top:3px;}
/* ALERT */
.alert{padding:12px 16px;border-radius:10px;font-size:.85rem;margin-bottom:20px;display:flex;align-items:center;gap:10px;}
.aok{background:rgba(0,212,170,.1);border:1px solid rgba(0,212,170,.2);color:var(--teal);}
/* STATS */
.sg{display:grid;grid-template-columns:repeat(4,1fr);gap:18px;margin-bottom:24px;}
.sc{background:var(--card);border:1px solid var(--border);border-radius:14px;padding:22px;position:relative;overflow:hidden;transition:all .3s;}
.sc:hover{transform:translateY(-3px);}
.sc::after{content:'';position:absolute;top:0;left:0;right:0;height:2px;}
.sc.c1::after{background:linear-gradient(90deg,var(--accent),var(--purple));}
.sc.c2::after{background:linear-gradient(90deg,var(--teal),var(--green));}
.sc.c3::after{background:linear-gradient(90deg,var(--gold),var(--rose));}
.sc.c4::after{background:linear-gradient(90deg,var(--purple),var(--accent));}
.si{width:40px;height:40px;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:1rem;margin-bottom:14px;}
.si.b{background:rgba(79,142,247,.15);color:var(--accent);}
.si.t{background:rgba(0,212,170,.15);color:var(--teal);}
.si.g{background:rgba(245,200,66,.15);color:var(--gold);}
.si.p{background:rgba(123,108,246,.15);color:var(--purple);}
.sv{font-family:'Clash Display',sans-serif;font-size:1.9rem;font-weight:700;color:#fff;}
.sl{font-size:.78rem;color:var(--muted);margin-top:3px;}
/* CARD */
.card{background:var(--card);border:1px solid var(--border);border-radius:14px;padding:22px;}
.ch{display:flex;justify-content:space-between;align-items:center;margin-bottom:18px;}
.ct{font-family:'Clash Display',sans-serif;font-size:.95rem;font-weight:600;color:#fff;}
.ca{font-size:.78rem;color:var(--accent);text-decoration:none;}
.ca:hover{color:var(--teal);}
.g2{display:grid;grid-template-columns:2fr 1fr;gap:22px;margin-bottom:22px;}
.g3{display:grid;grid-template-columns:1fr 1fr 1fr;gap:22px;margin-bottom:22px;}
/* TABLE */
table{width:100%;border-collapse:collapse;}
th{font-size:.72rem;font-weight:700;letter-spacing:.8px;text-transform:uppercase;color:var(--muted);padding:10px 12px;text-align:left;border-bottom:1px solid var(--border);}
td{padding:12px;font-size:.85rem;color:var(--text);border-bottom:1px solid var(--border);}
tr:last-child td{border-bottom:none;}
.badge{padding:3px 9px;border-radius:12px;font-size:.68rem;font-weight:700;}
.bs{background:rgba(52,211,153,.12);color:var(--green);}
.ba{background:rgba(79,142,247,.12);color:var(--accent);}
.bp{background:rgba(255,107,138,.12);color:var(--rose);}
/* AI */
.ai-ring{width:100px;height:100px;border-radius:50%;background:conic-gradient(var(--teal) 0% 84%,rgba(255,255,255,.04) 84% 100%);display:flex;align-items:center;justify-content:center;margin:0 auto 14px;position:relative;}
.ai-ring::before{content:'';position:absolute;inset:10px;border-radius:50%;background:var(--card);}
.ai-score{position:relative;z-index:1;font-family:'Clash Display',sans-serif;font-size:1.4rem;font-weight:700;color:var(--teal);}
.ai-insight{background:rgba(0,212,170,.08);border:1px solid rgba(0,212,170,.15);border-radius:10px;padding:12px;margin-top:14px;font-size:.82rem;color:var(--muted);line-height:1.6;}
.ai-insight strong{color:var(--teal);}
.ai-btn{display:flex;align-items:center;justify-content:center;gap:8px;width:100%;padding:10px;border-radius:9px;margin-top:12px;background:rgba(0,212,170,.08);border:1px solid rgba(0,212,170,.15);color:var(--teal);font-size:.83rem;font-weight:700;cursor:pointer;text-decoration:none;transition:all .2s;}
.ai-btn:hover{background:rgba(0,212,170,.16);}
/* PAY BTN */
.pay-btn{display:flex;align-items:center;justify-content:center;gap:8px;width:100%;padding:12px;border-radius:10px;border:none;background:linear-gradient(135deg,var(--gold),var(--rose));color:#0a0f2c;font-family:'Satoshi',sans-serif;font-size:.88rem;font-weight:800;cursor:pointer;margin-top:16px;text-decoration:none;transition:all .3s;}
.pay-btn:hover{transform:translateY(-2px);box-shadow:0 8px 24px rgba(245,200,66,.3);}
/* PROGRESS */
.pi{margin-bottom:12px;}
.pm{display:flex;justify-content:space-between;font-size:.8rem;margin-bottom:5px;}
.pm span:first-child{color:var(--muted);}
.pm span:last-child{color:#fff;font-weight:600;}
.pb{height:6px;background:rgba(255,255,255,.05);border-radius:3px;overflow:hidden;}
.pf{height:100%;border-radius:3px;}
</style></head><body>
<!-- SIDEBAR -->
<aside class="sb">
  <a href="home.jsp" class="sb-logo">EduSphere</a>
  <div class="sec">Main</div>
  <a href="studentDashboard.jsp" class="ni active"><span class="ni-ic"><i class="fas fa-th-large"></i></span> Dashboard</a>
  <div class="sec">Academics</div>
  <a href="EnrollmentServlet" class="ni"><span class="ni-ic"><i class="fas fa-plus-circle"></i></span> Enroll Course</a>
  <a href="myEnrollments.jsp" class="ni"><span class="ni-ic"><i class="fas fa-book-open"></i></span> My Courses</a>
  <div class="sec">Finance</div>
  <a href="PaymentServlet" class="ni"><span class="ni-ic"><i class="fas fa-credit-card"></i></span> Pay Fees <span class="nb">Due</span></a>
  <a href="paymentHistory.jsp" class="ni"><span class="ni-ic"><i class="fas fa-receipt"></i></span> Payment History</a>
  <div class="sec">AI Tools</div>
  <a href="aiPredict.jsp" class="ni"><span class="ni-ic"><i class="fas fa-brain"></i></span> AI Predictor</a>
  <div class="sec">Account</div>
  <a href="home.jsp" class="ni"><span class="ni-ic"><i class="fas fa-home"></i></span> Home Page</a>
  <div class="sb-bot">
    <div class="uinfo">
      <div class="av"><%=student.getName().substring(0,1).toUpperCase()%></div>
      <div><div class="uname"><%=student.getName()%></div><div class="urole">Student</div></div>
    </div>
    <a href="LogoutServlet" class="lo-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
  </div>
</aside>
<!-- MAIN -->
<main class="main">
  <div class="topbar">
    <div><h1>Hello, <%=student.getName().split(" ")[0]%> 👋</h1><p>Welcome to your student dashboard</p></div>
    <div class="av"><%=student.getName().substring(0,1).toUpperCase()%></div>
  </div>
  <%if(successMsg!=null){%><div class="alert aok"><i class="fas fa-check-circle"></i><%=successMsg%></div><%}%>
  <!-- STATS -->
  <div class="sg">
    <div class="sc c1"><div class="si b"><i class="fas fa-book"></i></div><div class="sv"><%=enrollments.size()%></div><div class="sl">Enrolled Courses</div></div>
    <div class="sc c2"><div class="si t"><i class="fas fa-check-circle"></i></div><div class="sv"><%=payCount%></div><div class="sl">Payments Made</div></div>
    <div class="sc c3"><div class="si g"><i class="fas fa-star"></i></div><div class="sv">8.4</div><div class="sl">Current GPA</div></div>
    <div class="sc c4"><div class="si p"><i class="fas fa-percentage"></i></div><div class="sv">94%</div><div class="sl">Attendance</div></div>
  </div>
  <!-- CHARTS + AI -->
  <div class="g2">
    <div class="card">
      <div class="ch"><span class="ct">Performance Trend</span><a href="aiPredict.jsp" class="ca">Full Analysis →</a></div>
      <canvas id="perfChart" height="220"></canvas>
    </div>
    <div class="card">
      <div class="ch"><span class="ct" style="color:var(--teal);"><i class="fas fa-robot"></i> AI Score</span></div>
      <div style="text-align:center;padding:10px 0;">
        <div class="ai-ring"><span class="ai-score">84%</span></div>
        <p style="color:#fff;font-weight:600;font-size:.92rem;">Success Probability</p>
        <p style="color:var(--muted);font-size:.78rem;">Based on your academic data</p>
      </div>
      <div class="ai-insight"><strong>AI Tip:</strong> Focus on DBMS to improve GPA by ~0.4 points this semester.</div>
      <a href="aiPredict.jsp" class="ai-btn"><i class="fas fa-magic"></i> Run Full AI Analysis</a>
    </div>
  </div>
  <!-- ENROLLMENTS + PAYMENTS + PROGRESS -->
  <div class="g3">
    <div class="card">
      <div class="ch"><span class="ct">My Enrollments</span><a href="myEnrollments.jsp" class="ca">All →</a></div>
      <%if(enrollments.isEmpty()){%>
        <p style="color:var(--muted);font-size:.85rem;text-align:center;padding:20px 0;">No enrollments yet.<br><a href="EnrollmentServlet" style="color:var(--accent);">Enroll now →</a></p>
      <%}else{for(Map<String,String> e:enrollments){%>
        <div style="padding:10px 0;border-bottom:1px solid var(--border);display:flex;justify-content:space-between;align-items:center;">
          <div><div style="font-size:.88rem;color:#fff;font-weight:500;"><%=e.get("courseName")%></div><div style="font-size:.74rem;color:var(--muted);"><%=e.get("duration")%></div></div>
          <span class="badge bs"><%=e.get("status")%></span>
        </div>
      <%}}%>
      <a href="EnrollmentServlet" style="display:flex;align-items:center;justify-content:center;gap:8px;margin-top:14px;padding:10px;border-radius:9px;background:rgba(79,142,247,.08);border:1px solid rgba(79,142,247,.15);color:var(--accent);font-size:.82rem;font-weight:700;text-decoration:none;"><i class="fas fa-plus"></i> Enroll in Course</a>
    </div>
    <div class="card">
      <div class="ch"><span class="ct">Fee Status</span><a href="paymentHistory.jsp" class="ca">History →</a></div>
      <%if(payments.isEmpty()){%>
        <p style="color:var(--muted);font-size:.85rem;text-align:center;padding:20px 0;">No payments yet.</p>
      <%}else{int cnt=0;for(com.student.model.Payment p:payments){if(cnt++>=3)break;%>
        <div style="display:flex;justify-content:space-between;align-items:center;padding:10px 0;border-bottom:1px solid var(--border);">
          <div><div style="font-size:.87rem;color:#fff;"><%=p.getFeeType()%></div><div style="font-size:.73rem;color:var(--muted);"><%=p.getPaidAt()!=null?p.getPaidAt().toString().substring(0,10):""%></div></div>
          <span style="font-size:.9rem;font-weight:700;color:var(--green);">₹<%=String.format("%.0f",p.getAmount())%></span>
        </div>
      <%}}%>
      <a href="PaymentServlet" class="pay-btn"><i class="fas fa-credit-card"></i> Pay Fees Now</a>
    </div>
    <div class="card">
      <div class="ch"><span class="ct">Subject Progress</span></div>
      <div class="pi"><div class="pm"><span>Data Structures</span><span>92%</span></div><div class="pb"><div class="pf" style="width:92%;background:linear-gradient(90deg,var(--teal),var(--green));"></div></div></div>
      <div class="pi"><div class="pm"><span>DBMS</span><span>72%</span></div><div class="pb"><div class="pf" style="width:72%;background:linear-gradient(90deg,var(--gold),var(--rose));"></div></div></div>
      <div class="pi"><div class="pm"><span>Networks</span><span>85%</span></div><div class="pb"><div class="pf" style="width:85%;background:linear-gradient(90deg,var(--accent),var(--purple));"></div></div></div>
      <div class="pi"><div class="pm"><span>OS</span><span>68%</span></div><div class="pb"><div class="pf" style="width:68%;background:linear-gradient(90deg,var(--purple),var(--accent));"></div></div></div>
      <div class="pi"><div class="pm"><span>Software Engg</span><span>88%</span></div><div class="pb"><div class="pf" style="width:88%;background:linear-gradient(90deg,var(--green),var(--teal));"></div></div></div>
    </div>
  </div>
</main>
<script>
new Chart(document.getElementById('perfChart').getContext('2d'),{type:'line',data:{labels:['Sem 1','Sem 2','Sem 3','Sem 4','Sem 5','Sem 6'],datasets:[{label:'GPA',data:[7.2,7.8,8.0,8.1,8.3,8.4],borderColor:'#4f8ef7',backgroundColor:'rgba(79,142,247,.1)',borderWidth:2.5,tension:.4,fill:true,pointBackgroundColor:'#4f8ef7',pointRadius:4},{label:'Attendance %',data:[88,91,89,95,92,94],borderColor:'#00d4aa',backgroundColor:'rgba(0,212,170,.06)',borderWidth:2.5,tension:.4,fill:true,pointBackgroundColor:'#00d4aa',pointRadius:4,yAxisID:'y1'}]},options:{responsive:true,interaction:{mode:'index',intersect:false},plugins:{legend:{labels:{color:'#8892b0',font:{family:'Satoshi'}}}},scales:{x:{grid:{color:'rgba(255,255,255,.04)'},ticks:{color:'#8892b0'}},y:{grid:{color:'rgba(255,255,255,.04)'},ticks:{color:'#8892b0'},min:6,max:10},y1:{position:'right',grid:{drawOnChartArea:false},ticks:{color:'#8892b0'},min:60,max:100}}}});
</script>
</body></html>
