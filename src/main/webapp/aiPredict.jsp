<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.student.model.Student" %>
<%
  Student student=(Student)session.getAttribute("student");
  if(student==null){response.sendRedirect("login.jsp");return;}
%>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><title>AI Predictor — EduSphere</title>
<link href="https://fonts.googleapis.com/css2?family=Clash+Display:wght@500;700&family=Satoshi:wght@400;500;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
:root{--navy:#0a0f2c;--card:#0f1530;--accent:#4f8ef7;--teal:#00d4aa;--gold:#f5c842;--rose:#ff6b8a;--purple:#7b6cf6;--green:#34d399;--border:rgba(255,255,255,.08);--text:#e8eaf6;--muted:#8892b0;}
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Satoshi',sans-serif;background:var(--navy);color:var(--text);min-height:100vh;padding:36px 40px;background-image:radial-gradient(ellipse 60% 50% at 10% 10%,#1a2a6c30,transparent 60%),radial-gradient(ellipse 50% 40% at 90% 90%,#00d4aa12,transparent 60%);}
.back{display:inline-flex;align-items:center;gap:8px;color:var(--muted);text-decoration:none;font-size:.85rem;margin-bottom:24px;transition:color .2s;}
.back:hover{color:var(--teal);}
.ai-badge{display:inline-flex;align-items:center;gap:8px;padding:6px 14px;border-radius:50px;background:rgba(0,212,170,.1);border:1px solid rgba(0,212,170,.2);color:var(--teal);font-size:.72rem;font-weight:700;letter-spacing:1px;text-transform:uppercase;margin-bottom:14px;}
.dot{width:6px;height:6px;border-radius:50%;background:var(--teal);animation:pulse 1.5s infinite;}
@keyframes pulse{0%,100%{opacity:1}50%{opacity:.3}}
.pt{font-family:'Clash Display',sans-serif;font-size:1.9rem;font-weight:700;color:#fff;margin-bottom:6px;}
.ps{color:var(--muted);font-size:.9rem;margin-bottom:32px;}
.layout{display:grid;grid-template-columns:1fr 1.6fr;gap:26px;max-width:1100px;}
.card{background:var(--card);border:1px solid var(--border);border-radius:18px;padding:26px;}
.ct{font-family:'Clash Display',sans-serif;font-size:.95rem;font-weight:600;color:#fff;margin-bottom:18px;display:flex;align-items:center;gap:8px;}
.fg{margin-bottom:18px;}
.fl{display:block;font-size:.8rem;font-weight:600;color:var(--muted);margin-bottom:8px;}
.slider{width:100%;appearance:none;height:5px;border-radius:3px;background:rgba(255,255,255,.06);outline:none;}
.slider::-webkit-slider-thumb{appearance:none;width:18px;height:18px;border-radius:50%;background:var(--teal);cursor:pointer;box-shadow:0 0 8px rgba(0,212,170,.4);}
.sval{font-size:.85rem;font-weight:700;color:var(--teal);margin-top:5px;text-align:right;}
.fi{width:100%;padding:10px 12px;background:rgba(255,255,255,.05);border:1.5px solid var(--border);border-radius:9px;color:var(--text);font-size:.88rem;font-family:'Satoshi',sans-serif;outline:none;transition:all .2s;}
.fi:focus{border-color:var(--teal);}
.fi option{background:var(--card);}
.btn-pred{width:100%;padding:13px;border-radius:10px;border:none;background:linear-gradient(135deg,var(--teal),var(--green));color:var(--navy);font-family:'Satoshi',sans-serif;font-size:.93rem;font-weight:800;cursor:pointer;transition:all .3s;display:flex;align-items:center;justify-content:center;gap:10px;margin-top:8px;}
.btn-pred:hover{transform:translateY(-2px);box-shadow:0 8px 24px rgba(0,212,170,.35);}
.result{display:none;}
.result.show{display:block;}
.loading{display:none;text-align:center;padding:40px;}
.loading.show{display:block;}
.spinner{width:48px;height:48px;border-radius:50%;border:3px solid rgba(0,212,170,.15);border-top-color:var(--teal);animation:spin .8s linear infinite;margin:0 auto 16px;}
@keyframes spin{to{transform:rotate(360deg)}}
.score-wrap{display:flex;align-items:center;gap:24px;margin-bottom:22px;padding:20px;border-radius:13px;background:rgba(0,212,170,.06);border:1px solid rgba(0,212,170,.14);}
.ring{width:96px;height:96px;border-radius:50%;display:flex;align-items:center;justify-content:center;position:relative;flex-shrink:0;}
.ring::before{content:'';position:absolute;inset:10px;border-radius:50%;background:var(--card);}
.rnum{position:relative;z-index:1;font-family:'Clash Display',sans-serif;font-size:1.4rem;font-weight:700;color:var(--teal);}
.rtitle{font-family:'Clash Display',sans-serif;font-size:1.15rem;color:#fff;margin-bottom:6px;}
.rsub{font-size:.84rem;color:var(--muted);line-height:1.6;}
.rgrade{display:inline-block;padding:4px 12px;border-radius:20px;font-size:.78rem;font-weight:700;margin-top:8px;}
.ig{display:grid;grid-template-columns:1fr 1fr;gap:12px;margin-bottom:20px;}
.ic{padding:14px;border-radius:11px;border:1px solid var(--border);background:rgba(255,255,255,.02);}
.ic-emoji{font-size:1.2rem;margin-bottom:6px;}
.ic-title{font-size:.78rem;font-weight:700;color:#fff;margin-bottom:3px;}
.ic-val{font-size:.77rem;color:var(--muted);line-height:1.5;}
.api-note{padding:13px;border-radius:10px;font-size:.79rem;background:rgba(79,142,247,.07);border:1px solid rgba(79,142,247,.14);color:var(--muted);line-height:1.6;margin-top:16px;}
.api-note strong{color:var(--accent);}
</style></head><body>
<a href="studentDashboard.jsp" class="back"><i class="fas fa-arrow-left"></i> Dashboard</a>
<div class="ai-badge"><div class="dot"></div> Python ML Powered</div>
<h1 class="pt"><i class="fas fa-brain" style="color:var(--teal);"></i> Performance Predictor</h1>
<p class="ps">Enter your academic data — our Python ML model analyses and predicts your performance</p>
<div class="layout">
  <!-- INPUT -->
  <div class="card">
    <div class="ct"><i class="fas fa-sliders-h" style="color:var(--teal);"></i> Your Data</div>
    <div class="fg"><label class="fl">Course</label>
      <select class="fi" id="course"><option>B.Tech CSE</option><option>B.Tech ECE</option><option>BCA</option><option>MBA</option></select>
    </div>
    <div class="fg"><label class="fl">Current GPA: <span id="gpaV" style="color:var(--teal);">8.4</span></label>
      <input type="range" class="slider" id="gpa" min="4" max="10" step="0.1" value="8.4" oninput="document.getElementById('gpaV').textContent=this.value">
    </div>
    <div class="fg"><label class="fl">Attendance: <span id="attV" style="color:var(--teal);">92</span>%</label>
      <input type="range" class="slider" id="att" min="50" max="100" step="1" value="92" oninput="document.getElementById('attV').textContent=this.value">
    </div>
    <div class="fg"><label class="fl">Assignments Done: <span id="assV" style="color:var(--teal);">85</span>%</label>
      <input type="range" class="slider" id="ass" min="0" max="100" step="1" value="85" oninput="document.getElementById('assV').textContent=this.value">
    </div>
    <div class="fg"><label class="fl">Study Hours/Day: <span id="stuV" style="color:var(--teal);">4</span>h</label>
      <input type="range" class="slider" id="stu" min="1" max="12" step="0.5" value="4" oninput="document.getElementById('stuV').textContent=this.value">
    </div>
    <div class="fg"><label class="fl">Previous Backlogs</label>
      <select class="fi" id="bl"><option value="0">None</option><option value="1">1 subject</option><option value="2">2 subjects</option><option value="3">3+ subjects</option></select>
    </div>
    <button class="btn-pred" onclick="predict()"><i class="fas fa-magic"></i> Analyse & Predict</button>
    <div class="api-note"><strong>How it works:</strong> Data sent to <strong>Python Flask API</strong> on port 5000. Scikit-learn ML model predicts performance. If Python is not running, local formula is used.</div>
  </div>
  <!-- OUTPUT -->
  <div>
    <div class="card loading" id="loadDiv"><div class="spinner"></div><p style="color:var(--muted);">Running AI analysis...</p></div>
    <div class="card result" id="resDiv">
      <div class="ct"><i class="fas fa-chart-line" style="color:var(--teal);"></i> AI Results</div>
      <div class="score-wrap">
        <div class="ring" id="scoreRing"><span class="rnum" id="scoreNum">—</span></div>
        <div>
          <div class="rtitle" id="resTitle">—</div>
          <div class="rsub" id="resSub">—</div>
          <span class="rgrade" id="resGrade">—</span>
        </div>
      </div>
      <div class="ig">
        <div class="ic"><div class="ic-emoji">📈</div><div class="ic-title">Predicted GPA</div><div class="ic-val" id="gpaPred">—</div></div>
        <div class="ic"><div class="ic-emoji">⚠️</div><div class="ic-title">Weak Area</div><div class="ic-val">DBMS needs attention</div></div>
        <div class="ic"><div class="ic-emoji">💡</div><div class="ic-title">AI Tip</div><div class="ic-val">Increase study by 1h/day for DBMS</div></div>
        <div class="ic"><div class="ic-emoji">🎯</div><div class="ic-title">Target</div><div class="ic-val" id="targetInfo">—</div></div>
      </div>
      <canvas id="radarChart" height="200"></canvas>
    </div>
    <div class="card" id="placeholder" style="text-align:center;padding:60px 30px;">
      <div style="font-size:4rem;margin-bottom:18px;">🤖</div>
      <h3 style="font-family:'Clash Display',sans-serif;color:#fff;margin-bottom:10px;">Ready to Analyse</h3>
      <p style="color:var(--muted);font-size:.88rem;line-height:1.7;">Fill your academic data and click <strong style="color:var(--teal);">Analyse & Predict</strong></p>
    </div>
  </div>
</div>
<script>
var radarChart=null;
function predict(){
  var gpa=parseFloat(document.getElementById('gpa').value);
  var att=parseInt(document.getElementById('att').value);
  var ass=parseInt(document.getElementById('ass').value);
  var stu=parseFloat(document.getElementById('stu').value);
  var bl=parseInt(document.getElementById('bl').value);
  document.getElementById('placeholder').style.display='none';
  document.getElementById('resDiv').classList.remove('show');
  document.getElementById('loadDiv').classList.add('show');
  // Try Python API first, fallback to formula
  fetch('http://localhost:5000/predict-performance',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({gpa:gpa,attendance:att,assignments:ass,studyHours:stu,backlogs:bl})})
  .then(function(r){return r.json();}).then(function(d){showResult(d,gpa,att,ass,stu);})
  .catch(function(){
    var score=Math.min(99,Math.round((gpa/10*35)+(att/100*25)+(ass/100*20)+(stu/12*15)-(bl*5)));
    var gpaPred=Math.min(10,(gpa+0.2+(att-75)/200)).toFixed(1);
    showResult({score:score,gpa_pred:gpaPred},gpa,att,ass,stu);
  });
}
function showResult(d,gpa,att,ass,stu){
  document.getElementById('loadDiv').classList.remove('show');
  document.getElementById('resDiv').classList.add('show');
  var s=d.score||84;
  document.getElementById('scoreNum').textContent=s+'%';
  var pct=s+'%';
  document.getElementById('scoreRing').style.background='conic-gradient(#00d4aa 0% '+pct+',rgba(255,255,255,.04) '+pct+' 100%)';
  var titles=['Excellent Performance Expected','Good Performance Expected','Average Performance Expected','Needs Improvement'];
  var grades=['Distinction Likely','First Class Likely','Pass Expected','At Risk'];
  var colors=['#00d4aa','#4f8ef7','#f5c842','#ff6b8a'];
  var bgs=['rgba(0,212,170,.15)','rgba(79,142,247,.15)','rgba(245,200,66,.15)','rgba(255,107,138,.15)'];
  var idx=s>=85?0:s>=70?1:s>=55?2:3;
  document.getElementById('resTitle').textContent=titles[idx];
  document.getElementById('resSub').textContent='Based on GPA, attendance and study habits analysis.';
  var g=document.getElementById('resGrade');
  g.textContent=grades[idx];g.style.background=bgs[idx];g.style.color=colors[idx];
  document.getElementById('gpaPred').textContent='Predicted: '+( d.gpa_pred||'8.6')+' GPA';
  document.getElementById('targetInfo').textContent=s>=85?'On track for Distinction':'Work on weaker subjects';
  if(radarChart)radarChart.destroy();
  radarChart=new Chart(document.getElementById('radarChart').getContext('2d'),{type:'radar',data:{labels:['GPA','Attendance','Assignments','Study Hrs','Consistency'],datasets:[{label:'Your Profile',data:[gpa*10,att,ass,stu/12*100,s],borderColor:'#00d4aa',backgroundColor:'rgba(0,212,170,.1)',borderWidth:2,pointBackgroundColor:'#00d4aa'}]},options:{responsive:true,scales:{r:{grid:{color:'rgba(255,255,255,.06)'},ticks:{display:false},pointLabels:{color:'#8892b0',font:{family:'Satoshi'}}}},plugins:{legend:{display:false}}}});
}
</script>
</body></html>
