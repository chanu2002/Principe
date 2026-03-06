<%@ page import="model.Room" %>
<%
Room room = (Room) request.getAttribute("room");

if(room == null){
    response.sendRedirect(request.getContextPath() + "/RoomServlet?action=list");
    return;
}
%>

<%@ page import="java.util.*, 
                 dao.FacilityDAO, 
                 dao.RoomFacilityDAO, 
                 dao.RoomImageDAO, 
                 model.RoomImage" %>

<%
FacilityDAO fdao = new FacilityDAO();
RoomFacilityDAO rfdao = new RoomFacilityDAO();
RoomImageDAO imgDAO = new RoomImageDAO();

List<model.Facility> facilityList = fdao.getAll();
List<Integer> selectedFacilities =
        rfdao.getFacilityIdsByRoom(room.getRoomId());

List<RoomImage> images =
        imgDAO.getImagesByRoom(room.getRoomId());
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Room</title>

<style>

body{
    font-family: Arial, Helvetica, sans-serif;
    margin:0;
    padding:40px;
    background: linear-gradient(rgba(0,0,0,0.6),rgba(0,0,0,0.6)),
    url("https://images.unsplash.com/photo-1566073771259-6a8506099945") center/cover no-repeat fixed;
    color:#fff;
}

/* Page Title */

h2{
    text-align:center;
    font-size:34px;
    margin-bottom:30px;
}

/* Card container */

.form-card{
    background:rgba(0,0,0,0.75);
    padding:40px;
    border-radius:10px;
    max-width:850px;
    margin:auto;
    box-shadow:0 10px 25px rgba(0,0,0,0.6);
}

/* Inputs */

input[type=text],
input[type=number],
select{
    width:100%;
    padding:10px;
    margin-top:6px;
    margin-bottom:18px;
    border-radius:6px;
    border:none;
}

/* Button */

input[type=submit]{
    background:#00bcd4;
    border:none;
    padding:12px 20px;
    color:white;
    font-size:16px;
    border-radius:6px;
    cursor:pointer;
}

input[type=submit]:hover{
    background:#0097a7;
}

/* Facilities */

.facilities{
    display:grid;
    grid-template-columns:repeat(2,1fr);
    gap:10px;
}

/* Images */

.image-box{
    display:inline-block;
    margin:10px;
    text-align:center;
}

.image-box img{
    border-radius:6px;
    box-shadow:0 4px 12px rgba(0,0,0,0.5);
}

/* Back button */

.back-btn{
    display:inline-block;
    margin-top:20px;
    padding:10px 16px;
    background:#00bcd4;
    color:white;
    text-decoration:none;
    border-radius:6px;
}

.back-btn:hover{
    background:#0097a7;
}

</style>

</head>

<body>

<h2>Edit Room</h2>

<div class="form-card">

<form action="<%= request.getContextPath() %>/RoomServlet"
      method="post"
      enctype="multipart/form-data">

<input type="hidden" name="action" value="update">

<!-- ================= ROOM DETAILS ================= -->

Room ID:<br>
<input type="text" name="roomId"
       value="<%= room.getRoomId() %>" readonly>

Type:<br>
<select name="type" required>

<option value="">-- Select Room Type --</option>

<option value="EXECUTIVE ROOM">EXECUTIVE ROOM</option>

<option value="DELUXE ROOM">DELUXE ROOM</option>

<option value="SUPERIOR ROOM">SUPERIOR ROOM</option>

<option value="PRESIDENTIAL SUITE">PRESIDENTIAL SUITE</option>

</select>

Price:<br>
<input type="number" step="0.01" name="price"
       value="<%= room.getPrice() %>" required>

Description:<br>
<input type="text" name="description"
       value="<%= room.getDescription() %>">

Size:<br>
<input type="text" name="size"
       value="<%= room.getSize() %>">

Max Guests:<br>
<input type="number" name="maxGuest"
       value="<%= room.getMaxGuest() %>" min="1" required>

Availability:<br>
<select name="availability">

<option value="AVAILABLE"
<%= "AVAILABLE".equals(room.getAvailability()) ? "selected" : "" %>>
AVAILABLE
</option>

<option value="NOT_AVAILABLE"
<%= "NOT_AVAILABLE".equals(room.getAvailability()) ? "selected" : "" %>>
NOT_AVAILABLE
</option>

</select>

<br>

<!-- ================= FACILITIES ================= -->

<h3>Facilities</h3>

<div class="facilities">

<%
if(facilityList != null){
for(model.Facility f : facilityList){
%>

<label>
<input type="checkbox"
name="facilityIds"
value="<%= f.getFacilityId() %>"
<%= selectedFacilities.contains(f.getFacilityId()) ? "checked" : "" %>>

<%= f.getFacilityName() %>
</label>

<%
}
}
%>

</div>

<br>

<!-- ================= CURRENT IMAGES ================= -->

<h3>Current Images</h3>

<%
if(images != null && !images.isEmpty()){
for(RoomImage img : images){
%>

<div class="image-box">

<img src="<%= request.getContextPath() %>/DisplayImageServlet?id=<%= img.getRoomImageId() %>"
width="120" height="90">

<br>

<input type="checkbox"
name="deleteImageIds"
value="<%= img.getRoomImageId() %>">

Delete

</div>

<%
}
}else{
out.print("No Images");
}
%>

<br><br>

<!-- ================= ADD NEW IMAGES ================= -->

<h3>Add New Images</h3>

<input type="file"
name="roomImages"
multiple
accept="image/*">

<br><br>

<input type="submit" value="Update Room">

</form>

<a class="back-btn"
href="<%= request.getContextPath() %>/RoomServlet?action=list">
Back to Manage Rooms
</a>

</div>

</body>
</html>