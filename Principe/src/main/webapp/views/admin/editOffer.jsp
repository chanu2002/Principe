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

    <style>
        /* Full-page blurred background image */
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: url('https://images.unsplash.com/photo-1566073771259-6a8506099945') no-repeat center center fixed;
            background-size: cover;
            color: #fff;
            min-height: 100vh;
        }

        body::before {
            content: "";
            position: fixed;
            top:0; left:0; right:0; bottom:0;
            backdrop-filter: blur(12px) brightness(0.5);
            z-index: -1;
        }

        /* Back button top-left */
        .back-btn-top {
            position: fixed;
            top: 20px;
            left: 20px;
            background: rgba(212,175,55,0.85);
            color: #222;
            font-weight: 600;
            padding: 10px 20px;
            border-radius: 25px;
            text-decoration: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            transition: 0.3s;
            z-index: 1000;
        }

        .back-btn-top:hover {
            background: rgba(212,175,55,1);
            transform: translateY(-2px);
        }

        /* Glass effect container */
        .glass-card {
            max-width: 600px;
            margin: 80px auto 50px auto;
            background: rgba(255,255,255,0.08);
            border-radius: 20px;
            padding: 40px;
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255,255,255,0.2);
            box-shadow: 0 8px 32px rgba(0,0,0,0.25);
            color: #fff;
        }

        h2 {
            text-align: center;
            font-family: 'Playfair Display', serif;
            color: #d4af37;
            margin-bottom: 30px;
            text-shadow: 1px 1px 5px rgba(0,0,0,0.6);
        }

        label {
            font-weight: 600;
            color: #d4af37;
        }

        input, textarea, select {
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.3);
            border-radius: 12px;
            color: #fff;
        }

        input:focus, textarea:focus, select:focus {
            background: rgba(255,255,255,0.15);
            outline: none;
            box-shadow: 0 0 10px rgba(212,175,55,0.6);
        }

        ::placeholder {
            color: rgba(255,255,255,0.7);
        }

        .btn-success {
            background: rgba(212,175,55,0.85);
            border: none;
            width: 100%;
            margin-bottom: 10px;
        }

        .btn-success:hover {
            background: rgba(212,175,55,1);
        }

        .btn-secondary {
            background: rgba(50,50,50,0.6);
            border: none;
            color: #fff;
            width: 100%;
        }

        .btn-secondary:hover {
            background: rgba(50,50,50,0.8);
        }
    </style>
</head>

<body>

<!-- Top-left back button -->
<a href="<%= request.getContextPath() %>/OfferServlet?action=list" class="back-btn-top">&larr; Back</a>

<div class="glass-card">

    <h2>Edit Offer</h2>

    <form action="<%= request.getContextPath() %>/OfferServlet" method="post">

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
</div>

</body>
</html>
