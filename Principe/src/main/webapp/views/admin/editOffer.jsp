<%@ page import="model.Offer" %>

<%
    if(session.getAttribute("admin") == null){
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    Offer offer = (Offer) request.getAttribute("offer");

    if(offer == null){
        response.sendRedirect(request.getContextPath() + "/OfferServlet?action=list");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Offer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="container mt-4">

<h2>Edit Offer</h2>

<form action="<%= request.getContextPath() %>/OfferServlet" method="post">

    <!-- Action -->
    <input type="hidden" name="action" value="update">

    <!-- Offer ID (Read Only) -->
    <div class="mb-3">
        <label>Offer ID</label>
        <input type="text"
               name="offerId"
               class="form-control"
               value="<%= offer.getOfferId() %>"
               readonly>
    </div>

    <!-- Offer Name -->
    <div class="mb-3">
        <label>Offer Name</label>
        <input type="text"
               name="offerName"
               class="form-control"
               value="<%= offer.getOfferName() %>"
               required>
    </div>

    <!-- Offer Rate (%) -->
    <div class="mb-3">
        <label>Offer Rate (%)</label>
        <input type="number"
               name="offerRate"
               class="form-control"
               min="1"
               max="100"
               value="<%= offer.getOfferRate() %>"
               required>
    </div>

    <!-- Description -->
    <div class="mb-3">
        <label>Description</label>
        <textarea name="description"
                  class="form-control"
                  required><%= offer.getDescription() %></textarea>
    </div>

    <button type="submit" class="btn btn-success">
        Update Offer
    </button>

    <a href="<%= request.getContextPath() %>/OfferServlet?action=list"
       class="btn btn-secondary">
        Cancel
    </a>

</form>

</body>
</html>