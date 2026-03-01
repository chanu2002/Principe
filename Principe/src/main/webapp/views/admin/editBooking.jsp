<%@ page import="model.BookingDetail" %>
<%
BookingDetail b =
    (BookingDetail) request.getAttribute("booking");
%>

<h2>Edit Booking</h2>

<form action="AdminBookingServlet" method="post">

<input type="hidden" name="bookingId"
       value="<%= b.getBookingId() %>">

Check-In:
<input type="date" name="checkin"
 value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd")
 .format(b.getCheckinDate()) %>"><br>

Check-Out:
<input type="date" name="checkout"
 value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd")
 .format(b.getCheckoutDate()) %>"><br>

Guests:
<input type="number" name="guests"
       value="<%= b.getNoOfGuests() %>"><br>

Status:
<select name="status">
    <option value="PENDING">PENDING</option>
    <option value="CONFIRMED">CONFIRMED</option>
    <option value="CANCELLED">CANCELLED</option>
</select><br><br>

<input type="submit" value="Update Booking">

</form>