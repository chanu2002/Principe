<%@ page import="dao.UserDAO, model.User, java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    UserDAO userDAO = new UserDAO();
    List<User> users = userDAO.getAlls();
%>

<!DOCTYPE html>
<html>
<head>
    <title>All Users | Admin Panel</title>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
        /* Full page background container */
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: 'Poppins', sans-serif;
        }

        /* Background image wrapper */
         .bg-image {
        position: fixed;
        top: 0; left: 0;
        width: 100%;
        height: 100%;
        z-index: -1;
        background-image:url('https://images.unsplash.com/photo-1445019980597-93fa8acb246c');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        filter: blur(8px) brightness(0.5);
    }

        /* Page container */
        .container {
            padding: 40px;
            max-width: 1200px;
            margin: auto;
            position: relative; /* make sure content stacks above bg */
        }

        /* Back button in top-left */
        .back-btn {
            background-color: #ffd700;
            color: #222;
            font-weight: 600;
            padding: 12px 24px;
            border-radius: 30px;
            text-decoration: none;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
            transition: 0.3s;
            display: inline-block;
            margin-bottom: 30px;
        }

        .back-btn:hover {
            background-color: #e6c200;
            transform: translateY(-2px);
        }

        /* Header */
        h2 {
            color: #ffd700;
            font-size: 32px;
            text-align: center;
            text-shadow: 1px 1px 5px rgba(0,0,0,0.7);
            margin-bottom: 30px;
        }

        /* Table card */
        .table-container {
            overflow-x: auto;
            background: rgba(255, 255, 255, 0.9);
            padding: 25px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 900px;
        }

        th, td {
            padding: 15px 12px;
            text-align: left;
        }

        th {
            background-color: #ffd700;
            color: #222;
            font-weight: 600;
            font-size: 15px;
        }

        tr:nth-child(even) {
            background-color: rgba(255,255,255,0.85);
        }

        tr:hover {
            background-color: rgba(255, 223, 0, 0.15);
            transition: 0.3s;
        }

        /* Delete button */
        button.delete-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 6px 14px;
            border-radius: 25px;
            cursor: pointer;
            font-weight: 500;
            transition: 0.3s;
            box-shadow: 0 3px 8px rgba(0,0,0,0.3);
        }

        button.delete-btn:hover {
            background-color: #c82333;
            transform: translateY(-1px);
        }

        /* Responsive */
        @media(max-width: 900px) {
            th, td {
                padding: 12px 8px;
            }
            .back-btn {
                padding: 10px 20px;
            }
        }
    </style>

    <script>
        function confirmDelete(userId) {
            if (confirm("Are you sure you want to delete this user?")) {
                window.location.href = "<%=request.getContextPath()%>/UserServlet?action=delete&userId=" + userId;
            }
        }
    </script>
</head>
<body>

<!-- Background image -->
<div class="bg-image"></div>

<div class="container">
    <a href="<%=request.getContextPath()%>/views/adminDashboard.jsp" class="back-btn">Back to Dashboard</a>
    <h2>All Users</h2>

    <div class="table-container">
        <table>
            <tr>
                <th>User ID</th>
                <th>Username</th>
                <th>Name</th>
                <th>Email</th>
                <th>Tel No</th>
                <th>Address</th>
                <th>Role</th>
                <th>Action</th>
            </tr>

            <% for(User u : users) { %>
            <tr>
                <td><%= u.getUserId() %></td>
                <td><%= u.getUsername() %></td>
                <td><%= u.getName() %></td>
                <td><%= u.getEmail() != null ? u.getEmail() : "" %></td>
                <td><%= u.getTelNo() != null ? u.getTelNo() : "" %></td>
                <td><%= u.getAddress() != null ? u.getAddress() : "" %></td>
                <td><%= u.getRole() %></td>
                <td>
                    <button class="delete-btn" onclick="confirmDelete(<%= u.getUserId() %>)">Delete</button>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
</div>

</body>
</html>
