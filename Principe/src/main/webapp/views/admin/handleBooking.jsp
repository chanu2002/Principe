<%@ page import="java.util.*, model.BookingDetail" %>

<h2>Manage Bookings</h2>

<table border="1" cellpadding="8">
<tr>
    <th>ID</th>
    <th>User</th>
    <th>Room</th>
    <th>Check-In</th>
    <th>Check-Out</th>
    <th>Guests</th>
    <th>Status</th>
    <th>Actions</th>
</tr>

<%
List<BookingDetail> list =
    (List<BookingDetail>) request.getAttribute("bookingList");

for(BookingDetail b : list){
%>

<tr>
    <td><%= b.getBookingId() %></td>
    <td><%= b.getUserId() %></td>
    <td><%= b.getRoomId() %></td>
    <td><%= b.getCheckinDate() %></td>
    <td><%= b.getCheckoutDate() %></td>
    <td><%= b.getNoOfGuests() %></td>
    <td><%= b.getStatus() %></td>
    <td>
        <a href="AdminBookingServlet?action=edit&id=<%= b.getBookingId() %>">Edit</a>
        |
        <a href="AdminBookingServlet?action=delete&id=<%= b.getBookingId() %>"
           onclick="return confirm('Delete this booking?')">
           Delete
        </a>
    </td>
</tr>

<% } %>
</table>