<%@ page import="java.util.*, dao.FacilityDAO, model.Facility" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Room</title>
</head>
<body>

<h2>Add New Room</h2>

<%
    // Load all facilities from database
    FacilityDAO fdao = new FacilityDAO();
    List<Facility> facilityList = fdao.getAll();
%>

<!-- IMPORTANT: enctype is required for file upload -->
<form action="<%= request.getContextPath() %>/RoomServlet"
      method="post"
      enctype="multipart/form-data">

    <input type="hidden" name="action" value="add">

    Room ID:<br>
    <input type="text" name="roomId" required><br><br>

   Type:<br>
<select name="type" required>

    <option value="">-- Select Room Type --</option>

    <option value="EXECUTIVE ROOM">EXECUTIVE ROOM</option>

    <option value="DELUXE ROOM">DELUXE ROOM</option>

    <option value="SUPERIOR ROOM">SUPERIOR ROOM</option>

    <option value="PRESIDENTIAL SUITE">PRESIDENTIAL SUITE</option>

</select>

<br><br>

    Price:<br>
    <input type="number" step="0.01" name="price" required><br><br>

    Description:<br>
    <input type="text" name="description"><br><br>

    Size:<br>
    <input type="text" name="size"><br><br>
    
    Max Guests:<br>
<input type="number" name="maxGuest" min="1" required><br><br>

    Availability:<br>
    <select name="availability">
        <option value="AVAILABLE">AVAILABLE</option>
        <option value="NOT_AVAILABLE">NOT_AVAILABLE</option>
    </select>
    <br><br>

    <!-- ================= FACILITIES ================= -->

    <h3>Facilities</h3>

    <%
        if(facilityList != null){
            for(model.Facility f : facilityList){
    %>

        <input type="checkbox"
               name="facilityIds"
               value="<%= f.getFacilityId() %>">
        <%= f.getFacilityName() %>
        <br>

    <%
            }
        }
    %>

    <br>

    <!-- ================= MULTIPLE IMAGES ================= -->

    <h3>Room Images</h3>

    <input type="file"
           name="roomImages"
           multiple
           accept="image/*">

    <br><br>

    <input type="submit" value="Save Room">

</form>

<br>

<a href="<%= request.getContextPath() %>/RoomServlet?action=list">
    Back to Manage Rooms
</a>

</body>
</html>