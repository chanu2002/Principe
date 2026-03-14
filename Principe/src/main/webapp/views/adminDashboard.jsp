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
<title>Admin Dashboard | Ocean View Resort - Galle</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&family=Playfair+Display:wght@500;600&display=swap" rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

/* ===== BACKGROUND ===== */
body{
    min-height:100vh;
    background:
      linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.8)),
      url("https://images.unsplash.com/photo-1507525428034-b723cf961d3e");
    background-size:cover;
    background-position:center;
    background-attachment:fixed;
}

/* ===== DASHBOARD WRAPPER ===== */
.dashboard-wrapper{
    display:flex;
    justify-content:center;
    align-items:flex-start;
    padding:50px 20px;
}

/* ===== GLASS CARD ===== */
.dashboard{
    width:800px;
    padding:50px;
    background:rgba(255,255,255,0.07);
    border-radius:30px;
    backdrop-filter:blur(25px);
    border:1px solid rgba(255,255,255,0.2);
    box-shadow:0 35px 100px rgba(0,0,0,0.7);
    color:white;
    animation:fadeIn 1s ease;
}

/* ===== TITLE ===== */
.dashboard h2{
    margin-bottom:50px;
    font-weight:600;
    letter-spacing:1px;
    font-family:"Playfair Display";
    font-size:36px;
    color:#f1f6ff;
    text-shadow: 0 2px 10px rgba(0,0,0,0.5);
}

/* ===== MENU GRID ===== */
.menu{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:30px;
}

/* ===== MENU BUTTONS ===== */
.menu a{
    display:flex;
    align-items:center;
    justify-content:center;
    gap:15px;
    padding:20px;
    background:linear-gradient(145deg,#1e90ff,#5dade2);
    color:white;
    text-decoration:none;
    border-radius:20px;
    font-weight:500;
    font-size:17px;
    transition:0.5s;
    box-shadow:0 10px 30px rgba(0,0,0,0.5);
    backdrop-filter:blur(5px);
}
.menu a i{
    font-size:20px;
}
.menu a:hover{
    background:linear-gradient(145deg,#3498db,#85c1e9);
    transform:translateY(-6px) scale(1.05);
    box-shadow:0 20px 50px rgba(0,0,0,0.6);
}

/* ===== LOGOUT BUTTON ===== */
.logout{
    margin-top:40px;
    display:inline-block;
    padding:18px 35px;
    background:linear-gradient(135deg,#ff4b2b,#ff416c);
    border-radius:15px;
    color:white;
    text-decoration:none;
    font-weight:600;
    letter-spacing:1px;
    font-size:16px;
    transition:0.5s;
    box-shadow:0 10px 30px rgba(0,0,0,0.5);
}
.logout:hover{
    transform:translateY(-4px) scale(1.05);
    box-shadow:0 20px 50px rgba(0,0,0,0.7);
}

/* ===== FADE IN ===== */
@keyframes fadeIn{
    from{
        opacity:0;
        transform:translateY(60px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

/* ===== MOBILE ===== */
@media(max-width:750px){
    .menu{grid-template-columns:1fr;}
    .dashboard{width:95%; padding:40px;}
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
            
             <a href="admin/allusers.jsp">
                <i class="fa fa-users"></i> View Users
            </a>
            <a href="admin/Stats.jsp">
                <i class="fa fa-chart-bar"></i> Statistics
            </a>
        </div>

       
    </div>
</div>

</body>
</html>