<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contact & Guest Guide | Ocean View Resort - Galle</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&family=Playfair+Display:wght@500;600&display=swap" rel="stylesheet">

<style>
*{margin:0; padding:0; box-sizing:border-box; font-family:Poppins;}

body{
background:#f5f7fa;
color:#333;
}

/* HERO */
.hero{
height:350px;
background:
linear-gradient(rgba(0,0,0,0.45),rgba(0,0,0,0.45)),
url("https://images.unsplash.com/photo-1507525428034-b723cf961d3e");
background-size:cover;
background-position:center;
display:flex;
align-items:center;
justify-content:center;
text-align:center;
color:white;
}
.hero h1{
font-family:"Playfair Display";
font-size:48px;
letter-spacing:2px;
}

/* MAIN CONTAINER */
.container{
width:90%;
max-width:1200px;
margin:auto;
margin-top:60px;
display:grid;
grid-template-columns:1fr 1fr;
gap:50px;
}

/* CONTACT INFO CARD */
.contact-info{
background:white;
padding:40px;
border-radius:12px;
box-shadow:0 10px 30px rgba(0,0,0,0.1);
}
.contact-info h2{
font-family:"Playfair Display";
margin-bottom:20px;
color:#0b3d5c;
}
.info-box{
margin-bottom:25px;
}
.info-box h4{
color:#d4af37;
margin-bottom:6px;
}

/* CONTACT FORM */
.contact-form{
background:white;
padding:40px;
border-radius:12px;
box-shadow:0 10px 30px rgba(0,0,0,0.1);
}
.contact-form h2{
font-family:"Playfair Display";
margin-bottom:25px;
color:#0b3d5c;
}
.form-group{
margin-bottom:18px;
}
input, textarea{
width:100%;
padding:12px;
border:1px solid #ddd;
border-radius:6px;
font-size:14px;
}
textarea{
resize:none;
height:120px;
}
button{
background:#0b3d5c;
color:white;
border:none;
padding:12px 25px;
border-radius:6px;
cursor:pointer;
font-size:15px;
transition:0.3s;
}
button:hover{
background:#d4af37;
color:#000;
}

/* GUIDE SECTION */
.guide{
margin-top:60px;
background:white;
padding:40px;
border-radius:12px;
box-shadow:0 10px 30px rgba(0,0,0,0.1);
}
.guide h2{
font-family:"Playfair Display";
color:#0b3d5c;
margin-bottom:20px;
}
.guide ol{
margin-left:20px;
}
.guide li{
margin-bottom:15px;
line-height:1.6;
}

/* MAP */
.map{
margin-top:70px;
width:90%;
max-width:1200px;
margin-left:auto;
margin-right:auto;
border-radius:12px;
overflow:hidden;
box-shadow:0 10px 30px rgba(0,0,0,0.1);
}

/* SUCCESS MSG */
.success-msg{
background:#d4edda;
color:#155724;
padding:12px;
margin-bottom:20px;
border-radius:6px;
}

@media(max-width:900px){
.container{grid-template-columns:1fr;}
.hero h1{font-size:36px;}
}

</style>
</head>
<body>

<jsp:include page="/views/designs/header.jsp"/>

<!-- HERO -->
<div class="hero">
<h1>Contact & Guest Guide</h1>
</div>

<!-- CONTACT SECTION -->
<div class="container">

<!-- INFO -->
<div class="contact-info">

<h2>Contact Information</h2>

<div class="info-box">
<h4>Address</h4>
<p>Ocean View Resort<br>
Lighthouse Street, Galle, Sri Lanka</p>
</div>

<div class="info-box">
<h4>Phone</h4>
<p>+94 91 234 5678</p>
</div>

<div class="info-box">
<h4>Email</h4>
<p>info@oceanviewresort.lk</p>
</div>

<div class="info-box">
<h4>Working Hours</h4>
<p>Monday – Sunday, 24 Hours Guest Service</p>
</div>

</div>

<!-- CONTACT FORM -->
<div class="contact-form">

<h2>Send Us a Message</h2>

<%
String success = request.getParameter("success");
if(success != null){
%>
<div class="success-msg">
Your message has been sent successfully!
</div>
<%
}
%>

<form action="<%=request.getContextPath()%>/ContactServlet" method="post">

<div class="form-group">
<input type="text" name="name" placeholder="Your Name" required>
</div>

<div class="form-group">
<input type="email" name="email" placeholder="Your Email" required>
</div>

<div class="form-group">
<input type="text" name="subject" placeholder="Subject">
</div>

<div class="form-group">
<textarea name="message" placeholder="Write your message..." required></textarea>
</div>

<button type="submit">Send Message</button>

</form>

</div>
</div>

<!-- HOW TO USE GUIDE -->
<div class="container">
<div class="guide">
<h2>How to Use Our Booking System</h2>
<ol>
<li><b>Register:</b> Click the "Sign Up" button on the top right, fill your details, and create your account.</li>
<li><b>Login:</b> Use your email and password to log in securely from the "Login" page.</li>
<li><b>Book a Room:</b> Browse available rooms, select check-in and check-out dates, choose number of guests, and click "Book Now".</li>
<li><b>Transaction:</b> After booking, you will be redirected to the payment page. Enter your payment details to complete the transaction. Once successful, your booking will be confirmed.</li>
<li><b>View Bookings:</b> Navigate to "My Bookings" from your dashboard to see all your current and past bookings.</li>
</ol>
</div>
</div>

<!-- GOOGLE MAP -->
<div class="map">
<iframe
width="100%"
height="350"
frameborder="0"
style="border:0"
src="https://maps.google.com/maps?q=galle%20sri%20lanka&t=&z=13&ie=UTF8&iwloc=&output=embed"
allowfullscreen>
</iframe>
</div>

<div class="footer-space" style="height:80px;"></div>

</body>
</html>