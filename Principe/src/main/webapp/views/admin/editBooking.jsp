<%@ page import="model.BookingDetail" %>
<%
BookingDetail b =
    (BookingDetail) request.getAttribute("booking");

if (b == null) {
    response.sendRedirect("AdminBookingServlet?action=list");
    return;
}

java.text.SimpleDateFormat sdf =
        new java.text.SimpleDateFormat("yyyy-MM-dd");

String checkInValue =
        b.getCheckinDate() != null ? sdf.format(b.getCheckinDate()) : "";

String checkOutValue =
        b.getCheckoutDate() != null ? sdf.format(b.getCheckoutDate()) : "";

java.time.LocalDate today = java.time.LocalDate.now();
String todayStr = today.toString();

java.math.BigDecimal roomPrice =
        (java.math.BigDecimal) request.getAttribute("roomPrice");
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Booking</title>
</head>
<body>

<h2>Edit Booking</h2>

<form action="AdminBookingServlet" method="post">

<input type="hidden" name="bookingId"
       value="<%= b.getBookingId() %>">

<input type="hidden" id="roomPrice"
       value="<%= roomPrice %>">

Check-In:
<input type="date"
       id="checkin"
       name="checkin"
       value="<%= checkInValue %>"
       min="<%= todayStr %>"
       required>
<br><br>

Check-Out:
<input type="date"
       id="checkout"
       name="checkout"
       value="<%= checkOutValue %>"
       required>
<br><br>

Total Amount:
<input type="text"
       id="totalAmount"
       name="totalAmount"
       readonly>
<br><br>

<script>

function calculateTotal() {

    let checkIn = document.getElementById("checkin").value;
    let checkOut = document.getElementById("checkout").value;
    let price = document.getElementById("roomPrice").value;

    if(checkIn && checkOut){

        let inDate = new Date(checkIn);
        let outDate = new Date(checkOut);

        let diff = outDate - inDate;
        let days = diff / (1000*60*60*24);

        if(days > 0){
            document.getElementById("totalAmount").value =
                (days * price).toFixed(2);
        } else {
            document.getElementById("totalAmount").value = "";
        }
    }
}

document.getElementById("checkin")
    .addEventListener("change", function(){

        let inDate = new Date(this.value);
        inDate.setDate(inDate.getDate() + 1);

        let minOut = inDate.toISOString().split('T')[0];

        document.getElementById("checkout")
            .setAttribute("min", minOut);

        calculateTotal();
    });

document.getElementById("checkout")
    .addEventListener("change", calculateTotal);

</script>

<br>

Guests:
<input type="number"
       name="guests"
       value="<%= b.getNoOfGuests() %>"
       min="1"
       required>
<br><br>

Status:
<select name="status" required>

<option value="PENDING"
<%= "PENDING".equals(b.getStatus()) ? "selected" : "" %>>
PENDING
</option>

<option value="CONFIRMED"
<%= "CONFIRMED".equals(b.getStatus()) ? "selected" : "" %>>
CONFIRMED
</option>

<option value="CANCELLED"
<%= "CANCELLED".equals(b.getStatus()) ? "selected" : "" %>>
CANCELLED
</option>

</select>

<br><br>

<input type="submit" value="Update Booking">

</form>

</body>
</html>