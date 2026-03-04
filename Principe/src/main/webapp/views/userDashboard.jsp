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

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:'Poppins', sans-serif;
        }

        body{
            min-height:100vh;
            background:
                linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)),
                url('https://images.unsplash.com/photo-1551882547-ff40c63fe5fa');
            background-size:cover;
            background-position:center;
            background-attachment:fixed;
        }

        /* Main section */
        .main-content{
            display:flex;
            justify-content:center;
            align-items:center;
            padding:80px 20px; /* space below header automatically */
        }

        /* Glass card */
        .glass-card{
            width:100%;
            max-width:520px;
            padding:40px;
            border-radius:20px;
            background:rgba(255,255,255,0.15);
            backdrop-filter:blur(18px);
            box-shadow:0 15px 40px rgba(0,0,0,0.6);
            color:white;
            animation:fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn{
            from{opacity:0; transform:translateY(20px);}
            to{opacity:1; transform:translateY(0);}
        }

        .glass-card h2{
            text-align:center;
            margin-bottom:10px;
            font-size:28px;
            font-weight:700;
        }

        .subtitle{
            text-align:center;
            margin-bottom:30px;
            font-size:14px;
            opacity:0.9;
        }

        form{
            display:flex;
            flex-direction:column;
            gap:20px;
        }

        .input-group{
            display:flex;
            flex-direction:column;
        }

        label{
            font-size:13px;
            margin-bottom:6px;
        }

        input{
            padding:12px;
            border-radius:10px;
            border:none;
            font-size:14px;
            background:rgba(255,255,255,0.25);
            color:white;
            transition:0.3s;
        }

        input:focus{
            outline:none;
            background:rgba(255,255,255,0.35);
            box-shadow:0 0 10px rgba(255,255,255,0.6);
        }

        button{
            margin-top:10px;
            padding:14px;
            border:none;
            border-radius:12px;
            background:linear-gradient(to right, #00c6ff, #0072ff);
            color:white;
            font-size:16px;
            font-weight:600;
            cursor:pointer;
            transition:0.4s;
        }

        button:hover{
            transform:translateY(-3px);
            box-shadow:0 10px 25px rgba(0,0,0,0.5);
        }

        .footer-note{
            text-align:center;
            margin-top:20px;
            font-size:12px;
            opacity:0.85;
        }

    </style>
</head>

<body>

<!-- Header stays naturally at top -->
<jsp:include page="/views/designs/header.jsp" />

<div class="main-content">

    <div class="glass-card">

        <h2>Find Your Perfect Stay</h2>
        <div class="subtitle">
            Luxury • Comfort • Premium Experience
        </div>

        <form action="<%= request.getContextPath() %>/RoomServlet" method="get">

            <input type="hidden" name="action" value="search">

            <div class="input-group">
                <label>Check-in Date</label>
                <input type="date" id="checkIn" name="checkIn" required>
            </div>

            <div class="input-group">
                <label>Check-out Date</label>
                <input type="date" id="checkOut" name="checkOut" required>
            </div>

            <div class="input-group">
                <label>Number of Guests</label>
                <input type="number" name="guests" min="1" required>
            </div>

            <button type="submit">Search Available Rooms</button>

        </form>

        <div class="footer-note">
            Secure & Easy Online Reservation
        </div>

    </div>

</div>

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

</body>
</html>