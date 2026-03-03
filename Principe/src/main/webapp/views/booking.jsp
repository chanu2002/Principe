<%@ page import="model.Room" %>
<%@ page import="model.RoomImage" %>
<%@ page import="model.Facility" %>
<%@ page import="dao.RoomDAO" %>
<%@ page import="dao.RoomImageDAO" %>
<%@ page import="dao.RoomFacilityDAO" %>
<%@ page import="dao.FacilityDAO" %>
<%@ page import="dao.ReviewDAO" %>
<%@ page import="dao.OfferDAO" %>
<%@ page import="model.Review" %>
<%@ page import="model.Offer" %>
<%@ page import="model.User" %>
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

    ReviewDAO reviewDAO = new ReviewDAO();
    List<Review> reviews = reviewDAO.getByRoom(roomId);

    OfferDAO offerDAO = new OfferDAO();
    List<Offer> offers = offerDAO.getAll();

    User loggedUser = (User) session.getAttribute("user");

    boolean hasReviewed = false;
    if (loggedUser != null) {
        hasReviewed = reviewDAO.hasUserReviewed(roomId, loggedUser.getUserId());
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Room Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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

<h3>Available Offers</h3>

<form id="offerForm">
<%
if(offers != null){
    for(Offer o : offers){
%>
<div class="form-check">
    <input class="form-check-input"
           type="radio"
           name="offer"
           value="<%= o.getOfferId() %>"
           data-rate="<%= o.getOfferRate() %>"
           onclick="calculateTotal()">

    <label class="form-check-label">
        <b><%= o.getOfferName() %></b>
        (<%= o.getOfferRate() %>% OFF)
        <br>
        <small><%= o.getDescription() %></small>
    </label>
</div>
<%
    }
}
%>

<div class="form-check mt-2">
    <input class="form-check-input"
           type="radio"
           name="offer"
           value=""
           checked
           onclick="calculateTotal()">
    <label class="form-check-label">No Offer</label>
</div>

</form>

<hr>

<%
if("NOT_AVAILABLE".equals(room.getAvailability())){
%>
<p class="text-danger"><b>Not Available</b></p>
<%
} else {
%>

<form action="<%= request.getContextPath() %>/BookingServlet"
      method="post">

    <input type="hidden" name="roomId" value="<%= roomId %>">
    <input type="hidden" id="finalAmount" name="finalAmount">
    <input type="hidden" id="selectedOffer" name="offerId">

    <input type="hidden" name="checkIn" value="<%= session.getAttribute("checkIn") %>">
    <input type="hidden" name="checkOut" value="<%= session.getAttribute("checkOut") %>">
    <input type="hidden" name="guests" value="<%= session.getAttribute("guests") %>">

    <h4>
        Total Amount: $
        <span id="totalDisplay"><%= room.getPrice() %></span>
    </h4>

    <button type="submit" class="btn btn-primary">
        Confirm Booking
    </button>

</form>

<%
}
%>

<hr>

<!-- ================= REVIEWS ================= -->

<h3>Customer Reviews</h3>

<%
if(reviews != null && !reviews.isEmpty()){
    for(Review r : reviews){
%>

<div class="card mb-3">
    <div class="card-body">

        <!-- USER NAME ON TOP -->
        <h5 class="card-title"><%= r.getCustomerName() %></h5>
        <p>⭐ <%= r.getRating() %>/5</p>
        <p><%= r.getComments() %></p>

        <% if (loggedUser != null && loggedUser.getUserId() == r.getUserId()) { %>

        <!-- UPDATE FORM -->
        <form action="<%= request.getContextPath() %>/ReviewServlet"
              method="post" class="mb-2">

            <input type="hidden" name="action" value="update">
            <input type="hidden" name="roomId" value="<%= roomId %>">
            <input type="hidden" name="reviewId" value="<%= r.getReviewId() %>">

            <select name="rating" class="form-control mb-2" required>
                <option value="5" <%= r.getRating()==5?"selected":"" %>>5</option>
                <option value="4" <%= r.getRating()==4?"selected":"" %>>4</option>
                <option value="3" <%= r.getRating()==3?"selected":"" %>>3</option>
                <option value="2" <%= r.getRating()==2?"selected":"" %>>2</option>
                <option value="1" <%= r.getRating()==1?"selected":"" %>>1</option>
            </select>

            <textarea name="comments"
                      class="form-control mb-2"
                      required><%= r.getComments() %></textarea>

            <button type="submit"
                    class="btn btn-warning btn-sm">
                Update
            </button>
        </form>

        <!-- DELETE FORM -->
        <form action="<%= request.getContextPath() %>/ReviewServlet"
              method="post">

            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="roomId" value="<%= roomId %>">
            <input type="hidden" name="reviewId" value="<%= r.getReviewId() %>">

            <button type="submit"
                    class="btn btn-danger btn-sm">
                Delete
            </button>
        </form>

        <% } %>

    </div>
</div>

<%
    }
} else {
%>
<p>No reviews yet.</p>
<%
}
%>

<!-- ADD REVIEW (ONLY IF NOT REVIEWED) -->

<% if (loggedUser == null) { %>

<p class="text-danger">
    Please <a href="<%= request.getContextPath() %>/views/login.jsp">
    login</a> to add a review.
</p>

<% } else if (!hasReviewed) { %>

<h4>Add Your Review</h4>

<form action="<%= request.getContextPath() %>/ReviewServlet"
      method="post">

    <input type="hidden" name="action" value="add">
    <input type="hidden" name="roomId" value="<%= roomId %>">

    <div class="mb-2">
        <label>Rating</label>
        <select name="rating" class="form-control" required>
            <option value="">Select</option>
            <option value="5">5 - Excellent</option>
            <option value="4">4 - Very Good</option>
            <option value="3">3 - Good</option>
            <option value="2">2 - Average</option>
            <option value="1">1 - Poor</option>
        </select>
    </div>

    <div class="mb-2">
        <label>Comments</label>
        <textarea name="comments"
                  class="form-control"
                  required></textarea>
    </div>

    <button type="submit"
            class="btn btn-success">
        Submit Review
    </button>

</form>

<% } %>

<br>

<a href="<%= request.getContextPath() %>/RoomServlet?action=list">
    Back
</a>

<script>

let basePrice = <%= room.getPrice() %>;

function calculateTotal(){

    let selected =
        document.querySelector('input[name="offer"]:checked');

    let total = basePrice;

    if(selected && selected.value !== ""){

        let rate = selected.getAttribute("data-rate");

        let discount = (total * rate) / 100;

        total = total - discount;

        document.getElementById("selectedOffer").value =
            selected.value;

    } else {
        document.getElementById("selectedOffer").value = "";
    }

    document.getElementById("totalDisplay").innerText =
        total.toFixed(2);

    document.getElementById("finalAmount").value =
        total.toFixed(2);
}

</script>

</body>
</html>