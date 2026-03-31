<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>EduSphere — Student Management System</title>
<link href="https://fonts.googleapis.com/css2?family=Clash+Display:wght@400;500;600;700&family=Satoshi:wght@300;400;500;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<style>
:root{--navy:#0a0f2c;--accent:#4f8ef7;--teal:#00d4aa;--gold:#f5c842;--rose:#ff6b8a;--purple:#7b6cf6;--glass:rgba(255,255,255,0.05);--gb:rgba(255,255,255,0.10);--text:#e8eaf6;--muted:#8892b0;}
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Satoshi',sans-serif;background:var(--navy);color:var(--text);overflow-x:hidden;}
.bg{position:fixed;inset:0;z-index:0;background:radial-gradient(ellipse 80% 60% at 20% 10%,#1a2a6c44,transparent 60%),radial-gradient(ellipse 60% 50% at 80% 80%,#00d4aa18,transparent 60%),linear-gradient(135deg,#0a0f2c,#0d1544 50%,#0a1628);}
.orb{position:fixed;border-radius:50%;filter:blur(80px);pointer-events:none;z-index:0;animation:drift 12s ease-in-out infinite alternate;}
.o1{width:500px;height:500px;background:#4f8ef720;top:-100px;left:-100px;}
.o2{width:400px;height:400px;background:#00d4aa15;bottom:-80px;right:-80px;animation-delay:-5s;}
.o3{width:300px;height:300px;background:#f5c84212;top:40%;left:55%;animation-delay:-9s;}
.grid{position:fixed;inset:0;z-index:0;opacity:.03;background-image:linear-gradient(#fff 1px,transparent 1px),linear-gradient(90deg,#fff 1px,transparent 1px);background-size:60px 60px;}
@keyframes drift{0%{transform:translate(0,0) scale(1)}100%{transform:translate(40px,30px) scale(1.1)}}
@keyframes fadeUp{from{opacity:0;transform:translateY(28px)}to{opacity:1;transform:translateY(0)}}
.reveal{opacity:0;transform:translateY(30px);transition:all .7s ease;}
.reveal.visible{opacity:1;transform:translateY(0);}

/* NAV */
nav{position:fixed;top:0;left:0;right:0;z-index:100;padding:18px 60px;display:flex;align-items:center;justify-content:space-between;background:rgba(10,15,44,.7);backdrop-filter:blur(20px);border-bottom:1px solid var(--gb);transition:background .3s;}
.logo{font-family:'Clash Display',sans-serif;font-size:1.6rem;font-weight:700;background:linear-gradient(135deg,var(--accent),var(--teal));-webkit-background-clip:text;-webkit-text-fill-color:transparent;text-decoration:none;}
.logo span{-webkit-text-fill-color:var(--gold);}
.nav-links{display:flex;gap:36px;list-style:none;}
.nav-links a{color:var(--muted);text-decoration:none;font-size:.9rem;font-weight:500;transition:color .2s;position:relative;}
.nav-links a:hover{color:#fff;}
.nav-links a::after{content:'';position:absolute;bottom:-4px;left:0;right:0;height:2px;background:var(--accent);transform:scaleX(0);transition:transform .2s;border-radius:2px;}
.nav-links a:hover::after{transform:scaleX(1);}
.nav-btns{display:flex;gap:12px;}
.btn-outline{padding:10px 22px;border-radius:8px;font-size:.88rem;font-weight:600;text-decoration:none;border:1.5px solid var(--gb);color:var(--text);background:transparent;transition:all .2s;font-family:'Satoshi',sans-serif;}
.btn-outline:hover{border-color:var(--accent);color:var(--accent);}
.btn-primary{padding:10px 22px;border-radius:8px;font-size:.88rem;font-weight:600;text-decoration:none;border:none;background:linear-gradient(135deg,var(--accent),var(--purple));color:#fff;transition:all .3s;font-family:'Satoshi',sans-serif;box-shadow:0 4px 20px rgba(79,142,247,.3);}
.btn-primary:hover{transform:translateY(-2px);box-shadow:0 8px 30px rgba(79,142,247,.45);}

/* HERO */
.hero{position:relative;z-index:1;min-height:100vh;display:flex;align-items:center;justify-content:center;text-align:center;padding:120px 40px 80px;}
.badge{display:inline-flex;align-items:center;gap:8px;padding:8px 18px;border-radius:50px;background:rgba(79,142,247,.12);border:1px solid rgba(79,142,247,.25);font-size:.78rem;font-weight:700;color:var(--accent);letter-spacing:1px;text-transform:uppercase;margin-bottom:28px;animation:fadeUp .8s ease both;}
.dot{width:6px;height:6px;border-radius:50%;background:var(--teal);animation:pulse 1.5s infinite;}
@keyframes pulse{0%,100%{opacity:1}50%{opacity:.3}}
h1{font-family:'Clash Display',sans-serif;font-size:clamp(3rem,7vw,5.5rem);font-weight:700;line-height:1.08;margin-bottom:28px;animation:fadeUp .8s .1s ease both;}
h1 .l1{display:block;color:#fff;}
h1 .l2{display:block;background:linear-gradient(135deg,var(--accent),var(--teal),var(--gold));-webkit-background-clip:text;-webkit-text-fill-color:transparent;}
.sub{font-size:1.1rem;color:var(--muted);max-width:560px;margin:0 auto 48px;line-height:1.8;animation:fadeUp .8s .2s ease both;}
.cta{display:flex;gap:16px;justify-content:center;flex-wrap:wrap;animation:fadeUp .8s .3s ease both;}
.btn-big{padding:16px 36px;border-radius:12px;font-size:1rem;font-weight:700;text-decoration:none;transition:all .3s;font-family:'Satoshi',sans-serif;}
.btn-big-p{background:linear-gradient(135deg,var(--accent),var(--purple));color:#fff;border:none;box-shadow:0 8px 32px rgba(79,142,247,.4);}
.btn-big-p:hover{transform:translateY(-3px);box-shadow:0 16px 48px rgba(79,142,247,.5);}
.btn-big-s{background:var(--glass);color:var(--text);border:1.5px solid var(--gb);backdrop-filter:blur(10px);}
.btn-big-s:hover{border-color:var(--teal);color:var(--teal);}
.stats{display:flex;gap:48px;justify-content:center;flex-wrap:wrap;margin-top:72px;animation:fadeUp .8s .4s ease both;}
.stat-num{font-family:'Clash Display',sans-serif;font-size:2.2rem;font-weight:700;background:linear-gradient(135deg,var(--accent),var(--teal));-webkit-background-clip:text;-webkit-text-fill-color:transparent;}
.stat-lbl{font-size:.78rem;color:var(--muted);text-transform:uppercase;letter-spacing:1px;margin-top:4px;}
.sdiv{width:1px;background:var(--gb);}

/* SECTIONS */
section{position:relative;z-index:1;}
.stag{display:inline-block;font-size:.72rem;font-weight:700;letter-spacing:2px;text-transform:uppercase;color:var(--teal);margin-bottom:14px;}
.stitle{font-family:'Clash Display',sans-serif;font-size:clamp(1.8rem,4vw,2.8rem);font-weight:700;color:#fff;margin-bottom:14px;}
.ssub{font-size:.95rem;color:var(--muted);line-height:1.8;}

/* FEATURES */
.feat-sec{padding:100px 60px;}
.feat-hd{text-align:center;margin-bottom:64px;}
.feat-hd .ssub{margin:0 auto;max-width:520px;}
.feat-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(290px,1fr));gap:22px;max-width:1200px;margin:0 auto;}
.fc{background:var(--glass);border:1px solid var(--gb);border-radius:20px;padding:34px 30px;transition:all .3s;position:relative;overflow:hidden;}
.fc::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;background:linear-gradient(90deg,transparent,var(--accent),transparent);opacity:0;transition:opacity .3s;}
.fc:hover{transform:translateY(-6px);border-color:rgba(79,142,247,.3);background:rgba(255,255,255,.07);}
.fc:hover::before{opacity:1;}
.ficon{width:52px;height:52px;border-radius:13px;display:flex;align-items:center;justify-content:center;font-size:1.3rem;margin-bottom:20px;}
.fi-b{background:rgba(79,142,247,.15);color:var(--accent);}
.fi-t{background:rgba(0,212,170,.15);color:var(--teal);}
.fi-g{background:rgba(245,200,66,.15);color:var(--gold);}
.fi-r{background:rgba(255,107,138,.15);color:var(--rose);}
.fi-p{background:rgba(123,108,246,.15);color:var(--purple);}
.fi-gr{background:rgba(52,211,153,.15);color:#34d399;}
.fc h3{font-family:'Clash Display',sans-serif;font-size:1.1rem;color:#fff;margin-bottom:10px;}
.fc p{font-size:.87rem;color:var(--muted);line-height:1.7;}

/* ROLES */
.roles-sec{padding:100px 60px;border-top:1px solid var(--gb);}
.roles-hd{text-align:center;margin-bottom:60px;}
.roles-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:26px;max-width:1000px;margin:0 auto;}
.rc{border-radius:22px;padding:40px 30px;text-align:center;border:1px solid var(--gb);transition:all .3s;position:relative;overflow:hidden;}
.rc:hover{transform:translateY(-8px);}
.rc-admin{background:linear-gradient(135deg,rgba(79,142,247,.1),rgba(123,108,246,.1));}
.rc-stu{background:linear-gradient(135deg,rgba(0,212,170,.1),rgba(52,211,153,.1));}
.rc-new{background:linear-gradient(135deg,rgba(245,200,66,.1),rgba(255,107,138,.1));}
.rc-icon{font-size:2.6rem;padding:18px;border-radius:18px;display:inline-flex;margin-bottom:18px;}
.rc h3{font-family:'Clash Display',sans-serif;font-size:1.25rem;color:#fff;margin-bottom:10px;}
.rc p{font-size:.86rem;color:var(--muted);line-height:1.7;margin-bottom:22px;}
.rc-link{display:inline-flex;align-items:center;gap:8px;font-size:.85rem;font-weight:700;text-decoration:none;transition:gap .2s;}
.rc-link:hover{gap:12px;}

/* FOOTER */
footer{position:relative;z-index:1;padding:60px;text-align:center;border-top:1px solid var(--gb);}
.flogo{font-family:'Clash Display',sans-serif;font-size:1.8rem;font-weight:700;background:linear-gradient(135deg,var(--accent),var(--teal));-webkit-background-clip:text;-webkit-text-fill-color:transparent;margin-bottom:14px;}
.flinks{display:flex;gap:28px;justify-content:center;margin:22px 0;flex-wrap:wrap;}
.flinks a{color:var(--muted);text-decoration:none;font-size:.85rem;transition:color .2s;}
.flinks a:hover{color:var(--accent);}
.fcopy{color:#3a4568;font-size:.78rem;margin-top:28px;}

@media(max-width:768px){nav{padding:16px 20px;}.nav-links,.nav-btns{display:none;}.feat-sec,.roles-sec{padding:60px 20px;}.roles-grid{grid-template-columns:1fr;}}
</style>
</head>
<body>
<div class="bg"></div><div class="grid"></div>
<div class="orb o1"></div><div class="orb o2"></div><div class="orb o3"></div>

<nav id="mainNav">
  <a href="home.jsp" class="logo">Edu<span>Sphere</span></a>
  <ul class="nav-links">
    <li><a href="#features">Features</a></li>
    <li><a href="#roles">Portals</a></li>
    <li><a href="login.jsp">Student Login</a></li>
    <li><a href="adminLogin.jsp">Admin</a></li>
  </ul>
  <div class="nav-btns">
    <a href="login.jsp" class="btn-outline">Login</a>
    <a href="register.jsp" class="btn-primary">Register Free</a>
  </div>
</nav>

<!-- HERO -->
<section class="hero">
  <div>
    <div class="badge"><span class="dot"></span> Smart Education Platform v2.0</div>
    <h1><span class="l1">Manage Students.</span><span class="l2">Empower Education.</span></h1>
    <p class="sub">A complete student management system with AI-powered analytics, online fee payments via Razorpay, and smart course enrollment — built for modern colleges.</p>
    <div class="cta">
      <a href="register.jsp" class="btn-big btn-big-p"><i class="fas fa-rocket"></i> Get Started Free</a>
      <a href="login.jsp"    class="btn-big btn-big-s"><i class="fas fa-sign-in-alt"></i> Student Login</a>
    </div>
    <div class="stats">
      <div><div class="stat-num">1200+</div><div class="stat-lbl">Students</div></div>
      <div class="sdiv"></div>
      <div><div class="stat-num">48</div><div class="stat-lbl">Courses</div></div>
      <div class="sdiv"></div>
      <div><div class="stat-num">99.9%</div><div class="stat-lbl">Uptime</div></div>
      <div class="sdiv"></div>
      <div><div class="stat-num">AI</div><div class="stat-lbl">Powered</div></div>
    </div>
  </div>
</section>

<!-- FEATURES -->
<section class="feat-sec" id="features">
  <div class="feat-hd reveal">
    <div class="stag">✦ Core Features</div>
    <h2 class="stitle">Everything Your College Needs</h2>
    <p class="ssub">From enrollment to AI analytics — one platform handles it all.</p>
  </div>
  <div class="feat-grid">
    <div class="fc reveal"><div class="ficon fi-b"><i class="fas fa-users"></i></div><h3>Student Management</h3><p>Register, update and manage complete student profiles with academic history.</p></div>
    <div class="fc reveal"><div class="ficon fi-t"><i class="fas fa-book-open"></i></div><h3>Course Enrollment</h3><p>Browse and enroll in courses. Admin manages all courses and enrollments.</p></div>
    <div class="fc reveal"><div class="ficon fi-g"><i class="fas fa-brain"></i></div><h3>AI Analytics</h3><p>Python ML model predicts student performance and generates insights.</p></div>
    <div class="fc reveal"><div class="ficon fi-r"><i class="fas fa-credit-card"></i></div><h3>Online Fee Payment</h3><p>Pay tuition, exam and library fees securely via Razorpay gateway.</p></div>
    <div class="fc reveal"><div class="ficon fi-p"><i class="fas fa-shield-alt"></i></div><h3>Secure Login</h3><p>Separate login for Students and Admins with forgot password recovery.</p></div>
    <div class="fc reveal"><div class="ficon fi-gr"><i class="fas fa-chart-line"></i></div><h3>Admin Dashboard</h3><p>Real-time charts showing enrollment trends, payment stats and analytics.</p></div>
  </div>
</section>

<!-- ROLES -->
<section class="roles-sec" id="roles">
  <div class="roles-hd reveal">
    <div class="stag">✦ Choose Your Portal</div>
    <h2 class="stitle">Three Dedicated Portals</h2>
    <p class="ssub" style="margin:0 auto;max-width:480px;">Each role gets a tailored experience built for their specific needs.</p>
  </div>
  <div class="roles-grid">
    <div class="rc rc-admin reveal">
      <div class="rc-icon" style="background:rgba(79,142,247,.15);color:var(--accent);"><i class="fas fa-user-shield"></i></div>
      <h3>Admin</h3>
      <p>Manage students, courses, enrollments, payments and view AI-powered analytics.</p>
      <a href="adminLogin.jsp" class="rc-link" style="color:var(--accent);">Admin Portal <i class="fas fa-arrow-right"></i></a>
    </div>
    <div class="rc rc-stu reveal">
      <div class="rc-icon" style="background:rgba(0,212,170,.15);color:var(--teal);"><i class="fas fa-graduation-cap"></i></div>
      <h3>Student</h3>
      <p>View courses, track your progress, pay fees online, and get AI performance predictions.</p>
      <a href="login.jsp" class="rc-link" style="color:var(--teal);">Student Login <i class="fas fa-arrow-right"></i></a>
    </div>
    <div class="rc rc-new reveal">
      <div class="rc-icon" style="background:rgba(245,200,66,.15);color:var(--gold);"><i class="fas fa-user-plus"></i></div>
      <h3>New Student</h3>
      <p>Create your account, choose your course and start your academic journey today.</p>
      <a href="register.jsp" class="rc-link" style="color:var(--gold);">Register Now <i class="fas fa-arrow-right"></i></a>
    </div>
  </div>
</section>

<footer>
  <div class="flogo">EduSphere</div>
  <p style="color:var(--muted);font-size:.88rem;">Smart Student Management System — Java Servlets + MySQL + Python AI + Razorpay</p>
  <div class="flinks">
    <a href="login.jsp">Student Login</a>
    <a href="adminLogin.jsp">Admin Portal</a>
    <a href="register.jsp">Register</a>
    <a href="#features">Features</a>
  </div>
  <p class="fcopy">© 2026 EduSphere · Major Project · 4th Year Computer Science · Kolkata</p>
</footer>

<script>
const obs = new IntersectionObserver(entries => {
  entries.forEach((e,i) => { if(e.isIntersecting){setTimeout(()=>e.target.classList.add('visible'),i*90);obs.unobserve(e.target);}});
},{threshold:.1});
document.querySelectorAll('.reveal').forEach(r=>obs.observe(r));
window.addEventListener('scroll',()=>{
  document.getElementById('mainNav').style.background = window.scrollY>50?'rgba(10,15,44,.95)':'rgba(10,15,44,.7)';
});
</script>
</body>
</html>
