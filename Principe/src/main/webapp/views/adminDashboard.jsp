<%@ page language="java" %>
<%
    if(session.getAttribute("admin") == null){
        response.sendRedirect("adminLogin.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>

<h2>Admin Dashboard</h2>

<a href="<%= request.getContextPath() %>/RoomServlet?action=list">
    Manage Rooms
</a><br>
<a href="../LogoutServlet">Logout</a><br>
<a href="facility/listFacility.jsp">Facilities</a><br>
<a href="<%= request.getContextPath() %>/AdminBookingServlet?action=list">
    Manage Bookings
</a><br>
<a href="admin/listAdmins.jsp">View Admin</a>


</body>
</html>