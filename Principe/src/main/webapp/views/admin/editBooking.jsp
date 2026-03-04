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
    <title>Edit Booking | Principe Grand</title>
    <meta charset="UTF-8">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(rgba(0,0,0,0.85), rgba(0,0,0,0.85)),
                        url('https://images.unsplash.com/photo-1560347876-aeef00ee58a1');
            background-size: cover;
            background-position: center;
            color: white;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 50px;
        }

        .form-card {
            background: rgba(255,255,255,0.07);
            backdrop-filter: blur(8px);
            padding: 40px;
            border-radius: 20px;
            width: 450px;
            transition: 0.3s;
        }

        .form-card:hover {
            background: rgba(212,175,55,0.12);
            transform: translateY(-5px);
        }

        h2 {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            color: #d4af37;
            margin-bottom: 30px;
            text-align: center;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            color: #d4af37;
        }

        input[type="date"],
        input[type="number"],
        input[type="text"],
        select {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 20px;
            border-radius: 15px;
            border: none;
            outline: none;
            font-size: 14px;
        }

        input[readonly] {
            background: rgba(212,175,55,0.15);
            color: white;
            font-weight: 600;
        }

        input[type="submit"] {
            background: #28a745;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
            width: 100%;
        }

        input[type="submit"]:hover {
            background: #218838;
        }

    </style>
</head>

<body>

<div class="container">

    <div class="form-card">

        <h2>Edit Booking</h2>

        <form action="AdminBookingServlet" method="post">

            <input type="hidden" name="bookingId" value="<%= b.getBookingId() %>">
            <input type="hidden" id="roomPrice" value="<%= roomPrice %>">

            <label for="checkin">Check-In</label>
            <input type="date" id="checkin" name="checkin"
                   value="<%= checkInValue %>" min="<%= todayStr %>" required>

            <label for="checkout">Check-Out</label>
            <input type="date" id="checkout" name="checkout"
                   value="<%= checkOutValue %>" required>

            <label for="totalAmount">Total Amount</label>
            <input type="text" id="totalAmount" name="totalAmount" readonly>

            <label for="guests">Guests</label>
            <input type="number" name="guests" value="<%= b.getNoOfGuests() %>" min="1" required>

            <label for="status">Status</label>
            <select name="status" required>
                <option value="PENDING" <%= "PENDING".equals(b.getStatus()) ? "selected" : "" %>>PENDING</option>
                <option value="CONFIRMED" <%= "CONFIRMED".equals(b.getStatus()) ? "selected" : "" %>>CONFIRMED</option>
                <option value="CANCELLED" <%= "CANCELLED".equals(b.getStatus()) ? "selected" : "" %>>CANCELLED</option>
            </select>

            <input type="submit" value="Update Booking">

        </form>

    </div>

</div>

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
            document.getElementById("totalAmount").value = (days * price).toFixed(2);
        } else {
            document.getElementById("totalAmount").value = "";
        }
    }
}

document.getElementById("checkin").addEventListener("change", function(){
    let inDate = new Date(this.value);
    inDate.setDate(inDate.getDate() + 1);
    let minOut = inDate.toISOString().split('T')[0];
    document.getElementById("checkout").setAttribute("min", minOut);
    calculateTotal();
});

document.getElementById("checkout").addEventListener("change", calculateTotal);

// Initial calculation
calculateTotal();
</script>

</body>
</html>