<form action="<%=request.getContextPath()%>/FacilityServlet" method="post">

<%
    // You can also check admin session here if needed
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Facility | Principe Grand</title>
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
            width: 450px;
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

        input[type="text"], textarea {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 20px;
            border-radius: 15px;
            border: none;
            outline: none;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            min-height: 80px;
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

    </style>
</head>

<body>

<div class="container">

    <div class="form-card">

        <h2>Add New Facility</h2>

        <form action="<%=request.getContextPath()%>/FacilityServlet" method="post">
            <input type="hidden" name="action" value="add">

            <label>Facility Name</label>
            <input type="text" name="facilityName" placeholder="Enter facility name" required>

            <label>Description</label>
            <textarea name="description" placeholder="Enter description" required></textarea>

            <button type="submit">Add Facility</button>
            <a href="listFacility.jsp" class="btn">Back</a>

        </form>

    </div>

</div>

</body>
</html>