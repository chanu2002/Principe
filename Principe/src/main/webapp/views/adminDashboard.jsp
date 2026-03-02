<%@ page language="java" %>
<%
    if(session.getAttribute("admin") == null){
        response.sendRedirect("adminLogin.jsp");
    }
%>

<%@ page language="java" %>
<%
    // Prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Session validation
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
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
<a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
<a href="facility/listFacility.jsp">Facilities</a><br>
<a href="<%= request.getContextPath() %>/AdminBookingServlet?action=list">
    Manage Bookings
</a><br>
<a href="admin/listAdmins.jsp">View Admin</a>
<a href="<%= request.getContextPath() %>/ReviewServlet?action=adminList">
    Manage Reviews
</a><br>
<a href="<%= request.getContextPath() %>/OfferServlet?action=list">
    Manage Offers
</a><br>


</body>
</html>