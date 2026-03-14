<%@ page import="dao.BookingDAO, model.DailyIncome, model.DailyBooking, java.util.List" %>
<%@ page import="java.util.Calendar, java.util.Date, java.text.SimpleDateFormat, java.util.Collections" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    BookingDAO bookingDAO = new BookingDAO();
    List<DailyIncome> stats = bookingDAO.getDailyIncome();
    List<DailyBooking> bookings = bookingDAO.getDailyBookingCount();

    // Sort bookings by date ascending (earlier first)
    Collections.sort(bookings, (b1, b2) -> b1.getBookingDate().compareTo(b2.getBookingDate()));

    // Calculate predicted next day (simple average)
    int total = 0;
    for(DailyBooking b : bookings) total += b.getBookingCount();
    int predictedNext = bookings.size() > 0 ? total / bookings.size() : 0;

    // Determine next day date
    Calendar cal = Calendar.getInstance();
    if(bookings.size() > 0) {
        cal.setTime(bookings.get(bookings.size()-1).getBookingDate());
        cal.add(Calendar.DATE, 1);
    }
    Date nextDay = cal.getTime();

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Daily Income Stats & Bookings</title>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: url("https://images.unsplash.com/photo-1566073771259-6a8506099945") no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 40px;
        }

        /* Background overlay blur */
        body::before {
            content: "";
            position: fixed;
            top:0; left:0; right:0; bottom:0;
            backdrop-filter: blur(8px) brightness(0.6);
            z-index: -1;
        }

        h2 {
            color: #ffd700;
            text-align: center;
            margin-bottom: 30px;
            text-shadow: 1px 1px 5px rgba(0,0,0,0.6);
        }

        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 20px;
            background: #ffd700;
            color: #222;
            font-weight: 600;
            border-radius: 25px;
            text-decoration: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            transition: 0.3s;
        }

        .back-btn:hover {
            background: #e6c200;
            transform: translateY(-2px);
        }

        /* Glass effect containers */
        .glass-container {
            max-width: 900px;
            margin: 50px auto;
            background: rgba(255,255,255,0.1);
            border-radius: 20px;
            padding: 25px;
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 8px 32px rgba(0,0,0,0.2);
            color: #fff;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            color: #fff;
        }

        th, td {
            padding: 15px;
            text-align: left;
        }

        th {
            background: rgba(255, 215, 0, 0.8);
            color: #222;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background: rgba(255,255,255,0.1);
        }

        tr:hover {
            background: rgba(255,255,255,0.2);
            transition: 0.3s;
        }

        /* Legend styling */
        .legend {
            max-width: 900px;
            margin: 10px auto 20px auto;
            display: flex;
            align-items: center;
            font-weight: 600;
        }
        .legend-item {
            display: flex;
            align-items: center;
            margin-right: 20px;
        }
        .legend-square {
            width: 20px;
            height: 20px;
            margin-right: 8px;
            border-radius: 4px;
        }
        .legend-actual { background-color: rgba(255, 215, 0, 0.8); }
        .legend-prediction { background-color: rgba(0, 123, 255, 0.8); }
    </style>
</head>
<body>

<a href="<%=request.getContextPath()%>/views/adminDashboard.jsp" class="back-btn">Back to Dashboard</a>

<h2>Daily Income Stats</h2>

<div class="glass-container">
    <table>
        <tr>
            <th>Date</th>
            <th>Income ($)</th>
        </tr>
        <% for(DailyIncome d : stats) { %>
        <tr>
            <td><%= d.getBookingDate() %></td>
            <td><%= d.getIncome() %></td>
        </tr>
        <% } %>
    </table>
</div>

<div class="glass-container">
    <h2>Daily Bookings (with Prediction)</h2>

    <!-- Legend -->
    <div class="legend">
        <div class="legend-item">
            <div class="legend-square legend-actual"></div> Actual Bookings
        </div>
        <div class="legend-item">
            <div class="legend-square legend-prediction"></div> Prediction Value
        </div>
    </div>

    <canvas id="bookingChart"></canvas>
</div>

<script>
const ctx = document.getElementById('bookingChart').getContext('2d');

const labels = [
    <% for(DailyBooking b : bookings) { %>
        '<%= sdf.format(b.getBookingDate()) %>',
    <% } %>
    '<%= sdf.format(nextDay) %>'
];

const data = [
    <% for(DailyBooking b : bookings) { %>
        <%= b.getBookingCount() %>,
    <% } %>
    <%= predictedNext %>
];

const backgroundColors = [
    <% for(DailyBooking b : bookings) { %>
        'rgba(255, 215, 0, 0.8)',
    <% } %>
    'rgba(0, 123, 255, 0.8)' // prediction in blue
];

const borderColors = [
    <% for(DailyBooking b : bookings) { %>
        'rgba(255, 215, 0, 1)',
    <% } %>
    'rgba(0, 123, 255, 1)' // prediction border
];

new Chart(ctx, {
    type: 'bar',
    data: {
        labels: labels,
        datasets: [{
            label: '', // remove default legend
            data: data,
            backgroundColor: backgroundColors,
            borderColor: borderColors,
            borderWidth: 1
        }]
    },
    options: {
        plugins: {
            legend: { display: false } // hide default legend
        },
        scales: {
            y: {
                beginAtZero: true,
                precision: 0,
                ticks: { color: '#fff' }
            },
            x: { ticks: { color: '#fff' } }
        }
    }
});
</script>

</body>
</html>
