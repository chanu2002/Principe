<%@ page import="java.util.*" %>
<%@ page import="model.Offer" %>

<%
List<Offer> list =
    (List<Offer>) request.getAttribute("offerList");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Offers | Principe Grand</title>
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
            padding: 50px;
        }

        h2 {
            font-family: 'Playfair Display', serif;
            font-size: 38px;
            color: #d4af37;
            margin-bottom: 25px;
        }

        .top-buttons {
            margin-bottom: 30px;
        }

        .btn {
            padding: 8px 18px;
            border-radius: 25px;
            text-decoration: none;
            font-size: 14px;
            margin-right: 10px;
            transition: 0.3s;
            cursor: pointer;
        }

        .back-btn {
            background: transparent;
            border: 1px solid #d4af37;
            color: #d4af37;
        }

        .back-btn:hover {
            background: #d4af37;
            color: black;
        }

        .add-btn {
            background: #28a745;
            color: white;
            border: none;
        }

        .add-btn:hover {
            background: #218838;
        }

        .offer-card {
            background: rgba(255,255,255,0.07);
            backdrop-filter: blur(8px);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            transition: 0.3s;
            position: relative;
        }

        .offer-card:hover {
            transform: translateY(-5px);
            background: rgba(212,175,55,0.12);
        }

        .offer-name {
            font-size: 20px;
            font-weight: 600;
            color: #d4af37;
        }

        .discount-badge {
            position: absolute;
            top: 20px;
            right: 20px;
            background: crimson;
            padding: 8px 15px;
            border-radius: 25px;
            font-size: 14px;
            font-weight: bold;
        }

        .description {
            margin-top: 10px;
            font-size: 14px;
            color: #ddd;
        }

        .action-buttons {
            margin-top: 15px;
        }

        .edit-btn {
            background: #17a2b8;
            color: white;
            border: none;
        }

        .edit-btn:hover {
            background: #138496;
        }

        .delete-btn {
            background: #dc3545;
            color: white;
            border: none;
        }

        .delete-btn:hover {
            background: #b02a37;
        }

        .no-offer {
            font-size: 16px;
            color: #ccc;
        }

    </style>
</head>

<body>

<div class="container">

    <h2>Manage Offers</h2>

    <div class="top-buttons">
        <button class="btn back-btn"
            onclick="window.location.href='<%= request.getContextPath() %>/views/adminDashboard.jsp'">
            Back to Dashboard
        </button>

        <a href="<%= request.getContextPath() %>/views/admin/addOffer.jsp"
           class="btn add-btn">
          Add New Offer
        </a>
    </div>

    <hr style="border-color: rgba(255,255,255,0.2);">

    <%
    if(list != null && !list.isEmpty()){
        for(Offer o : list){
    %>

    <div class="offer-card">

        <div class="discount-badge">
            <%= o.getOfferRate() %>% OFF
        </div>

        <div class="offer-name">
            🎁 <%= o.getOfferName() %>
        </div>

        <div class="description">
            <%= o.getDescription() %>
        </div>

        <div class="action-buttons">

            <a href="<%= request.getContextPath() %>/OfferServlet?action=edit&offerId=<%= o.getOfferId() %>"
               class="btn edit-btn">
               Edit
            </a>

            <form action="<%= request.getContextPath() %>/OfferServlet"
                  method="post"
                  style="display:inline;">

                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="offerId" value="<%= o.getOfferId() %>">

                <button type="submit"
                        class="btn delete-btn"
                        onclick="return confirm('Delete this offer?')">
                    Delete
                </button>
            </form>

        </div>

    </div>

    <%
        }
    } else {
    %>

        <p class="no-offer">No offers available.</p>

    <%
    }
    %>

</div>

</body>
</html>