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

/* Background */

body{

min-height:100vh;

background:
linear-gradient(rgba(0,0,0,0.65),rgba(0,0,0,0.65)),
url("https://images.unsplash.com/photo-1542314831-068cd1dbfeeb");

background-size:cover;
background-position:center;

}

/* Center Wrapper */

.dashboard-wrapper{

display:flex;
justify-content:center;
align-items:center;

height:calc(100vh - 80px);

}

/* Dashboard Card */

.dashboard{

width:700px;

padding:40px;

background:rgba(255,255,255,0.12);

border-radius:20px;

backdrop-filter:blur(15px);

box-shadow:0 10px 40px rgba(0,0,0,0.4);

text-align:center;

color:white;

animation:fadeIn 1s ease;

}

/* Title */

.dashboard h2{

margin-bottom:30px;

font-weight:600;

letter-spacing:1px;

}

/* Menu Grid */

.menu{

display:grid;

grid-template-columns:1fr 1fr;

gap:20px;

}

/* Menu Buttons */

.menu a{

display:flex;

align-items:center;

justify-content:center;

gap:10px;

padding:15px;

background:#d4af37;

color:white;

text-decoration:none;

border-radius:10px;

font-weight:500;

transition:0.3s;

}

.menu a:hover{

background:#b9972f;

transform:scale(1.05);

}

/* Logout Button */

.logout{

margin-top:25px;

display:inline-block;

padding:12px 25px;

background:#e74c3c;

border-radius:8px;

color:white;

text-decoration:none;

font-weight:500;

transition:0.3s;

}

.logout:hover{

background:#c0392b;

transform:scale(1.05);

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

/* Mobile */

@media(max-width:600px){

.menu{
grid-template-columns:1fr;
}

.dashboard{
width:90%;
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