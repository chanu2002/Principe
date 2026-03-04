<%@ page import="java.util.*" %>
<%@ page import="model.Review" %>

<%
    if(session.getAttribute("admin") == null){
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    List<Review> list = (List<Review>) request.getAttribute("reviewList");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Reviews | Principe Grand</title>
    <meta charset="UTF-8">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>

        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(rgba(0,0,0,0.85), rgba(0,0,0,0.85)),
                        url('https://images.unsplash.com/photo-1582719478250-c89cae4dc85b');
            background-size: cover;
            background-position: center;
            color: white;
        }

        .container {
            padding: 50px;
        }

        h2 {
            font-family: 'Playfair Display', serif;
            font-size: 38px;
            color: #d4af37;
            margin-bottom: 25px;
        }

        .back-btn {
            background: transparent;
            border: 1px solid #d4af37;
            color: #d4af37;
            padding: 8px 18px;
            border-radius: 25px;
            cursor: pointer;
            transition: 0.3s;
            margin-bottom: 30px;
        }

        .back-btn:hover {
            background: #d4af37;
            color: black;
        }

        .review-card {
            background: rgba(255,255,255,0.07);
            backdrop-filter: blur(8px);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            transition: 0.3s;
        }

        .review-card:hover {
            transform: translateY(-5px);
            background: rgba(212,175,55,0.12);
        }

        .customer-name {
            font-size: 18px;
            font-weight: 600;
            color: #d4af37;
        }

        .info {
            margin: 8px 0;
            font-size: 14px;
        }

        .stars {
            color: gold;
            font-size: 16px;
        }

        .comment-box {
            margin-top: 10px;
            padding: 10px;
            background: rgba(0,0,0,0.4);
            border-radius: 10px;
            font-size: 14px;
        }

        .delete-btn {
            margin-top: 15px;
            background: #dc3545;
            border: none;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            color: white;
            cursor: pointer;
            transition: 0.3s;
        }

        .delete-btn:hover {
            background: #b02a37;
        }

        .no-review {
            font-size: 16px;
            color: #ccc;
        }

    </style>
</head>

<body>

<div class="container">

    <h2>Manage Reviews</h2>

    <button class="back-btn"
        onclick="window.location.href='<%= request.getContextPath() %>/views/adminDashboard.jsp'">
        Back to Dashboard
    </button>

    <hr style="border-color: rgba(255,255,255,0.2);">

    <%
    if(list != null && !list.isEmpty()){
        for(Review r : list){
    %>

    <div class="review-card">

        <div class="customer-name">
            👤 <%= r.getCustomerName() %>
        </div>

        <div class="info">
            🏨 <b>Room ID:</b> <%= r.getRoomId() %>
        </div>

        <div class="info stars">
            <%
                int rating = r.getRating();
                for(int i=1; i<=5; i++){
                    if(i <= rating){
                        out.print("★ ");
                    } else {
                        out.print("☆ ");
                    }
                }
            %>
            (<%= rating %>/5)
        </div>

        <div class="comment-box">
            💬 <%= r.getComments() %>
        </div>

        <!-- ADMIN DELETE -->
        <form action="<%= request.getContextPath() %>/ReviewServlet" method="post">

            <input type="hidden" name="action" value="adminDelete">
            <input type="hidden" name="reviewId" value="<%= r.getReviewId() %>">
            <input type="hidden" name="roomId" value="<%= r.getRoomId() %>">

            <button type="submit" class="delete-btn"
                onclick="return confirm('Delete this review?')">
                Delete Review
            </button>

        </form>

    </div>

    <%
        }
    } else {
    %>

        <p class="no-review">No reviews found.</p>

    <%
    }
    %>

</div>

</body>
</html>