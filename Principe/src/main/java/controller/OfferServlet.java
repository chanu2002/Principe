package controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import dao.OfferDAO;
import model.Offer;

public class OfferServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        OfferDAO dao = new OfferDAO();

        try {

            if ("list".equals(action)) {

                request.setAttribute("offerList", dao.getAll());

                request.getRequestDispatcher(
                        "views/admin/manageOffers.jsp")
                        .forward(request, response);
            }

            else if ("edit".equals(action)) {

                String id = request.getParameter("offerId");

                request.setAttribute("offer", dao.getById(id));

                request.getRequestDispatcher(
                        "views/admin/editOffer.jsp")
                        .forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("views/admin/adminLogin.jsp");
            return;
        }

        String action = request.getParameter("action");
        OfferDAO dao = new OfferDAO();

        try {

            if ("add".equals(action)) {

                Offer offer = new Offer();
                offer.setOfferId(request.getParameter("offerId"));
                offer.setOfferName(request.getParameter("offerName"));
                offer.setOfferRate(
                        Integer.parseInt(request.getParameter("offerRate")));
                offer.setDescription(request.getParameter("description"));

                dao.insert(offer);
            }

            else if ("update".equals(action)) {

                Offer offer = new Offer();
                offer.setOfferId(request.getParameter("offerId"));
                offer.setOfferName(request.getParameter("offerName"));
                offer.setOfferRate(
                        Integer.parseInt(request.getParameter("offerRate")));
                offer.setDescription(request.getParameter("description"));

                dao.update(offer);
            }

            else if ("delete".equals(action)) {

                dao.delete(request.getParameter("offerId"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath()
                + "/OfferServlet?action=list");
    }
}