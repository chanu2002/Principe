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
    <title>Admin Management | Principe Grand</title>
    <meta charset="UTF-8">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
           background: linear-gradient(rgba(0,0,0,0.85), rgba(0,0,0,0.85)),
                        url('https://images.unsplash.com/photo-1582719508461-905c673771fd');
            background-size: cover;
            background-position: center;
            color: white;
        }

        .container {
            padding: 50px;
        }

        h2 {
            font-family: 'Playfair Display', serif;
            font-size: 36px;
            color: #d4af37;
            margin-bottom: 25px;
        }

        .back-btn {
            background: transparent;
            border: 1px solid #d4af37;
            color: #d4af37;
            padding: 8px 18px;
            border-radius: 25px;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
            transition: 0.3s;
        }

        .back-btn:hover {
            background: #d4af37;
            color: black;
        }

        .search-bar {
            display: flex;
            gap: 10px;
            margin-bottom: 25px;
        }

        .search-bar input {
            padding: 8px 12px;
            border-radius: 25px;
            border: none;
            width: 300px;
            outline: none;
        }

        .search-bar button {
            padding: 8px 18px;
            border-radius: 25px;
            border: none;
            background: #28a745;
            color: white;
            cursor: pointer;
            transition: 0.3s;
        }

        .search-bar button:hover {
            background: #218838;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255,255,255,0.07);
            backdrop-filter: blur(8px);
            border-radius: 15px;
            overflow: hidden;
        }

        th {
            background: #d4af37;
            color: black;
            padding: 15px;
            text-transform: uppercase;
            font-size: 14px;
        }

        td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        tr:hover {
            background: rgba(212,175,55,0.12);
            transition: 0.3s;
        }

        img.admin-img {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #d4af37;
        }

        select.action-select {
            padding: 6px 10px;
            border-radius: 15px;
            border: none;
            cursor: pointer;
            background: rgba(212,175,55,0.15);
            color: white;
            transition: 0.3s;
        }

        select.action-select:hover {
            background: rgba(212,175,55,0.25);
        }

        .add-btn {
            margin-top: 20px;
            padding: 8px 20px;
            border-radius: 25px;
            background: #28a745;
            color: white;
            text-decoration: none;
            display: inline-block;
            transition: 0.3s;
        }

        .add-btn:hover {
            background: #218838;
        }

    </style>
</head>

<body>

<div class="container">

    <h2>Admin Management</h2>

    <a href="../adminDashboard.jsp" class="back-btn"> Back to Dashboard</a>

    <!-- Search Bar -->
    <form method="get" class="search-bar">
        <input type="text" name="search" placeholder="Search by username or name" value="<%= search != null ? search : "" %>">
        <button type="submit">Search</button>
    </form>

    <table>
        <tr>
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
                     class="admin-img">
            </td>
            <td>
                <select class="action-select"
                        onchange="handleAction(this, '<%=a.getAdminId()%>')">
                    <option value="">Action</option>
                    <option value="view">View</option>
                    <option value="edit">Edit</option>
                    <option value="delete">Delete</option>
                </select>
            </td>
        </tr>
        <% } %>
    </table>

    <a href="addAdmin.jsp" class="add-btn"> Add New Admin</a>

</div>

<script>
function handleAction(select, adminId){
    var action = select.value;
    if(action === "delete"){
        if(confirm("Are you sure you want to delete?")){
            window.location.href = "../../AdminServlet?action=delete&adminId=" + adminId;
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