<%@ page import="model.Room" %>
<%@ page import="model.RoomImage" %>
<%@ page import="model.Facility" %>
<%@ page import="dao.RoomDAO" %>
<%@ page import="dao.RoomImageDAO" %>
<%@ page import="dao.RoomFacilityDAO" %>
<%@ page import="dao.FacilityDAO" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.ReviewDAO" %>
<%@ page import="model.Review" %>

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

<hr>
<h3>Customer Reviews</h3>

<%
ReviewDAO reviewDAO = new ReviewDAO();
List<Review> reviews = reviewDAO.getByRoom(roomId);
model.User loggedUser = (model.User) session.getAttribute("user");

boolean alreadyReviewed = false;

if (loggedUser != null) {
    alreadyReviewed = reviewDAO.hasUserReviewed(roomId, loggedUser.getUserId());
}

if(reviews != null && !reviews.isEmpty()){
    for(Review r : reviews){
%>

<div class="card mb-3">
    <div class="card-body">

        <h6 class="text-primary">
            👤 <%= r.getCustomerName() %>
        </h6>

        ⭐ Rating: <%= r.getRating() %>/5
        <p><%= r.getComments() %></p>

        <% if(loggedUser != null && loggedUser.getUserId() == r.getUserId()){ %>

        <!-- UPDATE -->
        <form action="<%= request.getContextPath() %>/ReviewServlet" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="reviewId" value="<%= r.getReviewId() %>">
            <input type="hidden" name="roomId" value="<%= roomId %>">

            <select name="rating" required>
                <option value="5">5</option>
                <option value="4">4</option>
                <option value="3">3</option>
                <option value="2">2</option>
                <option value="1">1</option>
            </select>

            <textarea name="comments" required><%= r.getComments() %></textarea>

            <button type="submit" class="btn btn-warning btn-sm">Update</button>
        </form>

        <!-- DELETE -->
        <form action="<%= request.getContextPath() %>/ReviewServlet" method="post">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="reviewId" value="<%= r.getReviewId() %>">
            <input type="hidden" name="roomId" value="<%= roomId %>">

            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
        </form>

        <% } %>

    </div>
</div>

<%
    }
}
%>

<hr>

<% if(loggedUser != null && !alreadyReviewed){ %>

<h4>Add Review</h4>

<form action="<%= request.getContextPath() %>/ReviewServlet" method="post">

    <input type="hidden" name="action" value="add">
    <input type="hidden" name="roomId" value="<%= roomId %>">

    <select name="rating" required>
        <option value="">Select</option>
        <option value="5">5</option>
        <option value="4">4</option>
        <option value="3">3</option>
        <option value="2">2</option>
        <option value="1">1</option>
    </select>

    <textarea name="comments" required></textarea>

    <button type="submit" class="btn btn-success">Submit</button>

</form>

<% } %><br><br>

<a href="<%= request.getContextPath() %>/RoomServlet?action=list">
    Back
</a>

</body>
</html>