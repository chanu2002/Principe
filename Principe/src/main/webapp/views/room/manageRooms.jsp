<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.*" %>
<%@ page import="model.Room" %>
<%@ page import="model.Facility" %>
<%@ page import="model.RoomImage" %>

<%@ page import="dao.FacilityDAO" %>
<%@ page import="dao.RoomFacilityDAO" %>
<%@ page import="dao.RoomImageDAO" %>

<%
List<Room> list = (List<Room>) request.getAttribute("roomList");

// Load facilities
FacilityDAO fdao = new FacilityDAO();
List<Facility> facilityList = fdao.getAll();

RoomFacilityDAO rfdao = new RoomFacilityDAO();
RoomImageDAO imgDAO = new RoomImageDAO();
%>

<!DOCTYPE html>
<html>
<head>
<title>Manage Rooms</title>

<style>

/* ===== PAGE BACKGROUND ===== */

body{
    margin:0;
    font-family:Segoe UI, Arial;
    background:
    linear-gradient(rgba(90,90,90,0.85),rgba(90,90,90,0.85)),
    url("https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=1600&q=80");
    background-size:cover;
    background-attachment:fixed;
    color:white;
}

/* ===== CONTAINER ===== */

.container{
    width:90%;
    margin:auto;
    padding:30px;
}

/* ===== HEADINGS ===== */

h2{
    text-align:center;
    font-size:32px;
    margin-bottom:20px;
}

h3{
    margin-top:30px;
}

/* ===== BACK BUTTON ===== */

.backBtn{
    background:#444;
    color:white;
    border:none;
    padding:10px 16px;
    border-radius:6px;
    cursor:pointer;
}

.backBtn:hover{
    background:#666;
}

/* ===== FORM CARD ===== */

.formCard{
    background:rgba(255,255,255,0.1);
    padding:25px;
    border-radius:10px;
    backdrop-filter:blur(6px);
}

/* ===== INPUTS ===== */

input[type=text],
input[type=number],
select{
    width:100%;
    padding:8px;
    border-radius:6px;
    border:none;
    margin-top:5px;
    margin-bottom:12px;
}

/* ===== SAVE BUTTON ===== */

input[type=submit]{
    background:#2e7d32;
    color:white;
    padding:10px 18px;
    border:none;
    border-radius:6px;
    cursor:pointer;
}

input[type=submit]:hover{
    background:#1b5e20;
}

/* ===== FACILITIES GRID ===== */

.facilityGrid{
    display:grid;
    grid-template-columns:repeat(auto-fill,minmax(160px,1fr));
    gap:8px;
}

/* ===== TABLE ===== */

table{
    width:100%;
    border-collapse:collapse;
    margin-top:20px;
    background:white;
    color:black;
    border-radius:10px;
    overflow:hidden;
}

/* ===== TABLE HEADER ===== */

th{
    background:#555;
    color:white;
    padding:12px;
}

/* ===== TABLE CELLS ===== */

td{
    padding:10px;
    text-align:center;
    border-bottom:1px solid #ddd;
}

/* ===== ROOM IMAGES ===== */

td img{
    border-radius:6px;
}

/* ===== ACTION LINKS ===== */

a{
    color:#1976d2;
    text-decoration:none;
}

a:hover{
    text-decoration:underline;
}

/* ===== DELETE BUTTON ===== */

.deleteBtn{
    background:#c62828;
    color:white;
    border:none;
    padding:6px 10px;
    border-radius:5px;
    cursor:pointer;
}

.deleteBtn:hover{
    background:#8e0000;
}

</style>

</head>

<body>

<div class="container">

<button class="backBtn"
onclick="window.location.href='<%= request.getContextPath() %>/views/adminDashboard.jsp'">
⬅ Back to Dashboard
</button>

<h2>Manage Rooms</h2>

<!-- ================= ADD ROOM FORM ================= -->

<div class="formCard">

