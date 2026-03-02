<%@ page import="model.Room" %>
<%@ page import="model.RoomImage" %>
<%@ page import="model.Facility" %>
<%@ page import="dao.RoomDAO" %>
<%@ page import="dao.RoomImageDAO" %>
<%@ page import="dao.RoomFacilityDAO" %>
<%@ page import="dao.FacilityDAO" %>
<%@ page import="java.util.*" %>

<%
    String roomId = request.getParameter("roomId");

    if (roomId == null || roomId.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/RoomServlet?action=list");
        return;
    }

    RoomDAO roomDAO = new RoomDAO();
    Room room = roomDAO.getRoomById(roomId);

    if (room == null) {
        response.sendRedirect(request.getContextPath() + "/RoomServlet?action=list");
        return;
    }

    RoomImageDAO imgDAO = new RoomImageDAO();
    RoomFacilityDAO rfdao = new RoomFacilityDAO();
    FacilityDAO fdao = new FacilityDAO();

    List<RoomImage> images = imgDAO.getImagesByRoom(roomId);
    List<Integer> roomFacilityIds = rfdao.getFacilityIdsByRoom(roomId);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Room Booking</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body class="container mt-4">

<h2>Room Details</h2>

<!-- Images -->
<%
if(images != null){
    for(RoomImage img : images){
%>
        <img src="<%= request.getContextPath() %>/DisplayImageServlet?id=<%= img.getRoomImageId() %>"
             width="200" height="150" class="me-2 mb-2">
<%
    }
}
%>

<hr>

<p><b>Type:</b> <%= room.getType() %></p>
<p><b>Price per Day:</b> $<%= room.getPrice() %></p>
<p><b>Description:</b> <%= room.getDescription() %></p>
<p><b>Size:</b> <%= room.getSize() %></p>

<hr>

<h3>Facilities</h3>

<%
if(roomFacilityIds != null && !roomFacilityIds.isEmpty()){
%>
    <ul>
<%
    for(Integer fid : roomFacilityIds){
        for(Facility f : fdao.getAll()){
            if(f.getFacilityId() == fid){
%>
                <li><%= f.getFacilityName() %></li>
<%
            }
        }
    }
%>
    </ul>
<%
} else {
%>
    <p>No facilities available.</p>
<%
}
%>

<hr>

<%
if("NOT_AVAILABLE".equals(room.getAvailability())){
%>
    <p class="text-danger"><b>Not Available</b></p>
<%
} else {
%>

<!-- BOOKING FORM -->
<a href="<%= request.getContextPath() %>/BookingServlet?roomId=<%= room.getRoomId() %>"
   class="btn btn-primary">
   Book Now
</a>

<%
}
%>





<br><br>

<a href="<%= request.getContextPath() %>/RoomServlet?action=list">
    Back
</a>

</body>
</html>