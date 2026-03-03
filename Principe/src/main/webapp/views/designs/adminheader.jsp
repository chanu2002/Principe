<%@ page language="java" %>
<%
    // Get admin object from session
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
<style>

.admin-header {
    width: 100%;
    height: 70px;
    background-color: #1e2a38;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 30px;
    box-sizing: border-box;
    color: white;
    font-family: Arial, sans-serif;
}

/* Left side title */
.admin-title {
    font-size: 20px;
    font-weight: bold;
    letter-spacing: 1px;
}

/* Right side profile */
.admin-profile {
    display: flex;
    align-items: center;
}

/* Text section */
.admin-info {
    text-align: right;
    margin-right: 15px;
}

.admin-name {
    font-size: 15px;
    font-weight: bold;
}

.admin-role {
    font-size: 12px;
    color: #b0bec5;
}

/* Profile image */
.admin-avatar {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid #ffffff;
}

</style>
</head>

<body>

<div class="admin-header">

    <div class="admin-title">
        Hotel Admin Panel
    </div>

    <div class="admin-profile">

        <div class="admin-info">
            <div class="admin-name">
                <%= adminName %>
            </div>
            <div class="admin-role">
                <%= adminRole %>
            </div>
        </div>

        <img src="<%= request.getContextPath() %>/AdminImageServlet?id=<%= admin != null ? admin.getAdminId() : "" %>"
     class="admin-avatar"
     alt="Admin Image">

    </div>

</div>

</body>
</html>