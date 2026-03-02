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
</head>
<body>

<h2>Edit Room</h2>

<form action="<%= request.getContextPath() %>/RoomServlet"
      method="post"
      enctype="multipart/form-data">

    <input type="hidden" name="action" value="update">

    <!-- ================= ROOM DETAILS ================= -->

    Room ID:<br>
    <input type="text" name="roomId"
           value="<%= room.getRoomId() %>" readonly><br><br>

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
    <input type="number" step="0.01" name="price"
           value="<%= room.getPrice() %>" required><br><br>

    Description:<br>
    <input type="text" name="description"
           value="<%= room.getDescription() %>"><br><br>

    Size:<br>
    <input type="text" name="size"
           value="<%= room.getSize() %>"><br><br>
           
           Max Guests:<br>
<input type="number" name="maxGuest"
       value="<%= room.getMaxGuest() %>" min="1" required><br><br>

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

    <br><br>

    <!-- ================= FACILITIES ================= -->

    <h3>Facilities</h3>

    <%
        if(facilityList != null){
            for(model.Facility f : facilityList){
    %>

        <input type="checkbox"
               name="facilityIds"
               value="<%= f.getFacilityId() %>"
               <%= selectedFacilities.contains(f.getFacilityId()) ? "checked" : "" %> >

        <%= f.getFacilityName() %>
        <br>

    <%
            }
        }
    %>

    <br>

    <!-- ================= CURRENT IMAGES ================= -->

    <h3>Current Images</h3>

    <%
        if(images != null && !images.isEmpty()){
            for(RoomImage img : images){
    %>

        <div style="margin-bottom:10px;">

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
        } else {
            out.print("No Images");
        }
    %>

    <br>

    <!-- ================= ADD NEW IMAGES ================= -->

    <h3>Add New Images</h3>

    <input type="file"
           name="roomImages"
           multiple
           accept="image/*">

    <br><br>

    <input type="submit" value="Update Room">

</form>

<br>

<a href="<%= request.getContextPath() %>/RoomServlet?action=list">
    Back to Manage Rooms
</a>

</body>
</html>