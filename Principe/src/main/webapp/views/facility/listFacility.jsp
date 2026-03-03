<%@ page import="dao.FacilityDAO,java.util.*,model.Facility" %>

<%
    FacilityDAO dao = new FacilityDAO();
    List<Facility> list = dao.getAll();
%>

 <button type="button"
        onclick="window.location.href='<%= request.getContextPath() %>/views/adminDashboard.jsp'">
    ⬅ Back to Dashboard
</button>

<table border="1">
<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Description</th>
    <th>Action</th>
</tr>

<% for(Facility f : list){ %>
<tr>
    <td><%=f.getFacilityId()%></td>
    <td><%=f.getFacilityName()%></td>
    <td><%=f.getDescription()%></td>
    <td>
    <a href="editFacility.jsp?facilityId=<%=f.getFacilityId()%>">Edit</a>
        <a href="../../FacilityServlet?action=delete&facilityId=<%=f.getFacilityId()%>">
            Delete
        </a>
    </td>
</tr>
<% } %>

</table>

<a href="addFacility.jsp">Add Facility</a><br>

