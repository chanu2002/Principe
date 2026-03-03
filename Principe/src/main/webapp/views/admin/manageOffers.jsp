<%@ page import="java.util.*" %>
<%@ page import="model.Offer" %>

<%
List<Offer> list =
    (List<Offer>) request.getAttribute("offerList");
%>

<h2>Manage Offers</h2>
 <button type="button"
        onclick="window.location.href='<%= request.getContextPath() %>/views/adminDashboard.jsp'">
    ⬅ Back to Dashboard
</button>

<a href="<%= request.getContextPath() %>/views/admin/addOffer.jsp"
   class="btn btn-primary">
   Add New Offer
</a>

<hr>

<%
if(list != null){
    for(Offer o : list){
%>

<div>
    <b><%= o.getOfferName() %></b><br>
    Rate: <%= o.getOfferRate() %>%<br>
    Description: <%= o.getDescription() %><br>

    <a href="<%= request.getContextPath() %>/OfferServlet?action=edit&offerId=<%= o.getOfferId() %>">
        Edit
    </a>

    <form action="<%= request.getContextPath() %>/OfferServlet"
          method="post" style="display:inline;">

        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="offerId" value="<%= o.getOfferId() %>">

        <button type="submit">Delete</button>
    </form>

</div>

<hr>

<%
    }
}
%>