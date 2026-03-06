<%@ page import="model.User" %>

<form action="<%=request.getContextPath()%>/AdminServlet"
      method="post"
      enctype="multipart/form-data">

<%
    // Optional: check admin session
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Admin | Principe Grand</title>
    <meta charset="UTF-8">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(rgba(0,0,0,0.85), rgba(0,0,0,0.85)),
                        url('https://images.unsplash.com/photo-1560347876-aeef00ee58a1');
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

        .form-card {
            background: rgba(255,255,255,0.07);
            backdrop-filter: blur(8px);
            padding: 40px;
            border-radius: 20px;
            width: 500px;
            transition: 0.3s;
        }

        .form-card:hover {
            background: rgba(212,175,55,0.12);
            transform: translateY(-5px);
        }

        h2 {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            color: #d4af37;
            margin-bottom: 30px;
            text-align: center;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            color: #d4af37;
        }

        input[type="text"], input[type="password"], input[type="file"] {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 20px;
            border-radius: 15px;
            border: none;
            outline: none;
            font-size: 14px;
        }

        button, a.btn {
            display: inline-block;
            padding: 10px 20px;
            border-radius: 25px;
            font-size: 16px;
            text-decoration: none;
            cursor: pointer;
            transition: 0.3s;
            margin-right: 10px;
            border: none;
        }

        button[type="submit"] {
            background: #28a745;
            color: white;
        }

        button[type="submit"]:hover {
            background: #218838;
        }

        a.btn {
            background: #6c757d;
            color: white;
        }

        a.btn:hover {
            background: #5a6268;
        }

        /* POPUP STYLE */

        .popup-overlay{
            position:fixed;
            top:0;
            left:0;
            width:100%;
            height:100%;
            background:rgba(0,0,0,0.6);
            backdrop-filter:blur(6px);
            display:flex;
            justify-content:center;
            align-items:center;
            z-index:9999;
        }

        .popup-box{
            background:white;
            color:#333;
            padding:35px;
            border-radius:15px;
            text-align:center;
            width:320px;
            box-shadow:0 15px 40px rgba(0,0,0,0.5);
        }

        .popup-box h3{
            margin-bottom:20px;
            color:#28a745;
        }

        .popup-box button{
            padding:10px 25px;
            border:none;
            background:#d4af37;
            color:white;
            border-radius:20px;
            cursor:pointer;
        }

        .popup-box button:hover{
            background:#b9972f;
        }

    </style>
</head>

<body>

<div class="container">

    <div class="form-card">

        <h2>Add New Admin</h2>

        <form action="<%=request.getContextPath()%>/AdminServlet"
              method="post" enctype="multipart/form-data">

            <input type="hidden" name="action" value="add">

            <label>Admin ID</label>
            <input type="text" name="adminId" placeholder="Enter Admin ID" required>

            <label>Username</label>
            <input type="text" name="username" placeholder="Enter Username" required>

            <label>Password</label>
            <input type="password" name="password" placeholder="Enter Password" required>

            <label>Name</label>
            <input type="text" name="name" placeholder="Enter Name" required>

            <label>Role</label>
            <input type="text" name="role" placeholder="Enter Role (e.g., Admin)" required>

            <label>Image</label>
            <input type="file" name="image" accept="image/*">

            <button type="submit">Add Admin</button>
            <a href="listAdmins.jsp" class="btn">Back</a>

        </form>

    </div>

</div>


<!-- SUCCESS POPUP -->

<%
String success = request.getParameter("success");
if("1".equals(success)){
%>

<div class="popup-overlay">
    <div class="popup-box">
        <h3>Admin Added Successfully</h3>
        <button onclick="window.location.href='listAdmins.jsp'">
            OK
        </button>
    </div>
</div>

<%
}
%>

</body>
</html>