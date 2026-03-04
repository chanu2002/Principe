<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
<title>User Registration | Principe Grand Colombo</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<!-- Font Awesome Icons -->
<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

/* ===== GLOBAL ===== */
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    min-height:100vh;
    background:
    linear-gradient(rgba(0,0,0,0.65),rgba(0,0,0,0.65)),
    url("https://images.unsplash.com/photo-1590490360182-c33d57733427");
    background-size:cover;
    background-position:center;
}

/* ===== HEADER ===== */
.top-header{
    position: fixed;       /* Always on top */
    top: 0;
    left: 0;
    width: 100%;
    z-index: 9999;
}

/* ===== REGISTER FORM ===== */
.register-container{
    width:420px;
    padding:40px;
    background:rgba(255,255,255,0.12);
    border-radius:18px;
    backdrop-filter:blur(20px);
    box-shadow:0 10px 40px rgba(0,0,0,0.4);
    text-align:center;
    color:white;
    animation:fadeIn 1s ease;
    margin: 10px auto 0 auto; /* push below fixed header */
}

.register-container h2{
    margin-bottom:25px;
    font-weight:600;
}

.input-group{
    position:relative;
    margin-bottom:18px;
}

.input-group input{
    width:100%;
    padding:12px 40px;
    border:none;
    border-radius:8px;
    outline:none;
    background:rgba(255,255,255,0.9);
    font-size:14px;
}

.input-group i{
    position:absolute;
    top:50%;
    left:12px;
    transform:translateY(-50%);
    color:#444;
}

.register-btn{
    width:100%;
    padding:12px;
    background:#d4af37;
    border:none;
    border-radius:8px;
    color:white;
    font-size:15px;
    font-weight:500;
    cursor:pointer;
    transition:0.3s;
}

.register-btn:hover{
    background:#b9972f;
    transform:scale(1.03);
}

/* ===== ANIMATION ===== */
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

/* ===== MOBILE ===== */
@media(max-width:450px){
    .register-container{
        width:90%;
        padding:30px;
    }
}

</style>
</head>

<body>

<!-- INCLUDE HEADER -->
<jsp:include page="/views/designs/header.jsp" />

<!-- REGISTER FORM -->
<div class="register-container">
<h2>User Registration</h2>

<form action="../UserRegisterServlet" method="post">

<div class="input-group">
<i class="fa fa-user"></i>
<input type="text" name="username" placeholder="Username" required>
</div>

<div class="input-group">
<i class="fa fa-lock"></i>
<input type="password" name="password" placeholder="Password" required>
</div>

<div class="input-group">
<i class="fa fa-id-card"></i>
<input type="text" name="name" placeholder="Full Name" required>
</div>

<div class="input-group">
<i class="fa fa-envelope"></i>
<input type="email" name="email" placeholder="Email" required>
</div>

<div class="input-group">
<i class="fa fa-phone"></i>
<input type="text" name="tel" placeholder="Telephone" required>
</div>

<div class="input-group">
<i class="fa fa-location-dot"></i>
<input type="text" name="address" placeholder="Address" required>
</div>

<button type="submit" class="register-btn">
<i class="fa fa-user-plus"></i> Register
</button>

</form>
</div>

<!-- SUCCESS ALERT & REDIRECT -->
<%
    String success = request.getParameter("success");
    if("1".equals(success)){
%>
<script>
    alert("Registered Successfully!");
    window.location.href = "<%=request.getContextPath()%>/index.jsp";
</script>
<%
    }
%>

</body>
</html>