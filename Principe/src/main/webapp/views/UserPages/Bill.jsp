<%@ page import="model.BookingDetail" %>
<%@ page import="model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        return;
    }

    User user = (User) session.getAttribute("user");
    BookingDetail booking = (BookingDetail) session.getAttribute("bookingDetail");
    String transactionId = (String) session.getAttribute("transactionId");
    java.math.BigDecimal amountPaid = (java.math.BigDecimal) session.getAttribute("amountPaid");

    if (booking == null || transactionId == null || amountPaid == null) {
        response.sendRedirect(request.getContextPath() + "/views/error.jsp");
        return;
    }

    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Luxury Bill | Ocean View Resort</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&family=Playfair+Display:wght@500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body{
    background: #f3f4f6;
    font-family:'Poppins',sans-serif;
}

.back-home{
    display:inline-block;
    margin:20px 0;
    padding:10px 25px;
    background:#0b3d5c;
    color:white;
    border-radius:10px;
    text-decoration:none;
    font-weight:500;
    transition:0.3s;
}
.back-home:hover{
    background:#d4af37;
    color:#000;
}

.bill-container{
    max-width:800px;
    margin:20px auto 50px;
    background:linear-gradient(to right, #ffffff, #f0f8ff);
    padding:40px;
    border-radius:25px;
    box-shadow:0 25px 60px rgba(0,0,0,0.2);
}

.header{
    text-align:center;
    margin-bottom:40px;
}
.header h1{
    font-family:'Playfair Display';
    font-size:36px;
    color:#0b3d5c;
    margin-bottom:5px;
}
.header p{
    font-size:16px;
    color:#555;
}

.bill-section{
    margin-bottom:30px;
}

.bill-section h2{
    font-family:'Playfair Display';
    font-size:22px;
    color:#1e3a5f;
    margin-bottom:15px;
    border-bottom:2px solid #d4af37;
    display:inline-block;
    padding-bottom:5px;
}

.bill-table{
    width:100%;
    border-collapse:collapse;
    margin-top:15px;
}
.bill-table th, .bill-table td{
    text-align:left;
    padding:12px;
    border-bottom:1px solid #ddd;
}
.bill-table th{
    color:#d4af37;
}
.total{
    text-align:right;
    font-size:20px;
    font-weight:600;
    color:#0b3d5c;
    margin-top:15px;
}

.footer{
    text-align:center;
    margin-top:40px;
    font-size:14px;
    color:#555;
}

.print-btn{
    display:inline-block;
    padding:12px 25px;
    background:#0b3d5c;
    color:white;
    border-radius:10px;
    text-decoration:none;
    font-weight:500;
    margin-top:20px;
    transition:0.3s;
}
.print-btn:hover{
    background:#d4af37;
    color:#000;
}
</style>

<!-- jsPDF for PDF download -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script>
function downloadPDF() {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();
    let content = document.getElementById("billContent").innerHTML;

    // Simple text conversion for PDF
    doc.html(content, {
        callback: function (doc) {
            doc.save('OceanView_Bill_<%= transactionId %>.pdf');
        },
        x: 10,
        y: 10,
        html2canvas: { scale: 0.5 }
    });
}
</script>

</head>
<body>

<a href="<%= request.getContextPath() %>/views/UserPages/MyBookings.jsp" class="back-home">
    <i class="fa fa-home"></i> Back to My Bookings
</a>

<div class="bill-container" id="billContent">
    <div class="header">
        <h1>Ocean View Resort - Bill</h1>
        <p>Thank you for booking with us, <%= user.getName() %></p>
    </div>

    <div class="bill-section">
        <h2>Booking Details</h2>
        <table class="bill-table">
            <tr>
                <th>Transaction ID:</th>
                <td><%= transactionId %></td>
            </tr>
            <tr>
                <th>Room ID:</th>
                <td><%= booking.getRoomId() %></td>
            </tr>
            <tr>
                <th>Check-In:</th>
                <td><%= sdf.format(booking.getCheckinDate()) %></td>
            </tr>
            <tr>
                <th>Check-Out:</th>
                <td><%= sdf.format(booking.getCheckoutDate()) %></td>
            </tr>
            <tr>
                <th>Guests:</th>
                <td><%= booking.getNoOfGuests() %></td>
            </tr>
        </table>
    </div>

    <div class="bill-section">
        <h2>Payment Details</h2>
        <table class="bill-table">
            <tr>
                <th>Total Amount:</th>
                <td>Rs. <%= amountPaid %></td>
            </tr>
            <tr>
                <th>Status:</th>
                <td>CONFIRMED</td>
            </tr>
        </table>
    </div>

    <div class="total">
        Total Paid: Rs. <%= amountPaid %>
    </div>

    <div style="text-align:center;">
        <a href="javascript:void(0)" class="print-btn" onclick="downloadPDF()">
            <i class="fa fa-download"></i> Download Bill as PDF
        </a>
    </div>

    <div class="footer">
        Ocean View Resort | Lighthouse Street, Galle | +94 91 234 5678 | info@oceanviewresort.lk
    </div>
</div>

</body>
</html>