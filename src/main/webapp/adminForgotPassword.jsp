<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Admin Forgot Password — EduSphere</title>
<link href="https://fonts.googleapis.com/css2?family=Clash+Display:wght@500;700&family=Satoshi:wght@400;500;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<style>
:root{--navy:#0a0f2c;--accent:#4f8ef7;--rose:#ff6b8a;--purple:#7b6cf6;--teal:#00d4aa;--gb:rgba(255,255,255,0.10);--text:#e8eaf6;--muted:#8892b0;}
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Satoshi',sans-serif;background:var(--navy);color:var(--text);min-height:100vh;display:flex;align-items:center;justify-content:center;padding:40px 20px;background-image:radial-gradient(ellipse 70% 60% at 20% 20%,#2a1a6c44,transparent),radial-gradient(ellipse 50% 50% at 80% 80%,#7b6cf218,transparent);}
@keyframes fadeUp{from{opacity:0;transform:translateY(24px)}to{opacity:1;transform:translateY(0)}}
.card{width:100%;max-width:440px;background:rgba(255,255,255,.05);border:1px solid var(--gb);border-radius:24px;padding:48px 42px;backdrop-filter:blur(20px);animation:fadeUp .7s ease both;text-align:center;}
.icon{width:72px;height:72px;border-radius:50%;background:rgba(123,108,246,.12);border:2px solid rgba(123,108,246,.2);display:flex;align-items:center;justify-content:center;font-size:1.8rem;color:var(--purple);margin:0 auto 24px;}
.ct{font-family:'Clash Display',sans-serif;font-size:1.6rem;font-weight:700;color:#fff;margin-bottom:10px;}
.cs{font-size:.87rem;color:var(--muted);margin-bottom:28px;line-height:1.7;}
.alert{padding:11px 15px;border-radius:9px;font-size:.83rem;margin-bottom:18px;display:flex;align-items:center;gap:9px;text-align:left;}
.ae{background:rgba(255,107,138,.12);border:1px solid rgba(255,107,138,.25);color:var(--rose);}
.fg{margin-bottom:16px;text-align:left;}
.fl{display:block;font-size:.8rem;font-weight:600;color:var(--muted);margin-bottom:7px;}
.iw{position:relative;}
.ii{position:absolute;left:13px;top:50%;transform:translateY(-50%);color:var(--muted);font-size:.83rem;pointer-events:none;}
.fi{width:100%;padding:12px 12px 12px 38px;background:rgba(255,255,255,.05);border:1.5px solid var(--gb);border-radius:9px;color:var(--text);font-size:.9rem;font-family:'Satoshi',sans-serif;outline:none;transition:all .2s;}
.fi::placeholder{color:#4a5568;}
.fi:focus{border-color:var(--purple);}
.btn{width:100%;padding:14px;border-radius:10px;border:none;background:linear-gradient(135deg,var(--purple),var(--accent));color:#fff;font-family:'Satoshi',sans-serif;font-size:.95rem;font-weight:700;cursor:pointer;transition:all .3s;display:flex;align-items:center;justify-content:center;gap:10px;box-shadow:0 6px 24px rgba(123,108,246,.35);margin-top:8px;}
.btn:hover{transform:translateY(-2px);}
.back{display:inline-flex;align-items:center;gap:8px;color:var(--muted);text-decoration:none;font-size:.85rem;margin-top:20px;transition:color .2s;}
.back:hover{color:var(--purple);}
</style></head><body>
<div class="card">
  <div class="icon"><i class="fas fa-shield-alt"></i></div>
  <h2 class="ct">Admin Password Reset</h2>
  <p class="cs">Enter your admin email address to verify and reset your password.</p>
  <%String err=(String)request.getAttribute("error");%>
  <%if(err!=null){%><div class="alert ae"><i class="fas fa-exclamation-circle"></i><%=err%></div><%}%>
  <form action="AdminForgotPasswordServlet" method="post">
    <input type="hidden" name="action" value="verify">
    <div class="fg"><label class="fl">Admin Email</label><div class="iw"><i class="fas fa-envelope ii"></i><input type="email" name="email" class="fi" placeholder="admin@college.edu" required></div></div>
    <button type="submit" class="btn"><i class="fas fa-search"></i> Verify Admin Account</button>
  </form>
  <br><a href="adminLogin.jsp" class="back"><i class="fas fa-arrow-left"></i> Back to Admin Login</a>
</div>
</body></html>