<h3>Add New Room</h3>

<form action="<%= request.getContextPath() %>/RoomServlet"
method="post"
enctype="multipart/form-data">

<input type="hidden" name="action" value="add">

Room ID:
<input type="text" name="roomId" required>

Type:

<select name="type" required>

<option value="">-- Select Room Type --</option>

<option value="EXCECUTIVE ROOM">EXCECUTIVE ROOM</option>

<option value="DELUXE ROOM">DELUXE ROOM</option>

<option value="SUPIRIOR ROOM">SUPIRIOR ROOM</option>

<option value="PRESIDENTIAL SUITE">PRESIDENTIAL SUITE</option>

</select>

Price:
<input type="number" step="0.01" name="price" required>

Description:
<input type="text" name="description">

Size:
<input type="text" name="size">

Max Guests:
<input type="number" name="maxGuest" min="1" required>

Availability:

<select name="availability">

<option value="AVAILABLE">AVAILABLE</option>

<option value="NOT_AVAILABLE">NOT_AVAILABLE</option>

</select>

<!-- ================= FACILITIES ================= -->

<h4>Facilities</h4>

<div class="facilityGrid">

<%
if(facilityList != null){
for(Facility f : facilityList){
%>

<label>
<input type="checkbox"
name="facilityIds"
value="<%= f.getFacilityId() %>">

<%= f.getFacilityName() %>
</label>

<%
}
}
%>

</div>

<br>

<!-- ================= IMAGES ================= -->

<h4>Room Images</h4>

<input type="file"
name="roomImages"
multiple
accept="image/*">

<br><br>

<input type="submit" value="Save Room">

</form>

</div>

<hr>

<!-- ================= ROOM LIST ================= -->

<h3>All Rooms</h3>

<table>

<tr>

<th>Room ID</th>

<th>Type</th>

<th>Price</th>

<th>Size</th>

<th>Maximum Guests</th>

<th>Availability</th>

<th>Facilities</th>

<th>Images</th>

<th>Action</th>

</tr>

<%

if(list != null){

for(Room r : list){

List<Integer> selected =
rfdao.getFacilityIdsByRoom(r.getRoomId());

List<RoomImage> images =
imgDAO.getImagesByRoom(r.getRoomId());

%>

<tr>

<td><%= r.getRoomId() %></td>

<td><%= r.getType() %></td>

<td><%= r.getPrice() %></td>

<td><%= r.getSize() %></td>

<td><%= r.getMaxGuest() %></td>

<td><%= r.getAvailability() %></td>

<!-- FACILITIES -->

<td>

<%

String facilitiesText = "";

for(Facility f : facilityList){

if(selected.contains(f.getFacilityId())){

if(facilitiesText.isEmpty()){

facilitiesText = f.getFacilityName();

}else{

facilitiesText += ", " + f.getFacilityName();

}

}

}

out.print(facilitiesText.isEmpty()

? "No Facilities"

: facilitiesText);

%>

</td>

<!-- IMAGES -->

<td>

<%

if(images != null && !images.isEmpty()){

for(RoomImage img : images){

%>

<img src="<%= request.getContextPath() %>/DisplayImageServlet?id=<%= img.getRoomImageId() %>"
width="70"
height="50"
style="margin:2px;">

<%

}

}else{

out.print("No Images");

}

%>

</td>

<!-- ACTION -->

<td>

<a href="<%= request.getContextPath() %>/RoomServlet?action=edit&roomId=<%= r.getRoomId() %>">

Edit

</a>

<br><br>

<form action="<%= request.getContextPath() %>/RoomServlet"
method="post"
style="display:inline;">

<input type="hidden" name="action" value="delete">

<input type="hidden" name="roomId"
value="<%= r.getRoomId() %>">

<input class="deleteBtn"
type="submit"
value="Delete">

</form>

</td>

</tr>

<%

}

}

%>

</table>

</div>

</body>
</html>