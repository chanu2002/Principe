<%@ page language="java" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard | Principe Grand Colombo</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<!-- Icons -->
<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
}

/* ===== NEW BACKGROUND ===== */

body{

min-height:100vh;

background:
linear-gradient(rgba(10,25,55,0.75),rgba(10,25,55,0.85)),
url("https://images.unsplash.com/photo-1501117716987-c8e1ecb210c1");

background-size:cover;
background-position:center;
background-attachment:fixed;

}

/* ===== CENTER WRAPPER ===== */

.dashboard-wrapper{

display:flex;
justify-content:center;
align-items:center;

height:calc(100vh - 80px);

padding:20px;

}

/* ===== DASHBOARD CARD ===== */

.dashboard{

width:720px;

padding:45px;

background:rgba(255,255,255,0.08);

border-radius:25px;

backdrop-filter:blur(18px);

border:1px solid rgba(255,255,255,0.15);

box-shadow:0 25px 70px rgba(0,0,0,0.6);

text-align:center;

color:white;

animation:fadeIn 1s ease;

}

/* ===== TITLE ===== */

.dashboard h2{

margin-bottom:35px;

font-weight:600;

letter-spacing:1px;

color:#e6f1ff;

}

/* ===== MENU GRID ===== */

.menu{

display:grid;

grid-template-columns:1fr 1fr;

gap:22px;

}

/* ===== MENU BUTTONS ===== */

.menu a{

display:flex;

align-items:center;
justify-content:center;
gap:10px;

padding:16px;

background:linear-gradient(135deg,#1e90ff,#5dade2);

color:white;

text-decoration:none;

border-radius:12px;

font-weight:500;

font-size:15px;

transition:0.3s;

box-shadow:0 5px 20px rgba(0,0,0,0.3);

}

.menu a i{
font-size:16px;
}

/* Hover */

.menu a:hover{

background:linear-gradient(135deg,#3498db,#85c1e9);

transform:translateY(-4px);

box-shadow:0 10px 30px rgba(0,0,0,0.5);

}

/* ===== LOGOUT BUTTON ===== */

.logout{

margin-top:30px;

display:inline-block;

padding:13px 28px;

background:linear-gradient(135deg,#ff4b2b,#ff416c);

border-radius:10px;

color:white;

text-decoration:none;

font-weight:500;

letter-spacing:0.5px;

transition:0.3s;

}

.logout:hover{

transform:translateY(-3px);

box-shadow:0 10px 25px rgba(0,0,0,0.4);

}

/* ===== ANIMATION ===== */

@keyframes fadeIn{

from{
opacity:0;
transform:translateY(40px);
}

to{
opacity:1;
transform:translateY(0);
}

}

/* ===== MOBILE ===== */

@media(max-width:600px){

.menu{
grid-template-columns:1fr;
}

.dashboard{
width:95%;
padding:35px;
}

}

</style>

<script>

history.pushState(null, null, location.href);

window.onpopstate = function () {

var confirmLogout = confirm("Do you want to logout?");

if (confirmLogout) {

window.location.href = "<%= request.getContextPath() %>/LogoutServlet";

} else {

history.pushState(null, null, location.href);

}

};

</script>

</head>

<body>

<!-- Header -->
<%@ include file="designs/adminheader.jsp" %>

<div class="dashboard-wrapper">

<div class="dashboard">

<h2>Admin Dashboard</h2>

<div class="menu">

<a href="<%= request.getContextPath() %>/RoomServlet?action=list">
<i class="fa fa-bed"></i> Manage Rooms
</a>

<a href="<%= request.getContextPath() %>/AdminBookingServlet?action=list">
<i class="fa fa-calendar-check"></i> Manage Bookings
</a>

<a href="<%= request.getContextPath() %>/ReviewServlet?action=adminList">
<i class="fa fa-star"></i> Manage Reviews
</a>

<a href="<%= request.getContextPath() %>/OfferServlet?action=list">
<i class="fa fa-tags"></i> Manage Offers
</a>

<a href="facility/listFacility.jsp">
<i class="fa fa-spa"></i> Facilities
</a>

<a href="admin/listAdmins.jsp">
<i class="fa fa-user-shield"></i> View Admin
</a>

</div>

<a class="logout" href="<%= request.getContextPath() %>/LogoutServlet">
<i class="fa fa-sign-out-alt"></i> Logout
</a>

</div>

</div>

</body>
</html>