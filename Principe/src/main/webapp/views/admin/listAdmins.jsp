<%@ page import="dao.AdminDAO,java.util.*,model.Admin" %>

<%
    AdminDAO dao = new AdminDAO();
    List<Admin> list = dao.getAll();

    String search = request.getParameter("search");
    if(search != null && !search.trim().isEmpty()){
        list.removeIf(a -> 
            !a.getUsername().toLowerCase().contains(search.toLowerCase()) &&
            !a.getName().toLowerCase().contains(search.toLowerCase())
        );
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin List</title>
     <button type="button"
        onclick="window.location.href='<%= request.getContextPath() %>/views/adminDashboard.jsp'">
    ⬅ Back to Dashboard
</button>

    <!-- Simple Bootstrap CDN -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>

<body class="container mt-4">

<h2>Admin Management</h2>

<!-- Search Bar -->
<form method="get" class="mb-3">
    <input type="text" name="search" placeholder="Search..."
           class="form-control" style="width:300px; display:inline;">
    <button type="submit" class="btn btn-primary">Search</button>
</form>

<table class="table table-bordered table-striped">
    <tr class="table-dark">
        <th>ID</th>
        <th>Username</th>
        <th>Name</th>
        <th>Role</th>
        <th>Image</th>
        <th>Action</th>
    </tr>

<% for(Admin a : list){ %>
<tr>
    <td><%=a.getAdminId()%></td>
    <td><%=a.getUsername()%></td>
    <td><%=a.getName()%></td>
    <td><%=a.getRole()%></td>

    <td>
        <img src="<%=request.getContextPath()%>/AdminImageServlet?id=<%=a.getAdminId()%>"
         width="60" height="60">
    </td>

    <td>
        <select class="form-select"
                onchange="handleAction(this, '<%=a.getAdminId()%>')"
                style="width:120px;">
            <option value="">Action</option>
            <option value="view">View</option>
            <option value="edit">Edit</option>
            <option value="delete">Delete</option>
        </select>
    </td>
</tr>
<% } %>

</table>

<a href="addAdmin.jsp" class="btn btn-success">Add New Admin</a>

<script>
function handleAction(select, adminId){

    var action = select.value;

    if(action === "delete"){
        if(confirm("Are you sure you want to delete?")){
            window.location.href =
                "../../AdminServlet?action=delete&adminId=" + adminId;
        }
    }

    if(action === "edit"){
        window.location.href = "editAdmin.jsp?adminId=" + adminId;
    }

    if(action === "view"){
        window.location.href = "viewAdmin.jsp?adminId=" + adminId;
    }

    select.value = "";
}
</script>

</body>
</html>