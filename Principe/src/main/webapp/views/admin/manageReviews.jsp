<%@ page import="java.util.*" %>
<%@ page import="model.Review" %>
<%@ page import="dao.ReviewDAO" %>

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
    <title>Manage Reviews</title>
     <button type="button"
        onclick="window.location.href='<%= request.getContextPath() %>/views/adminDashboard.jsp'">
    ⬅ Back to Dashboard
</button>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="container mt-4">

<h2>All Reviews</h2>

<a href="<%= request.getContextPath() %>/views/adminDashboard.jsp">
    Back to Dashboard
</a>

<hr>

<%
if(list != null && !list.isEmpty()){
    for(Review r : list){
%>

<div class="card mb-3">
    <div class="card-body">

        <h6 class="text-primary">
            👤 <%= r.getCustomerName() %>
        </h6>

        <p><b>Room ID:</b> <%= r.getRoomId() %></p>

        <p><b>Rating:</b> ⭐ <%= r.getRating() %>/5</p>

        <p><b>Comment:</b> <%= r.getComments() %></p>

        <!-- ADMIN DELETE -->
        <form action="<%= request.getContextPath() %>/ReviewServlet" method="post">

            <input type="hidden" name="action" value="adminDelete">
            <input type="hidden" name="reviewId" value="<%= r.getReviewId() %>">
            <input type="hidden" name="roomId" value="<%= r.getRoomId() %>">

            <button type="submit" class="btn btn-danger btn-sm">
                Delete
            </button>

        </form>

    </div>
</div>

<%
    }
} else {
%>

<p>No reviews found.</p>

<%
}
%>

</body>
</html>