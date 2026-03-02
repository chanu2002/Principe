<%@ page language="java" %>

<%
    if(session.getAttribute("admin") == null){
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Offer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="container mt-4">

<h2>Add New Offer</h2>

<form action="<%= request.getContextPath() %>/OfferServlet" method="post">

    <!-- Action -->
    <input type="hidden" name="action" value="add">

    <!-- Offer ID (Manual by Admin) -->
    <div class="mb-3">
        <label>Offer ID</label>
        <input type="text" name="offerId"
               class="form-control"
               placeholder="Enter Offer ID (e.g., OFF001)"
               required>
    </div>

    <!-- Offer Name -->
    <div class="mb-3">
        <label>Offer Name</label>
        <input type="text" name="offerName"
               class="form-control"
               required>
    </div>

    <!-- Offer Rate (%) -->
    <div class="mb-3">
        <label>Offer Rate (%)</label>
        <input type="number" name="offerRate"
               class="form-control"
               min="1" max="100"
               placeholder="Enter percentage (e.g., 20)"
               required>
    </div>

    <!-- Description -->
    <div class="mb-3">
        <label>Description</label>
        <textarea name="description"
                  class="form-control"
                  required></textarea>
    </div>

    <button type="submit" class="btn btn-success">
        Save Offer
    </button>

    <a href="<%= request.getContextPath() %>/OfferServlet?action=list"
       class="btn btn-secondary">
        Back
    </a>

</form>

</body>
</html>