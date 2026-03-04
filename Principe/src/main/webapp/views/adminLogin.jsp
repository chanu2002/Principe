<%@ page language="java" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session.getAttribute("admin") != null) {
        response.sendRedirect("adminDashboard.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Login | Principe Grand Colombo</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
}


/* ================= BODY ================= */
/* Header height = 230px → +10px gap = 240px */
body{

min-height:100vh;
padding-top:0;

background:
linear-gradient(rgba(0,0,0,0.65),rgba(0,0,0,0.65)),
url("https://images.unsplash.com/photo-1566073771259-6a8506099945");

background-size:cover;
background-position:center;

}


/* ================= LOGIN CARD ================= */

.login-container{

width:380px;
padding:45px;

background:rgba(255,255,255,0.12);
backdrop-filter:blur(20px);

border-radius:18px;
box-shadow:0 10px 35px rgba(0,0,0,0.4);

text-align:center;
color:white;

animation:fadeIn 1s ease;

/* center horizontally only */
margin: 0 auto;

}


/* Title */

.login-container h2{
margin-bottom:30px;
font-weight:600;
letter-spacing:1px;
}


/* Inputs */

.input-group{
position:relative;
margin-bottom:20px;
}

.input-group input{
width:100%;
padding:12px 40px;
border:none;
outline:none;
border-radius:8px;
background:rgba(255,255,255,0.9);
font-size:14px;
}


/* Icons */

.input-group i{
position:absolute;
top:50%;
left:12px;
transform:translateY(-50%);
color:#444;
}


/* Button */

.login-btn{
width:100%;
padding:12px;
border:none;
border-radius:8px;
background:#d4af37;
color:white;
font-size:16px;
font-weight:500;
cursor:pointer;
transition:0.3s;
}

.login-btn:hover{
background:#b9972f;
transform:scale(1.05);
}


/* Error */

.error{
margin-top:15px;
color:#ff6b6b;
}


/* Animation */

@keyframes fadeIn{
from{
opacity:0;
transform:translateY(30px);
}
to{
opacity:1;
transform:translateY(0);
}
}


/* Responsive */

@media(max-width:420px){
.login-container{
width:90%;
padding:35px;
}
}

</style>
</head>

<body>

<!-- HEADER INCLUDE -->
<jsp:include page="/views/designs/header.jsp" />

<!-- LOGIN FORM -->
<div class="login-container">

<h2>Admin Login</h2>

<form action="<%= request.getContextPath() %>/AdminLoginServlet" method="post">

<div class="input-group">
<i class="fa fa-user"></i>
<input type="text" name="username" placeholder="Username" required>
</div>

<div class="input-group">
<i class="fa fa-lock"></i>
<input type="password" name="password" placeholder="Password" required>
</div>

<button type="submit" class="login-btn">
<i class="fa fa-sign-in-alt"></i> Login
</button>

<% if(request.getAttribute("error") != null){ %>
<p class="error"><%= request.getAttribute("error") %></p>
<% } %>

</form>

</div>

</body>
</html>