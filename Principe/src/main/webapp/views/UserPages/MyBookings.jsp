<%@ page import="java.util.*" %>
<%@ page import="dao.BookingDAO" %>
<%@ page import="model.BookingDetail" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if(user == null){
        response.sendRedirect(request.getContextPath()+"/views/login.jsp");
        return;
    }

    BookingDAO dao = new BookingDAO();
    List<BookingDetail> bookings =
            dao.getBookingsByUserId(user.getUserId());
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Bookings</title>
    <style>
        body{
            font-family: Poppins;
            background:#f4f4f4;
        }

        .container{
            width:90%;
            margin:40px auto;
        }

        table{
            width:100%;
            border-collapse:collapse;
            background:white;
            box-shadow:0 5px 15px rgba(0,0,0,0.1);
        }

        th, td{
            padding:12px;
            text-align:center;
            border-bottom:1px solid #ddd;
        }

        th{
            background:#d4af37;
            color:white;
        }

        tr:hover{
            background:#f9f9f9;
        }

        .no-booking{
            text-align:center;
            padding:40px;
            font-size:18px;
        }
    </style>
</head>
<body>

<jsp:include page="/views/designs/header.jsp" />

<div class="container">
    <h2>My Bookings</h2>

    <%
        if(bookings.isEmpty()){
    %>
        <div class="no-booking">
            You have not made any bookings yet.
        </div>
    <%
        } else {
    %>

    <table>
        <tr>
            <th>ID</th>
            <th>Room</th>
            <th>Check-In</th>
            <th>Check-Out</th>
            <th>Guests</th>
            <th>Total</th>
            <th>Status</th>
        </tr>

        <%
            for(BookingDetail b : bookings){
        %>
        <tr>
            <td><%= b.getBookingId() %></td>
            <td><%= b.getRoomId() %></td>
            <td><%= b.getCheckinDate() %></td>
            <td><%= b.getCheckoutDate() %></td>
            <td><%= b.getNoOfGuests() %></td>
            <td>Rs. <%= b.getTotalAmount() %></td>
            <td><%= b.getStatus() %></td>
        </tr>
        <%
            }
        %>

    </table>
    
    <a href="${pageContext.request.contextPath}/views/userDashboard.jsp"
   style="
   padding:10px 20px;
   background:#444;
   color:white;
   text-decoration:none;
   border-radius:5px;
   ">
   Go Back
</a>

    <%
        }
    %>

</div>


</body>
</html>