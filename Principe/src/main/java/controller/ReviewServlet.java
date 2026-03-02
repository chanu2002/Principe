package controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import dao.ReviewDAO;
import model.Review;
import model.User;

public class ReviewServlet extends HttpServlet {

    // ==========================
    // GET METHOD (FOR ADMIN)
    // ==========================
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("adminList".equals(action)) {

            HttpSession session = request.getSession(false);

            if (session == null || session.getAttribute("admin") == null) {
                response.sendRedirect(request.getContextPath()
                        + "/views/admin/adminLogin.jsp");
                return;
            }

            ReviewDAO dao = new ReviewDAO();
            List<Review> list = dao.getAllReviews();

            request.setAttribute("reviewList", list);

            request.getRequestDispatcher(
                    "/views/admin/manageReviews.jsp")
                    .forward(request, response);
        }
    }

    // ==========================
    // POST METHOD (USER + ADMIN)
    // ==========================
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        String action = request.getParameter("action");
        String roomId = request.getParameter("roomId");

        ReviewDAO dao = new ReviewDAO();

        try {

            // ================= USER ACTIONS =================

            if ("add".equals(action)) {

                User user = (User) session.getAttribute("user");

                if (user == null) {
                    response.sendRedirect(request.getContextPath()
                            + "/views/login.jsp");
                    return;
                }

                if (!dao.hasUserReviewed(roomId, user.getUserId())) {

                    Review r = new Review();
                    r.setUserId(user.getUserId());
                    r.setRoomId(roomId);
                    r.setRating(Integer.parseInt(
                            request.getParameter("rating")));
                    r.setComments(request.getParameter("comments"));
                    r.setReviewDate(new Date());

                    dao.insert(r);
                }

                response.sendRedirect(request.getContextPath()
                        + "/views/booking.jsp?roomId=" + roomId);
                return;
            }

            else if ("update".equals(action)) {

                User user = (User) session.getAttribute("user");

                if (user == null) {
                    response.sendRedirect(request.getContextPath()
                            + "/views/login.jsp");
                    return;
                }

                Review r = new Review();
                r.setReviewId(Integer.parseInt(
                        request.getParameter("reviewId")));
                r.setUserId(user.getUserId());
                r.setRating(Integer.parseInt(
                        request.getParameter("rating")));
                r.setComments(request.getParameter("comments"));

                dao.updateReview(r);

                response.sendRedirect(request.getContextPath()
                        + "/views/booking.jsp?roomId=" + roomId);
                return;
            }

            else if ("delete".equals(action)) {

                User user = (User) session.getAttribute("user");

                if (user == null) {
                    response.sendRedirect(request.getContextPath()
                            + "/views/login.jsp");
                    return;
                }

                int reviewId = Integer.parseInt(
                        request.getParameter("reviewId"));

                dao.deleteReview(reviewId, user.getUserId());

                response.sendRedirect(request.getContextPath()
                        + "/views/booking.jsp?roomId=" + roomId);
                return;
            }

            // ================= ADMIN DELETE =================

            else if ("adminDelete".equals(action)) {

                if (session == null ||
                    session.getAttribute("admin") == null) {

                    response.sendRedirect(request.getContextPath()
                            + "/views/admin/adminLogin.jsp");
                    return;
                }

                int reviewId = Integer.parseInt(
                        request.getParameter("reviewId"));

                dao.deleteReviewByAdmin(reviewId);

                response.sendRedirect(request.getContextPath()
                        + "/ReviewServlet?action=adminList");
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath()
                + "/views/booking.jsp?roomId=" + roomId);
    }
}