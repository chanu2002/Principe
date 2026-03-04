<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        return;
    }

    String bookingId = request.getParameter("bookingId");
    String amount = request.getParameter("amount");

    if (bookingId == null || amount == null) {
        response.sendRedirect(request.getContextPath() + "/views/error.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Secure Payment</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
    background:
        linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)),
        url('https://images.unsplash.com/photo-1556742031-c6961e8560b0');
    background-size:cover;
    background-position:center;
    background-attachment:fixed;
    color:white;
}

.payment-card{
    background: rgba(255,255,255,0.08);
    backdrop-filter: blur(15px);
    border-radius:25px;
    padding:40px;
    max-width:550px;
    margin:auto;
    margin-top:80px;
    box-shadow:0 15px 50px rgba(0,0,0,0.6);
}

.payment-header{
    text-align:center;
    margin-bottom:30px;
}

.payment-header h2{
    font-weight:700;
    letter-spacing:1px;
}

.summary-box{
    background:rgba(0,198,255,0.15);
    padding:15px;
    border-radius:15px;
    margin-bottom:25px;
}

.form-control{
    border-radius:12px;
    padding:10px;
}

.btn-confirm{
    background:linear-gradient(45deg,#00c6ff,#0072ff);
    border:none;
    border-radius:12px;
    padding:10px 20px;
    font-weight:600;
}

.btn-cancel{
    border-radius:12px;
}

</style>
</head>

<body>

<div class="payment-card">

    <div class="payment-header">
        <h2>Secure Card Payment</h2>
        <p style="opacity:0.8;">Complete your booking safely</p>
    </div>

    <!-- PAYMENT SUMMARY -->
    <div class="summary-box">
        <strong>Booking ID:</strong> <%= bookingId %><br>
        <strong>Total Amount:</strong> 
        <span style="font-size:20px; font-weight:700;">
            $<%= amount %>
        </span>
    </div>

    <form action="<%= request.getContextPath() %>/TransactionServlet"
          method="post">

        <input type="hidden" name="bookingId" value="<%= bookingId %>">
        <input type="hidden" name="amount" value="<%= amount %>">

        <!-- CARD NUMBER -->
        <div class="mb-3">
            <label class="form-label">Card Number</label>
            <input type="text"
                   name="cardNumber"
                   class="form-control"
                   placeholder="1234 5678 9012 3456"
                   maxlength="16"
                   required>
        </div>

        <!-- CARD HOLDER -->
        <div class="mb-3">
            <label class="form-label">Card Holder Name</label>
            <input type="text"
                   name="cardName"
                   class="form-control"
                   required>
        </div>

        <div class="row">

            <!-- EXPIRY -->
            <div class="col-md-6 mb-3">
                <label class="form-label">Expiry Date</label>
                <input type="month"
                       name="expiry"
                       class="form-control"
                       required>
            </div>

            <!-- CVV -->
            <div class="col-md-6 mb-3">
                <label class="form-label">CVV</label>
                <input type="password"
                       name="cvv"
                       class="form-control"
                       maxlength="4"
                       required>
            </div>

        </div>

        <!-- BUTTONS -->
        <div class="d-flex justify-content-between mt-3">

            <a href="<%= request.getContextPath() %>/RoomServlet?action=list"
               class="btn btn-secondary btn-cancel">
                Cancel
            </a>

            <button type="submit"
                    class="btn btn-confirm text-white">
                Confirm Payment
            </button>

        </div>

    </form>

</div>

</body>
</html>