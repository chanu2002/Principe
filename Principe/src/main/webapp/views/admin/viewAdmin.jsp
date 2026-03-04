<%@ page import="model.Admin,dao.AdminDAO" %>

<%
    String id = request.getParameter("adminId");
    AdminDAO dao = new AdminDAO();
    Admin admin = null;

    for(Admin a : dao.getAll()){
        if(a.getAdminId().equals(id)){
            admin = a;
            break;
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Details | Principe Grand</title>
    <meta charset="UTF-8">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(rgba(0,0,0,0.85), rgba(0,0,0,0.85)),
                        url('https://images.unsplash.com/photo-1551882547-ff40c63fe5fa');
            background-size: cover;
            background-position: center;
            color: white;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 50px;
        }

        .card {
            background: rgba(255,255,255,0.07);
            backdrop-filter: blur(8px);
            padding: 40px;
            border-radius: 20px;
            width: 450px;
            text-align: center;
            transition: 0.3s;
        }

        .card:hover {
            background: rgba(212,175,55,0.12);
            transform: translateY(-5px);
        }

        h2 {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            color: #d4af37;
            margin-bottom: 30px;
        }

        .label {
            font-weight: 600;
            color: #d4af37;
        }

        p {
            font-size: 16px;
            margin: 8px 0;
        }

        img {
            margin-top: 15px;
            border-radius: 15px;
            border: 2px solid #d4af37;
        }

        a.btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            border-radius: 25px;
            font-size: 16px;
            text-decoration: none;
            background: #6c757d;
            color: white;
            transition: 0.3s;
        }

        a.btn:hover {
            background: #5a6268;
        }

    </style>
</head>

<body>

<div class="container">

    <div class="card">

        <h2>Admin Details</h2>

        <p><span class="label">ID:</span> <%=admin.getAdminId()%></p>
        <p><span class="label">Username:</span> <%=admin.getUsername()%></p>
        <p><span class="label">Password:</span> <%=admin.getPassword()%></p>
        <p><span class="label">Name:</span> <%=admin.getName()%></p>
        <p><span class="label">Role:</span> <%=admin.getRole()%></p>

        <img src="../../AdminImageServlet?id=<%=admin.getAdminId()%>" width="120">

        <br>
        <a href="listAdmins.jsp" class="btn">Back to List</a>

    </div>

</div>

</body>
</html>