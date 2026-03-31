<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.student.model.Student" %>
<%
  Student student=(Student)session.getAttribute("student");
  if(student==null){response.sendRedirect("login.jsp");return;}
  String RAZORPAY_KEY="rzp_test_YourKeyHere"; // ← PUT YOUR RAZORPAY TEST KEY HERE
%>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Pay Fees — EduSphere</title>
<link href="https://fonts.googleapis.com/css2?family=Clash+Display:wght@500;700&family=Satoshi:wght@400;500;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<style>
:root{--navy:#0a0f2c;--card:#0f1530;--accent:#4f8ef7;--teal:#00d4aa;--gold:#f5c842;--rose:#ff6b8a;--purple:#7b6cf6;--green:#34d399;--border:rgba(255,255,255,.08);--text:#e8eaf6;--muted:#8892b0;}
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Satoshi',sans-serif;background:var(--navy);color:var(--text);min-height:100vh;padding:36px 40px;background-image:radial-gradient(ellipse 60% 50% at 20% 20%,#1a2a6c30,transparent),radial-gradient(ellipse 40% 40% at 80% 80%,#00d4aa12,transparent);}
.back{display:inline-flex;align-items:center;gap:8px;color:var(--muted);text-decoration:none;font-size:.85rem;margin-bottom:28px;transition:color .2s;}
.back:hover{color:var(--accent);}
.pt{font-family:'Clash Display',sans-serif;font-size:1.9rem;font-weight:700;color:#fff;margin-bottom:6px;}
.ps{color:var(--muted);font-size:.9rem;margin-bottom:36px;}
.layout{display:grid;grid-template-columns:1.4fr 1fr;gap:26px;max-width:1000px;}
.card{background:var(--card);border:1px solid var(--border);border-radius:20px;padding:30px;}
.sec-title{font-family:'Clash Display',sans-serif;font-size:.95rem;font-weight:600;color:#fff;margin-bottom:18px;display:flex;align-items:center;gap:8px;}
/* FEE ITEMS */
.fee-item{display:flex;align-items:center;gap:14px;padding:14px;border-radius:11px;border:1.5px solid var(--border);margin-bottom:10px;cursor:pointer;transition:all .2s;}
.fee-item:hover{border-color:rgba(79,142,247,.3);}
.fee-item.sel{border-color:var(--accent);background:rgba(79,142,247,.07);}
.fchk{width:20px;height:20px;border-radius:50%;border:2px solid var(--border);display:flex;align-items:center;justify-content:center;flex-shrink:0;font-size:.62rem;transition:all .2s;}
.fee-item.sel .fchk{background:var(--accent);border-color:var(--accent);color:#fff;}
.fname{font-size:.9rem;font-weight:600;color:#fff;flex:1;}
.fdue{font-size:.73rem;color:var(--rose);margin-top:2px;}
.famt{font-family:'Clash Display',sans-serif;font-size:1.1rem;font-weight:700;color:var(--gold);}
.paid-item{display:flex;align-items:center;gap:14px;padding:13px 14px;border-radius:10px;background:rgba(52,211,153,.04);border:1px solid rgba(52,211,153,.1);margin-bottom:8px;}
.pchk{width:20px;height:20px;border-radius:50%;background:rgba(52,211,153,.18);color:var(--green);display:flex;align-items:center;justify-content:center;font-size:.68rem;flex-shrink:0;}
.pname{font-size:.86rem;color:var(--muted);flex:1;}
.pamt{font-size:.88rem;font-weight:700;color:var(--green);}
/* SUMMARY */
.srow{display:flex;justify-content:space-between;padding:10px 0;border-bottom:1px solid var(--border);font-size:.87rem;}
.srow:last-child{border-bottom:none;}
.slbl{color:var(--muted);}
.sval{color:#fff;font-weight:600;}
.total-box{margin-top:18px;padding:16px;border-radius:11px;background:rgba(79,142,247,.08);border:1px solid rgba(79,142,247,.18);display:flex;justify-content:space-between;align-items:center;}
.tlbl{font-size:.88rem;color:var(--muted);}
.tval{font-family:'Clash Display',sans-serif;font-size:1.8rem;font-weight:700;color:var(--accent);}
.pay-btn{width:100%;padding:15px;border-radius:11px;border:none;background:linear-gradient(135deg,var(--gold),var(--rose));color:#0a0f2c;font-family:'Satoshi',sans-serif;font-size:1rem;font-weight:800;cursor:pointer;transition:all .3s;display:flex;align-items:center;justify-content:center;gap:10px;margin-top:18px;}
.pay-btn:hover{transform:translateY(-2px);box-shadow:0 10px 32px rgba(245,200,66,.3);}
.secure{display:flex;align-items:center;justify-content:center;gap:8px;margin-top:12px;font-size:.74rem;color:var(--muted);}
.secure i{color:var(--green);}
/* MODAL */
.modal{display:none;position:fixed;inset:0;z-index:999;background:rgba(10,15,44,.85);backdrop-filter:blur(8px);align-items:center;justify-content:center;}
.modal.show{display:flex;}
.modal-box{background:var(--card);border:1px solid var(--border);border-radius:24px;padding:48px 40px;text-align:center;max-width:400px;width:90%;animation:pop .4s ease;}
@keyframes pop{from{transform:scale(.85);opacity:0}to{transform:scale(1);opacity:1}}
.ok-icon{width:76px;height:76px;border-radius:50%;background:rgba(52,211,153,.14);border:2px solid rgba(52,211,153,.28);display:flex;align-items:center;justify-content:center;font-size:2rem;color:var(--green);margin:0 auto 22px;}
.modal-box h3{font-family:'Clash Display',sans-serif;font-size:1.5rem;color:#fff;margin-bottom:8px;}
.modal-box p{color:var(--muted);font-size:.88rem;line-height:1.7;margin-bottom:22px;}
.pid{background:rgba(52,211,153,.07);border:1px solid rgba(52,211,153,.14);border-radius:9px;padding:10px;font-size:.78rem;color:var(--green);margin-bottom:22px;font-family:monospace;letter-spacing:.5px;}
.done-btn{padding:12px 36px;border-radius:10px;border:none;background:linear-gradient(135deg,var(--teal),var(--green));color:var(--navy);font-family:'Satoshi',sans-serif;font-weight:800;font-size:.95rem;cursor:pointer;}
</style></head><body>
<a href="studentDashboard.jsp" class="back"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
<h1 class="pt"><i class="fas fa-credit-card" style="color:var(--gold);"></i> Pay Fees</h1>
<p class="ps">Select fees to pay — powered by Razorpay secure gateway</p>
<div class="layout">
  <div>
    <div class="card" style="margin-bottom:20px;">
      <div class="sec-title"><i class="fas fa-exclamation-circle" style="color:var(--rose);"></i> Pending Fees</div>
      <div class="fee-item sel" id="fi1" onclick="toggle(this,8000)"><div class="fchk"><i class="fas fa-check"></i></div><div><div class="fname">Examination Fee — Sem 6</div><div class="fdue">Due: March 31, 2026</div></div><div class="famt">₹8,000</div></div>
      <div class="fee-item" id="fi2" onclick="toggle(this,3500)"><div class="fchk"><i class="fas fa-check"></i></div><div><div class="fname">Lab & Practical Fee</div><div class="fdue">Due: April 15, 2026</div></div><div class="famt">₹3,500</div></div>
      <div class="fee-item" id="fi3" onclick="toggle(this,1200)"><div class="fchk"><i class="fas fa-check"></i></div><div><div class="fname">Sports Activity Fee</div><div class="fdue">Due: April 30, 2026</div></div><div class="famt">₹1,200</div></div>
    </div>
    <div class="card">
      <div class="sec-title"><i class="fas fa-check-circle" style="color:var(--green);"></i> Already Paid</div>
      <div class="paid-item"><div class="pchk"><i class="fas fa-check"></i></div><span class="pname">Tuition Fee — Sem 6</span><span class="pamt">₹45,000</span></div>
      <div class="paid-item"><div class="pchk"><i class="fas fa-check"></i></div><span class="pname">Library Fee</span><span class="pamt">₹2,000</span></div>
    </div>
  </div>
  <div class="card" style="height:fit-content;position:sticky;top:36px;">
    <div class="sec-title"><i class="fas fa-receipt" style="color:var(--accent);"></i> Payment Summary</div>
    <div class="srow"><span class="slbl">Student</span><span class="sval"><%=student.getName()%></span></div>
    <div class="srow"><span class="slbl">Course</span><span class="sval"><%=student.getCourse()!=null?student.getCourse():"N/A"%></span></div>
    <div class="srow"><span class="slbl">Reg ID</span><span class="sval"><%=student.getRegId()!=null?student.getRegId():"N/A"%></span></div>
    <div class="srow"><span class="slbl">Selected</span><span class="sval" id="selCount">1 item</span></div>
    <div class="total-box"><span class="tlbl">Total to Pay</span><span class="tval" id="totalAmt">₹8,000</span></div>
    <button class="pay-btn" id="payBtn" onclick="pay()"><i class="fas fa-lock"></i> Pay with Razorpay</button>
    <div class="secure"><i class="fas fa-shield-alt"></i> 256-bit SSL Encrypted</div>
  </div>
</div>
<!-- SUCCESS MODAL -->
<div class="modal" id="successModal">
  <div class="modal-box">
    <div class="ok-icon"><i class="fas fa-check"></i></div>
    <h3>Payment Successful!</h3>
    <p>Your fee has been paid. Receipt sent to your email.</p>
    <div class="pid" id="payId">Payment ID: —</div>
    <button class="done-btn" onclick="location.href='paymentHistory.jsp'">View Payment History</button>
  </div>
</div>
<script>
var total=8000,selected=['fi1'];
function toggle(el,amt){
  var id=el.id;
  if(el.classList.contains('sel')){el.classList.remove('sel');selected=selected.filter(function(x){return x!==id;});total-=amt;}
  else{el.classList.add('sel');selected.push(id);total+=amt;}
  document.getElementById('totalAmt').innerText='₹'+total.toLocaleString('en-IN');
  document.getElementById('selCount').innerText=selected.length+' item'+(selected.length!==1?'s':'');
}
function pay(){
  if(total<=0||selected.length===0){alert('Select at least one fee.');return;}
  var rzp=new Razorpay({
    key:'<%=RAZORPAY_KEY%>',
    amount:total*100,currency:'INR',
    name:'EduSphere',description:'Student Fee Payment',
    handler:function(resp){
      document.getElementById('payId').innerText='Payment ID: '+resp.razorpay_payment_id;
      document.getElementById('successModal').classList.add('show');
      // Save to DB
      var form=document.createElement('form');form.method='POST';form.action='PaymentServlet';
      var fields={amount:total,feeType:'Exam & Other Fees',razorpay_payment_id:resp.razorpay_payment_id,razorpay_order_id:resp.razorpay_order_id||'N/A'};
      for(var k in fields){var i=document.createElement('input');i.type='hidden';i.name=k;i.value=fields[k];form.appendChild(i);}
      document.body.appendChild(form);form.submit();
    },
    prefill:{name:'<%=student.getName()%>',email:'<%=student.getEmail()%>'},
    theme:{color:'#4f8ef7'},modal:{confirm_close:true}
  });
  rzp.on('payment.failed',function(r){alert('Payment failed: '+r.error.description);});
  rzp.open();
}
</script>
</body></html>
