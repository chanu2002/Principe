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
</head>
<body>

<h2>Manage Rooms</h2>

<!-- ================= ADD ROOM FORM ================= -->

<h3>Add New Room</h3>

<form action="<%= request.getContextPath() %>/RoomServlet"
      method="post"
      enctype="multipart/form-data">

    <input type="hidden" name="action" value="add">

    Room ID:<br>
    <input type="text" name="roomId" required><br><br>

    Type:<br>
<select name="type" required>

    <option value="">-- Select Room Type --</option>

    <option value="EXCECUTIVE ROOM">EXCECUTIVE ROOM</option>

    <option value="DELUXE ROOM">DELUXE ROOM</option>

    <option value="SUPIRIOR ROOM">SUPIRIOR ROOM</option>

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
    </select><br><br>

    <!-- ================= FACILITIES ================= -->

    <h4>Facilities</h4>

    <%
        if(facilityList != null){
            for(Facility f : facilityList){
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

    <!-- ================= IMAGES ================= -->

    <h4>Room Images</h4>

    <input type="file"
           name="roomImages"
           multiple
           accept="image/*">

    <br><br>

    <input type="submit" value="Save Room">

</form>

<hr>

<!-- ================= ROOM LIST ================= -->

<h3>All Rooms</h3>

<table border="1" cellpadding="8">

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

    <!-- ================= FACILITIES DISPLAY ================= -->

    <td>
    <%
        String facilitiesText = "";

        for(Facility f : facilityList){
            if(selected.contains(f.getFacilityId())){
                if(facilitiesText.isEmpty()){
                    facilitiesText = f.getFacilityName();
                } else {
                    facilitiesText += ", " + f.getFacilityName();
                }
            }
        }

        out.print(facilitiesText.isEmpty()
                  ? "No Facilities"
                  : facilitiesText);
    %>
    </td>

    <!-- ================= IMAGES DISPLAY ================= -->

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
        } else {
            out.print("No Images");
        }
    %>
    </td>

    <!-- ================= ACTION ================= -->

    <td>

        <a href="<%= request.getContextPath() %>/RoomServlet?action=edit&roomId=<%= r.getRoomId() %>">
            Edit
        </a>

        <form action="<%= request.getContextPath() %>/RoomServlet"
              method="post"
              style="display:inline;">

            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="roomId" value="<%= r.getRoomId() %>">

            <input type="submit" value="Delete">
        </form>

    </td>

</tr>

<%
    }
}
%>

</table>

</body>
</html>