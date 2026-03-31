<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Student Login — EduSphere</title>
<link href="https://fonts.googleapis.com/css2?family=Clash+Display:wght@500;600;700&family=Satoshi:wght@400;500;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<style>
:root{--navy:#0a0f2c;--accent:#4f8ef7;--teal:#00d4aa;--gold:#f5c842;--rose:#ff6b8a;--purple:#7b6cf6;--gb:rgba(255,255,255,0.10);--text:#e8eaf6;--muted:#8892b0;}
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Satoshi',sans-serif;background:var(--navy);color:var(--text);min-height:100vh;display:flex;background-image:radial-gradient(ellipse 70% 60% at 15% 20%,#1a2a6c44,transparent 60%),radial-gradient(ellipse 50% 50% at 85% 80%,#00d4aa18,transparent 60%);}
.orb{position:fixed;border-radius:50%;filter:blur(80px);pointer-events:none;animation:drift 10s ease-in-out infinite alternate;}
.o1{width:400px;height:400px;background:#4f8ef720;top:-100px;left:-100px;}
.o2{width:350px;height:350px;background:#00d4aa15;bottom:-80px;right:-80px;animation-delay:-5s;}
@keyframes drift{0%{transform:translate(0,0)}100%{transform:translate(30px,25px)}}
@keyframes fadeUp{from{opacity:0;transform:translateY(24px)}to{opacity:1;transform:translateY(0)}}
.left{position:relative;z-index:1;width:45%;min-height:100vh;display:flex;flex-direction:column;justify-content:center;padding:60px;border-right:1px solid var(--gb);background:rgba(10,15,44,.4);backdrop-filter:blur(10px);}
.right{flex:1;display:flex;align-items:center;justify-content:center;padding:40px;position:relative;z-index:1;}
.logo{font-family:'Clash Display',sans-serif;font-size:1.8rem;font-weight:700;text-decoration:none;background:linear-gradient(135deg,var(--accent),var(--teal));-webkit-background-clip:text;-webkit-text-fill-color:transparent;margin-bottom:60px;display:block;}
.lh{font-family:'Clash Display',sans-serif;font-size:2.8rem;font-weight:700;line-height:1.15;color:#fff;margin-bottom:18px;}
.lh .ac{background:linear-gradient(135deg,var(--accent),var(--teal));-webkit-background-clip:text;-webkit-text-fill-color:transparent;}
.ls{color:var(--muted);font-size:.93rem;line-height:1.8;margin-bottom:44px;}
.flist{display:flex;flex-direction:column;gap:14px;}
.fi{display:flex;gap:12px;align-items:center;padding:13px 16px;border-radius:11px;background:rgba(255,255,255,.04);border:1px solid var(--gb);}
.fi-ic{width:34px;height:34px;border-radius:9px;display:flex;align-items:center;justify-content:center;font-size:.85rem;flex-shrink:0;}
.ft{font-size:.86rem;color:var(--muted);}
.ft strong{color:#fff;display:block;margin-bottom:2px;}
.card{width:100%;max-width:430px;background:rgba(255,255,255,.05);border:1px solid var(--gb);border-radius:24px;padding:44px 40px;backdrop-filter:blur(20px);animation:fadeUp .7s ease both;}
.tag{display:inline-flex;align-items:center;gap:8px;padding:6px 14px;border-radius:50px;background:rgba(79,142,247,.12);border:1px solid rgba(79,142,247,.2);color:var(--accent);font-size:.72rem;font-weight:700;letter-spacing:1px;text-transform:uppercase;margin-bottom:18px;}
.ct{font-family:'Clash Display',sans-serif;font-size:1.8rem;font-weight:700;color:#fff;margin-bottom:6px;}
.cs{font-size:.87rem;color:var(--muted);margin-bottom:28px;}
.alert{padding:11px 15px;border-radius:9px;font-size:.83rem;margin-bottom:18px;display:flex;align-items:center;gap:9px;}
.ae{background:rgba(255,107,138,.12);border:1px solid rgba(255,107,138,.25);color:var(--rose);}
.as{background:rgba(0,212,170,.12);border:1px solid rgba(0,212,170,.25);color:var(--teal);}
.fg{margin-bottom:18px;}
.fl{display:block;font-size:.8rem;font-weight:600;color:var(--muted);margin-bottom:7px;letter-spacing:.3px;}
.iw{position:relative;}
.ii{position:absolute;left:13px;top:50%;transform:translateY(-50%);color:var(--muted);font-size:.85rem;pointer-events:none;transition:color .2s;}
.fi2{width:100%;padding:12px 12px 12px 38px;background:rgba(255,255,255,.05);border:1.5px solid var(--gb);border-radius:9px;color:var(--text);font-size:.9rem;font-family:'Satoshi',sans-serif;outline:none;transition:all .2s;}
.fi2::placeholder{color:#4a5568;}
.fi2:focus{border-color:var(--accent);background:rgba(79,142,247,.05);}
.iw:focus-within .ii{color:var(--accent);}
.eye{position:absolute;right:12px;top:50%;transform:translateY(-50%);background:none;border:none;color:var(--muted);cursor:pointer;font-size:.85rem;transition:color .2s;}
.eye:hover{color:var(--accent);}
.row{display:flex;justify-content:space-between;align-items:center;margin-bottom:22px;}
.rl{display:flex;align-items:center;gap:8px;font-size:.82rem;color:var(--muted);cursor:pointer;}
.rl input{accent-color:var(--accent);}
.fl2{font-size:.82rem;color:var(--accent);text-decoration:none;transition:color .2s;}
.fl2:hover{color:var(--teal);}
.btn{width:100%;padding:14px;border-radius:10px;border:none;background:linear-gradient(135deg,var(--accent),var(--purple));color:#fff;font-family:'Satoshi',sans-serif;font-size:.95rem;font-weight:700;cursor:pointer;transition:all .3s;display:flex;align-items:center;justify-content:center;gap:10px;box-shadow:0 6px 24px rgba(79,142,247,.35);}
.btn:hover{transform:translateY(-2px);box-shadow:0 12px 36px rgba(79,142,247,.5);}
.div{display:flex;align-items:center;gap:14px;margin:22px 0;color:var(--muted);font-size:.78rem;}
.div::before,.div::after{content:'';flex:1;height:1px;background:var(--gb);}
.lnk{text-align:center;font-size:.87rem;color:var(--muted);}
.lnk a{color:var(--accent);text-decoration:none;font-weight:700;}
.lnk a:hover{color:var(--teal);}
.back{display:inline-flex;align-items:center;gap:8px;color:var(--muted);text-decoration:none;font-size:.82rem;margin-bottom:28px;transition:color .2s;}
.back:hover{color:var(--accent);}
@media(max-width:768px){.left{display:none;} body{justify-content:center;align-items:center;padding:20px;} .right{width:100%;}}
</style></head><body>
<div class="o1 orb"></div><div class="o2 orb"></div>
<div class="left">
  <a href="home.jsp" class="logo">EduSphere</a>
  <h1 class="lh">Welcome back<br>to your <span class="ac">learning</span><br>journey.</h1>
  <p class="ls">Access your courses, track performance, and manage your academic life — all in one place.</p>
  <div class="flist">
    <div class="fi"><div class="fi-ic" style="background:rgba(79,142,247,.15);color:var(--accent);"><i class="fas fa-book-open"></i></div><div class="ft"><strong>Course Management</strong>View and manage enrolled courses</div></div>
    <div class="fi"><div class="fi-ic" style="background:rgba(0,212,170,.15);color:var(--teal);"><i class="fas fa-brain"></i></div><div class="ft"><strong>AI Performance Insights</strong>Smart predictions based on your data</div></div>
    <div class="fi"><div class="fi-ic" style="background:rgba(245,200,66,.15);color:var(--gold);"><i class="fas fa-credit-card"></i></div><div class="ft"><strong>Online Fee Payment</strong>Pay fees securely via Razorpay</div></div>
  </div>
</div>
<div class="right">
  <div class="card">
    <a href="home.jsp" class="back"><i class="fas fa-arrow-left"></i> Back to Home</a>
    <div class="tag"><i class="fas fa-graduation-cap"></i> Student Portal</div>
    <h2 class="ct">Sign In</h2>
    <p class="cs">Enter your credentials to access your dashboard</p>
    <%
      String err = (String)request.getAttribute("error");
      String msg = request.getParameter("registered");
      String rst = request.getParameter("reset");
      String lo  = request.getParameter("logout");
    %>
    <% if(err!=null){ %><div class="alert ae"><i class="fas fa-exclamation-circle"></i><%=err%></div><% } %>
    <% if("true".equals(msg)){ %><div class="alert as"><i class="fas fa-check-circle"></i> Registered! Please login.</div><% } %>
    <% if("true".equals(rst)){ %><div class="alert as"><i class="fas fa-check-circle"></i> Password reset! Please login.</div><% } %>
    <% if("true".equals(lo)){ %><div class="alert as"><i class="fas fa-check-circle"></i> Logged out successfully.</div><% } %>
    <form action="LoginServlet" method="post">
      <div class="fg"><label class="fl">Email Address</label><div class="iw"><i class="fas fa-envelope ii"></i><input type="email" name="email" class="fi2" placeholder="student@college.edu" required></div></div>
      <div class="fg"><label class="fl">Password</label><div class="iw"><i class="fas fa-lock ii"></i><input type="password" name="password" id="pwd" class="fi2" placeholder="Enter password" required><button type="button" class="eye" onclick="tp()"><i class="fas fa-eye" id="ei"></i></button></div></div>
      <div class="row"><label class="rl"><input type="checkbox" name="remember"> Remember me</label><a href="forgotPassword.jsp" class="fl2">Forgot password?</a></div>
      <button type="submit" class="btn"><i class="fas fa-sign-in-alt"></i> Sign In</button>
    </form>
    <div class="div">or</div>
    <div class="lnk">Don't have an account? <a href="register.jsp">Register here</a></div>
    <div class="lnk" style="margin-top:10px;"><a href="adminLogin.jsp" style="color:var(--gold);"><i class="fas fa-shield-alt"></i> Admin Portal →</a></div>
  </div>
</div>
<script>function tp(){var f=document.getElementById('pwd'),i=document.getElementById('ei');f.type=f.type==='password'?'text':'password';i.className=f.type==='password'?'fas fa-eye':'fas fa-eye-slash';}</script>
</body></html>
