<%@ page import="java.util.*" %>
<%@ page import="model.Room" %>
<%@ page import="model.RoomImage" %>
<%@ page import="dao.RoomImageDAO" %>

<%
List<Room> list = (List<Room>) request.getAttribute("roomList");
RoomImageDAO imgDAO = new RoomImageDAO();

String[] roomTypes = {
    "EXECUTIVE ROOM",
    "DELUXE ROOM",
    "SUPERIOR ROOM",
    "PRESIDENTIAL SUITE"
};
%>

<!DOCTYPE html>
<html>
<head>
    <title>All Rooms</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:'Poppins', sans-serif;
        }

        body{
            background:
                linear-gradient(rgba(0,0,0,0.65), rgba(0,0,0,0.65)),
                url('https://images.unsplash.com/photo-1505693416388-ac5ce068fe85');
            background-size:cover;
            background-attachment:fixed;
            color:white;
        }

        /* Content wrapper for spacing */
        .content{
            padding:50px 60px;
        }

        h1{
            text-align:center;
            margin-bottom:50px;
            font-size:40px;
            font-weight:700;
            letter-spacing:1px;
        }

        h2{
            margin-top:60px;
            margin-bottom:25px;
            font-size:26px;
            border-left:6px solid #00c6ff;
            padding-left:15px;
        }

        .room-card{
            background:rgba(255,255,255,0.12);
            backdrop-filter:blur(18px);
            border-radius:18px;
            padding:25px;
            margin-bottom:35px;
            box-shadow:0 15px 40px rgba(0,0,0,0.6);
            transition:0.4s;
        }

        .room-card:hover{
            transform:translateY(-6px);
            box-shadow:0 20px 50px rgba(0,0,0,0.7);
        }

        .slider{
            position:relative;
            width:100%;
            height:280px;
            overflow:hidden;
            border-radius:15px;
            margin-bottom:20px;
        }

        .slider img{
            width:100%;
            height:280px;
            object-fit:cover;
            position:absolute;
            opacity:0;
            transition:opacity 1s ease-in-out;
        }

        .slider img.active{
            opacity:1;
        }

        h3{
            margin-bottom:10px;
            font-size:22px;
        }

        p{
            margin:8px 0;
            line-height:1.6;
        }

        .status{
            font-weight:600;
            margin-top:10px;
        }

        .available{
            color:#00ffae;
        }

        .not-available{
            color:#ff4d4d;
        }

        button{
            margin-top:15px;
            padding:12px 25px;
            border:none;
            border-radius:10px;
            background:linear-gradient(to right,#00c6ff,#0072ff);
            color:white;
            cursor:pointer;
            font-weight:600;
            transition:0.3s;
        }

        button:hover{
            transform:scale(1.05);
        }

        .no-room{
            background:rgba(255,255,255,0.1);
            padding:25px;
            border-radius:12px;
            text-align:center;
            font-size:18px;
            opacity:0.9;
            margin-bottom:30px;
        }

    </style>
</head>
<body>

<!-- Header now fully at top -->
<jsp:include page="/views/designs/header.jsp" />

<div class="content">

<h1>Our Luxury Rooms</h1>

<%
for(String type : roomTypes){
    boolean hasRoom = false;
%>

    <h2><%= type %></h2>

<%
    if(list != null){
        for(Room r : list){

            if(type.equals(r.getType())){
                hasRoom = true;

                List<RoomImage> images =
                        imgDAO.getImagesByRoom(r.getRoomId());
%>

<div class="room-card">

    <div class="slider">
        <%
        if(images != null){
            int count = 0;
            for(RoomImage img : images){
        %>
            <img class="slide-<%= r.getRoomId() %> <%= (count==0?"active":"") %>"
                 src="<%= request.getContextPath() %>/DisplayImageServlet?id=<%= img.getRoomImageId() %>">
        <%
                count++;
            }
        }
        %>
    </div>

    <h3><%= r.getType() %></h3>

    <p><%= r.getDescription() %></p>
    <p><strong>Max Guests:</strong> <%= r.getMaxGuest() %></p>

    <%
    if("NOT_AVAILABLE".equals(r.getAvailability())){
    %>
        <p class="status not-available">Currently Not Available</p>
    <%
    } else {
    %>
        <p class="status available">Available for Booking</p>
    <%
    }
    %>

    <%
    if("AVAILABLE".equals(r.getAvailability())){
    %>
        <a href="<%= request.getContextPath() %>/views/booking.jsp?roomId=<%= r.getRoomId() %>">
            <button>Reserve Now</button>
        </a>
    <%
    } else {
    %>
        <a href="<%= request.getContextPath() %>/views/booking.jsp?roomId=<%= r.getRoomId() %>">
            <button>View Details</button>
        </a>
    <%
    }
    %>

</div>

<script>
(function(){
    let slides = document.querySelectorAll(".slide-<%= r.getRoomId() %>");
    let index = 0;

    if(slides.length > 1){
        setInterval(function(){
            slides[index].classList.remove("active");
            index = (index + 1) % slides.length;
            slides[index].classList.add("active");
        }, 3500);
    }
})();
</script>

<%
            }
        }
    }

    if(!hasRoom){
%>
    <div class="no-room">
        No available rooms in this category at the moment.
    </div>
<%
    }
}
%>

</div>

</body>
</html>