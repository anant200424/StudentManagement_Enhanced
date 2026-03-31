<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Register — EduSphere</title>
<link href="https://fonts.googleapis.com/css2?family=Clash+Display:wght@500;600;700&family=Satoshi:wght@400;500;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<style>
:root{--navy:#0a0f2c;--accent:#4f8ef7;--teal:#00d4aa;--gold:#f5c842;--rose:#ff6b8a;--purple:#7b6cf6;--gb:rgba(255,255,255,0.10);--text:#e8eaf6;--muted:#8892b0;}
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Satoshi',sans-serif;background:var(--navy);color:var(--text);min-height:100vh;display:flex;align-items:center;justify-content:center;padding:40px 20px;background-image:radial-gradient(ellipse 70% 60% at 20% 20%,#1a2a6c44,transparent),radial-gradient(ellipse 50% 50% at 80% 80%,#00d4aa18,transparent);}
.orb{position:fixed;border-radius:50%;filter:blur(80px);pointer-events:none;animation:drift 10s ease-in-out infinite alternate;}
.o1{width:400px;height:400px;background:#4f8ef720;top:-100px;left:-100px;}
.o2{width:350px;height:350px;background:#00d4aa15;bottom:-80px;right:-80px;animation-delay:-5s;}
@keyframes drift{0%{transform:translate(0,0)}100%{transform:translate(30px,25px)}}
@keyframes fadeUp{from{opacity:0;transform:translateY(24px)}to{opacity:1;transform:translateY(0)}}
.card{position:relative;z-index:1;width:100%;max-width:580px;background:rgba(255,255,255,.05);border:1px solid var(--gb);border-radius:24px;padding:44px 42px;backdrop-filter:blur(20px);animation:fadeUp .7s ease both;}
.back{display:inline-flex;align-items:center;gap:8px;color:var(--muted);text-decoration:none;font-size:.82rem;margin-bottom:24px;transition:color .2s;}
.back:hover{color:var(--accent);}
.logo{font-family:'Clash Display',sans-serif;font-size:1.5rem;font-weight:700;background:linear-gradient(135deg,var(--accent),var(--teal));-webkit-background-clip:text;-webkit-text-fill-color:transparent;text-decoration:none;display:block;margin-bottom:24px;}
.ct{font-family:'Clash Display',sans-serif;font-size:1.6rem;font-weight:700;color:#fff;margin-bottom:6px;}
.cs{font-size:.87rem;color:var(--muted);margin-bottom:26px;}
.row2{display:grid;grid-template-columns:1fr 1fr;gap:14px;}
.fg{margin-bottom:16px;}
.fl{display:block;font-size:.8rem;font-weight:600;color:var(--muted);margin-bottom:7px;letter-spacing:.3px;}
.iw{position:relative;}
.ii{position:absolute;left:13px;top:50%;transform:translateY(-50%);color:var(--muted);font-size:.83rem;pointer-events:none;transition:color .2s;}
.fi{width:100%;padding:11px 12px 11px 37px;background:rgba(255,255,255,.05);border:1.5px solid var(--gb);border-radius:9px;color:var(--text);font-size:.88rem;font-family:'Satoshi',sans-serif;outline:none;transition:all .2s;}
.fi::placeholder{color:#4a5568;}
.fi:focus{border-color:var(--accent);}
.iw:focus-within .ii{color:var(--accent);}
select.fi{appearance:none;cursor:pointer;}
.alert{padding:11px 15px;border-radius:9px;font-size:.83rem;margin-bottom:18px;display:flex;align-items:center;gap:9px;}
.ae{background:rgba(255,107,138,.12);border:1px solid rgba(255,107,138,.25);color:var(--rose);}
.btn{width:100%;padding:14px;border-radius:10px;border:none;background:linear-gradient(135deg,var(--accent),var(--purple));color:#fff;font-family:'Satoshi',sans-serif;font-size:.95rem;font-weight:700;cursor:pointer;transition:all .3s;display:flex;align-items:center;justify-content:center;gap:10px;box-shadow:0 6px 24px rgba(79,142,247,.35);margin-top:8px;}
.btn:hover{transform:translateY(-2px);box-shadow:0 12px 36px rgba(79,142,247,.5);}
.lnk{text-align:center;font-size:.87rem;color:var(--muted);margin-top:18px;}
.lnk a{color:var(--accent);text-decoration:none;font-weight:700;}
.step{font-size:.75rem;color:var(--teal);font-weight:700;text-transform:uppercase;letter-spacing:1px;margin:20px 0 12px;border-bottom:1px solid var(--gb);padding-bottom:8px;}
</style></head><body>
<div class="o1 orb"></div><div class="o2 orb"></div>
<div class="card">
  <a href="home.jsp" class="back"><i class="fas fa-arrow-left"></i> Back to Home</a>
  <a href="home.jsp" class="logo">EduSphere</a>
  <h2 class="ct">Create Account</h2>
  <p class="cs">Join thousands of students managing their academic journey</p>
  <%String err=(String)request.getAttribute("error");%>
  <%if(err!=null){%><div class="alert ae"><i class="fas fa-exclamation-circle"></i><%=err%></div><%}%>
  <form action="RegisterServlet" method="post">
    <div class="step">Personal Info</div>
    <div class="row2">
      <div class="fg"><label class="fl">First Name</label><div class="iw"><i class="fas fa-user ii"></i><input type="text" name="firstName" class="fi" placeholder="Anant" required></div></div>
      <div class="fg"><label class="fl">Last Name</label><div class="iw"><i class="fas fa-user ii"></i><input type="text" name="lastName" class="fi" placeholder="Kumar" required></div></div>
    </div>
    <div class="fg"><label class="fl">Email Address</label><div class="iw"><i class="fas fa-envelope ii"></i><input type="email" name="email" class="fi" placeholder="anant@college.edu" required></div></div>
    <div class="fg"><label class="fl">Phone Number</label><div class="iw"><i class="fas fa-phone ii"></i><input type="tel" name="phone" class="fi" placeholder="+91 98765 43210"></div></div>
    <div class="fg"><label class="fl">Address</label><div class="iw"><i class="fas fa-map-marker-alt ii"></i><input type="text" name="address" class="fi" placeholder="Kolkata, West Bengal"></div></div>

    <div class="step">Family Info</div>
    <div class="row2">
      <div class="fg"><label class="fl">Father's Name</label><div class="iw"><i class="fas fa-user ii"></i><input type="text" name="fatherName" class="fi" placeholder="Father's Name"></div></div>
      <div class="fg"><label class="fl">Mother's Name</label><div class="iw"><i class="fas fa-user ii"></i><input type="text" name="motherName" class="fi" placeholder="Mother's Name"></div></div>
    </div>

    <div class="step">Academic Info</div>
    <div class="fg"><label class="fl">Select Course</label><div class="iw"><i class="fas fa-book ii"></i>
      <select name="course" class="fi">
        <option value="">-- Select Your Course --</option>
        <option>B.Tech CSE</option><option>B.Tech ECE</option>
        <option>BCA</option><option>MBA</option>
        <option>B.Sc IT</option><option>MCA</option>
      </select>
    </div></div>

    <div class="step">Set Password</div>
    <div class="row2">
      <div class="fg"><label class="fl">Password</label><div class="iw"><i class="fas fa-lock ii"></i><input type="password" name="password" class="fi" placeholder="Min 6 chars" required></div></div>
      <div class="fg"><label class="fl">Confirm Password</label><div class="iw"><i class="fas fa-lock ii"></i><input type="password" name="confirmPassword" class="fi" placeholder="Repeat" required></div></div>
    </div>
    <button type="submit" class="btn"><i class="fas fa-user-plus"></i> Create My Account</button>
  </form>
  <div class="lnk">Already have an account? <a href="login.jsp">Sign in here</a></div>
</div>
</body></html>
