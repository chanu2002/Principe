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
</head>
<body>

<h2>Our Rooms</h2>

<%
for(String type : roomTypes){
%>

    <hr>
    <h2><%= type %></h2>

<%
    if(list != null){
        for(Room r : list){

            if(type.equals(r.getType())){

                List<RoomImage> images =
                        imgDAO.getImagesByRoom(r.getRoomId());
%>

                <!-- IMAGES -->
                <%
                if(images != null){
                    for(RoomImage img : images){
                %>

                    <img src="<%= request.getContextPath() %>/DisplayImageServlet?id=<%= img.getRoomImageId() %>"
                         width="150" height="100">

                <%
                    }
                }
                %>

                <h3><%= r.getType() %></h3>

                <p><%= r.getDescription() %></p>
                
                <p>Max Guests: <%= r.getMaxGuest() %></p>

                <!-- Not Available Message -->
                <%
                if("NOT_AVAILABLE".equals(r.getAvailability())){
                %>
                    <p style="color:red;"><b>Not Available</b></p>
                <%
                }
                %>

                <!-- Button -->
                <%
                if("AVAILABLE".equals(r.getAvailability())){
                %>

                    <a href="<%= request.getContextPath() %>/views/booking.jsp?roomId=<%= r.getRoomId() %>">
                        <button>Reserve</button>
                    </a>

                <%
                } else {
                %>

                    <a href="<%= request.getContextPath() %>/views/booking.jsp?roomId=<%= r.getRoomId() %>">
                        <button>View</button>
                    </a>

                <%
                }
                %>

                <br><br>

<%
            }
        }
    }
}
%>

</body>
</html>