<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
<title>User Login | Principe Grand Colombo</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<!-- Icons -->
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
    url("https://images.unsplash.com/photo-1566073771259-6a8506099945");
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
    background: url('${pageContext.request.contextPath}/views/images/header.jpg') center/cover no-repeat;
    height: 230px;
    color: white;
    animation: fadeIn 1.2s ease-in-out;
}

.overlay{
    background: linear-gradient(to bottom, rgba(0,0,0,0.75), rgba(0,0,0,0.55));
    height:100%;
    padding:25px 80px;
    display:flex;
    flex-direction:column;
    justify-content:space-between;
}

.header-top-row{
    display:flex;
    justify-content:space-between;
    align-items:center;
    font-size:14px;
}

.header-top-row strong{
    font-size:18px;
    letter-spacing:2px;
}

.header-top-row div:last-child{
    backdrop-filter:blur(8px);
    background:rgba(255,255,255,0.06);
    padding:8px 18px;
    border-radius:30px;
}

.header-top-row a{
    color:white;
    text-decoration:none;
    margin-left:20px;
    font-weight:500;
    position:relative;
    transition:0.3s;
}

.header-top-row a::after{
    content:"";
    position:absolute;
    width:0%;
    height:2px;
    bottom:-4px;
    left:0;
    background:#ffd700;
    transition:0.4s;
}

.header-top-row a:hover::after{
    width:100%;
}

.header-top-row a:hover{
    color:#ffd700;
}

.book-btn{
    background:linear-gradient(45deg,#ffd700,#e6c200);
    color:black !important;
    padding:8px 18px;
    border-radius:30px;
    font-weight:600;
    transition:0.3s ease;
}

.book-btn:hover{
    transform:translateY(-3px);
    box-shadow:0 8px 20px rgba(255,215,0,0.4);
}

.brand-center{
    text-align:center;
}

.brand-center h1{
    font-family:'Playfair Display', serif;
    font-size:42px;
    letter-spacing:4px;
    background:linear-gradient(to right,#ffd700,#fff,#ffd700);
    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
}

.brand-center span{
    font-size:18px;
    letter-spacing:3px;
    color:#f5e6c8;
}

.nav-menu{
    display:flex;
    justify-content:center;
    gap:35px;
    font-size:14px;
}

.nav-menu a{
    color:white;
    text-decoration:none;
    font-weight:500;
    position:relative;
    padding-bottom:5px;
    transition:0.3s;
}

.nav-menu a::after{
    content:"";
    position:absolute;
    width:0%;
    height:2px;
    bottom:0;
    left:0;
    background:#ffd700;
    transition:0.4s ease;
}

.nav-menu a:hover::after{
    width:100%;
}

.nav-menu a:hover{
    color:#ffd700;
}

/* ===== LOGIN FORM ===== */
.login-container{
    width:380px;
    padding:40px;
    background:rgba(255,255,255,0.12);
    border-radius:18px;
    backdrop-filter:blur(20px);
    box-shadow:0 10px 40px rgba(0,0,0,0.4);
    text-align:center;
    color:white;
    animation:fadeIn 1s ease;
    margin: 50px auto 0 auto; /* push below fixed header */
}

.login-container h2{
    margin-bottom:25px;
    font-weight:600;
}

.input-group{
    position:relative;
    margin-bottom:20px;
}

.input-group input{
    width:100%;
    padding:12px 40px;
    border:none;
    border-radius:8px;
    outline:none;
    background:rgba(255,255,255,0.9);
}

.input-group i{
    position:absolute;
    top:50%;
    left:12px;
    transform:translateY(-50%);
    color:#444;
}

.login-btn{
    width:100%;
    padding:12px;
    background:#d4af37;
    border:none;
    border-radius:8px;
    color:white;
    font-size:15px;
    cursor:pointer;
    transition:0.3s;
}

.login-btn:hover{
    background:#b9972f;
    transform:scale(1.05);
}

.register{
    margin-top:18px;
    font-size:14px;
}

.register a{
    color:#ffd369;
    text-decoration:none;
    font-weight:500;
}

.register a:hover{
    text-decoration:underline;
}

.error{
    margin-top:15px;
    color:#ff6b6b;
}

/* ===== ANIMATION ===== */
@keyframes fadeIn{
    from{opacity:0; transform:translateY(30px);}
    to{opacity:1; transform:translateY(0);}
}

/* ===== RESPONSIVE ===== */
@media(max-width:420px){
    .login-container{
        width:90%;
    }
}

</style>

</head>

<body>

<!-- INCLUDE HEADER -->
<jsp:include page="/views/designs/header.jsp" />

<!-- LOGIN FORM -->
<div class="login-container">
<h2>User Login</h2>

<form action="../UserLoginServlet" method="post">
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
</form>

<div class="register">
Don't have an account?  
<a href="register.jsp">Create Account</a>
</div>

<% if(request.getParameter("error") != null){ %>
<p class="error">Invalid Login!</p>
<% } %>

</div>

</body>
</html>