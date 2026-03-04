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

    <style>
        body{
    background:
        linear-gradient(
            rgba(30,30,30,0.75),   /* Dark gray top */
            rgba(30,30,30,0.75)    /* Dark gray bottom */
        ),
        url('https://images.unsplash.com/photo-1505693416388-ac5ce068fe85');
    background-size:cover;
    background-position:center;
    background-attachment:fixed;
    color:white;
    
}

        .glass-card{
            background: rgba(255,255,255,0.08);
            backdrop-filter: blur(12px);
            border-radius:20px;
            padding:30px;
            box-shadow:0 8px 32px rgba(0,0,0,0.4);
            margin-bottom:30px;
        }

        .slider-container{
            position:relative;
            width:100%;
            height:500px;
            overflow:hidden;
            border-radius:20px;
            box-shadow:0 10px 40px rgba(0,0,0,0.6);
        }

        .slide{
            position:absolute;
            width:100%;
            height:100%;
            object-fit:cover;
            opacity:0;
            transition:opacity 1s ease-in-out;
        }

        .slide.active{
            opacity:1;
        }

        h2,h3,h4{
            font-weight:600;
        }

        .btn-primary{
            background:linear-gradient(45deg,#00c6ff,#0072ff);
            border:none;
        }

        .btn-success{
            background:linear-gradient(45deg,#56ab2f,#a8e063);
            border:none;
        }

        .btn-warning{
            border:none;
        }

        .btn-danger{
            border:none;
        }

        a{
            color:#00c6ff;
            text-decoration:none;
        }

    </style>
</head>

<body>

<jsp:include page="/views/designs/header.jsp" />

<div class="container">

<h2 class="mb-4 text-center">Room Details</h2>

<!-- ================= IMAGE SLIDER ================= -->

<div class="slider-container mb-5">
<%
if(images != null && !images.isEmpty()){
    int index = 0;
    for(RoomImage img : images){
%>
    <img class="slide <%= (index==0?"active":"") %>"
         src="<%= request.getContextPath() %>/DisplayImageServlet?id=<%= img.getRoomImageId() %>">
<%
        index++;
    }
} else {
%>
    <img class="slide active"
         src="https://images.unsplash.com/photo-1566665797739-1674de7a421a">
<%
}
%>
</div>

<!-- PREMIUM TYPE + DESCRIPTION -->
<div class="text-center mb-4">

    <h3 style="
        font-weight:700;
        letter-spacing:1px;
        margin-top:20px;
    ">
        <%= room.getType() %>
    </h3>

    <p style="
        max-width:800px;
        margin:15px auto 0 auto;
        font-size:17px;
        line-height:1.7;
        color:rgba(255,255,255,0.85);
    ">
        <%= room.getDescription() %>
    </p>

</div>

<!-- PRICE & SIZE -->
<div class="glass-card text-center">
    <h4>Price per Day: $<%= room.getPrice() %></h4>
    <p>Size: <%= room.getSize() %></p>
</div>
<!-- ================= FACILITIES ================= -->

<div class="glass-card">
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

</div>

<!-- ================= OFFERS ================= -->

<div class="glass-card">
<h3>Available Offers</h3>

<form id="offerForm">
<%
if(offers != null){
    for(Offer o : offers){
%>
<div class="form-check mb-2">
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
</div>

<!-- ================= BOOKING ================= -->

<div class="glass-card">

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

</div>

<!-- ================= REVIEWS ================= -->

<div class="glass-card">

<h3 class="mb-4">Customer Reviews</h3>

<%
if(reviews != null && !reviews.isEmpty()){
    for(Review r : reviews){
%>

<div class="glass-card mb-3"
     style="background:rgba(255,255,255,0.05); padding:20px;">

    <!-- USER NAME -->
    <h5 style="margin-bottom:5px;">
        <%= r.getCustomerName() %>
    </h5>

    <!-- RATING -->
    <p style="margin-bottom:10px;">
        ⭐ <%= r.getRating() %>/5
    </p>

    <!-- COMMENTS -->
    <p style="color:rgba(255,255,255,0.85);">
        <%= r.getComments() %>
    </p>

    <!-- UPDATE & DELETE (ONLY OWNER) -->
    <%
    if (loggedUser != null &&
        loggedUser.getUserId() == r.getUserId()) {
    %>

        <!-- UPDATE FORM -->
        <form action="<%= request.getContextPath() %>/ReviewServlet"
              method="post"
              class="mb-2">

            <input type="hidden" name="action" value="update">
            <input type="hidden" name="roomId" value="<%= roomId %>">
            <input type="hidden" name="reviewId"
                   value="<%= r.getReviewId() %>">

            <select name="rating"
                    class="form-control mb-2"
                    required>

                <option value="5"
                    <%= r.getRating()==5?"selected":"" %>>
                    5 - Excellent
                </option>

                <option value="4"
                    <%= r.getRating()==4?"selected":"" %>>
                    4 - Very Good
                </option>

                <option value="3"
                    <%= r.getRating()==3?"selected":"" %>>
                    3 - Good
                </option>

                <option value="2"
                    <%= r.getRating()==2?"selected":"" %>>
                    2 - Average
                </option>

                <option value="1"
                    <%= r.getRating()==1?"selected":"" %>>
                    1 - Poor
                </option>

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
            <input type="hidden" name="reviewId"
                   value="<%= r.getReviewId() %>">

            <button type="submit"
                    class="btn btn-danger btn-sm">
                Delete
            </button>

        </form>

    <%
    }
    %>

</div>

<%
    }
} else {
%>

<p>No reviews yet.</p>

<%
}
%>

<!-- ================= ADD REVIEW ================= -->

<%
if (loggedUser == null) {
%>

<p class="text-danger">
    Please
    <a href="<%= request.getContextPath() %>/views/login.jsp">
        login
    </a>
    to add a review.
</p>

<%
} else if (!hasReviewed) {
%>

<h4 class="mt-4">Add Your Review</h4>

<form action="<%= request.getContextPath() %>/ReviewServlet"
      method="post">

    <input type="hidden" name="action" value="add">
    <input type="hidden" name="roomId" value="<%= roomId %>">

    <div class="mb-2">
        <label>Rating</label>
        <select name="rating"
                class="form-control"
                required>

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

<%
}
%>

</div>


<!-- ================= SCRIPTS ================= -->

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

/* IMAGE SLIDER AUTO TRANSITION */

let slides = document.querySelectorAll(".slide");
let current = 0;

if(slides.length > 1){

    setInterval(() => {

        slides[current].classList.remove("active");

        current = (current + 1) % slides.length;

        slides[current].classList.add("active");

    }, 4000);

}

</script>

</body>
</html>