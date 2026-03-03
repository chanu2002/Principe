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
    <title>Admin Dashboard</title>

    <script>
        // Push a new state so back button won't go immediately
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

<h2>Admin Dashboard</h2>

<a href="<%= request.getContextPath() %>/RoomServlet?action=list">
    Manage Rooms
</a><br><br>

<a href="<%= request.getContextPath() %>/AdminBookingServlet?action=list">
    Manage Bookings
</a><br><br>

<a href="<%= request.getContextPath() %>/ReviewServlet?action=adminList">
    Manage Reviews
</a><br><br>

<a href="<%= request.getContextPath() %>/OfferServlet?action=list">
    Manage Offers
</a><br><br>

<a href="facility/listFacility.jsp">Facilities</a><br><br>

<a href="admin/listAdmins.jsp">View Admin</a><br><br>

<a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>

</body>
</html>