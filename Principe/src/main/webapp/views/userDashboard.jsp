<%@ page language="java" %>
<%
    if(session.getAttribute("user") == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
</head>
<body>

<jsp:include page="/views/designs/header.jsp" />

<h2>User Dashboard</h2>

<!-- Access through Servlet -->

<br><br>

<a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a><br><br>

<h2>Search Available Rooms</h2>

<form action="<%= request.getContextPath() %>/RoomServlet" method="get">

    <input type="hidden" name="action" value="search">

    Check-in:
    <input type="date" id="checkIn" name="checkIn" required>

    Check-out:
    <input type="date" id="checkOut" name="checkOut" required>

    Guests:
    <input type="number" name="guests" min="1" required>

    <button type="submit">Search</button>

</form>

</body>

<script>
let today = new Date().toISOString().split('T')[0];
document.getElementById("checkIn").setAttribute("min", today);

document.getElementById("checkIn").addEventListener("change", function () {
    let d = new Date(this.value);
    d.setDate(d.getDate() + 1);
    document.getElementById("checkOut")
        .setAttribute("min", d.toISOString().split('T')[0]);
});
</script>
</html>

