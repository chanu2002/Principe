<%@ page language="java" %>
<%
    model.Admin admin = (model.Admin) session.getAttribute("admin");

    String adminName = "Admin";
    String adminRole = "Administrator";

    if(admin != null){
        adminName = admin.getName();
        adminRole = admin.getRole();
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hotel Admin Header</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&family=Playfair+Display:wght@500&display=swap" rel="stylesheet">

<style>

body{
    margin:0;
    font-family:'Poppins',sans-serif;
}

/* HEADER */

.admin-header{
    width:100%;
    height:75px;
    background:#111;
    display:flex;
    align-items:center;
    justify-content:space-between;
    padding:0 40px;
    box-sizing:border-box;
}

/* LEFT LOGO */

.admin-title{
    font-family:'Playfair Display',serif;
    font-size:22px;
    letter-spacing:3px;
    color:white;
}

/* CENTER MENU */

.admin-menu{
    display:flex;
    gap:30px;
}

.admin-menu a{
    color:white;
    text-decoration:none;
    font-size:14px;
    letter-spacing:1px;
    transition:0.3s;
}

.admin-menu a:hover{
    color:#f2c200;
}

/* RIGHT PROFILE */

.admin-profile{
    display:flex;
    align-items:center;
    gap:12px;
}

/* TEXT */

.admin-info{
    text-align:right;
}

.admin-name{
    font-size:14px;
    font-weight:500;
    color:white;
}

.admin-role{
    font-size:11px;
    color:#bbb;
}

/* AVATAR */

.admin-avatar{
    width:42px;
    height:42px;
    border-radius:50%;
    object-fit:cover;
    border:2px solid #f2c200;
}

/* BUTTON */

.logout-btn{
    margin-left:15px;
    padding:6px 14px;
    border-radius:20px;
    background:#f2c200;
    color:black;
    text-decoration:none;
    font-size:13px;
    font-weight:500;
}

.logout-btn:hover{
    background:#ffd700;
}

</style>
</head>

<body>

<div class="admin-header">

    <!-- LEFT -->
    <div class="admin-title">
        PRINCIPE
    </div>

    <!-- CENTER MENU -->
  

    <!-- RIGHT PROFILE -->
    <div class="admin-profile">

        <div class="admin-info">
            <div class="admin-name"><%= adminName %></div>
            <div class="admin-role"><%= adminRole %></div>
        </div>

        <img src="<%= request.getContextPath() %>/AdminImageServlet?id=<%= admin != null ? admin.getAdminId() : "" %>"
             class="admin-avatar"
             alt="Admin">

       
        
        <a href="${pageContext.request.contextPath}/LogoutServlet"
   class="logout-btn"
   onclick="return confirmLogout()">
   Logout
</a>


<script>
function confirmLogout() {
    return confirm("Are you sure you want to logout?");
}
</script>

    </div>

</div>

</body>
</html>