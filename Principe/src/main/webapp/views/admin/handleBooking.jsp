<%@ page import="java.util.*, model.BookingDetail" %>
<%
    List<BookingDetail> list =
        (List<BookingDetail>) request.getAttribute("bookingList");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Bookings | Principe Grand</title>
    <meta charset="UTF-8">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>

        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(rgba(0,0,0,0.85), rgba(0,0,0,0.85)),
                        url('https://images.unsplash.com/photo-1566073771259-6a8506099945');
            background-size: cover;
            background-position: center;
            color: #fff;
        }

        .container {
            padding: 50px;
        }

        h2 {
            font-family: 'Playfair Display', serif;
            font-size: 38px;
            letter-spacing: 1px;
            margin-bottom: 30px;
            color: #d4af37;
        }

        .back-btn {
            background: transparent;
            border: 1px solid #d4af37;
            color: #d4af37;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 25px;
            transition: 0.3s;
            margin-bottom: 25px;
        }

        .back-btn:hover {
            background: #d4af37;
            color: #000;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255,255,255,0.05);
            backdrop-filter: blur(8px);
            border-radius: 15px;
            overflow: hidden;
        }

        th {
            background: #d4af37;
            color: #000;
            padding: 15px;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 14px;
        }

        td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        tr:hover {
            background: rgba(212,175,55,0.15);
            transition: 0.3s;
        }

        .status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
        }

        .confirmed {
            background: #28a745;
        }

        .pending {
            background: #ffc107;
            color: #000;
        }

        .cancelled {
            background: #dc3545;
        }

        .action-btn {
            text-decoration: none;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            margin: 0 4px;
            transition: 0.3s;
        }

        .edit-btn {
            background: #17a2b8;
            color: #fff;
        }

        .delete-btn {
            background: #dc3545;
            color: #fff;
        }

        .edit-btn:hover {
            background: #138496;
        }

        .delete-btn:hover {
            background: #b02a37;
        }

    </style>
</head>
<body>

<div class="container">

    <h2>Manage Bookings</h2>

    <button class="back-btn"
        onclick="window.location.href='<%= request.getContextPath() %>/views/adminDashboard.jsp'">
        Back to Dashboard
    </button>

    <table>
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

        <% if(list != null){ 
           for(BookingDetail b : list){ 
        %>

        <tr>
            <td><%= b.getBookingId() %></td>
            <td><%= b.getUserId() %></td>
            <td><%= b.getRoomId() %></td>
            <td><%= b.getCheckinDate() %></td>
            <td><%= b.getCheckoutDate() %></td>
            <td><%= b.getNoOfGuests() %></td>
            <td>
                <%
                    String status = b.getStatus();
                    String statusClass = "pending";
                    if("CONFIRMED".equalsIgnoreCase(status)) statusClass = "confirmed";
                    else if("CANCELLED".equalsIgnoreCase(status)) statusClass = "cancelled";
                %>
                <span class="status <%= statusClass %>">
                    <%= status %>
                </span>
            </td>
            <td>
                <a class="action-btn edit-btn"
                   href="AdminBookingServlet?action=edit&id=<%= b.getBookingId() %>">
                   Edit
                </a>

                <a class="action-btn delete-btn"
                   href="AdminBookingServlet?action=delete&id=<%= b.getBookingId() %>"
                   onclick="return confirm('Delete this booking?')">
                   Delete
                </a>
            </td>
        </tr>

        <% }} %>

    </table>

</div>

</body>
</html>