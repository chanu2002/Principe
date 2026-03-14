package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import dao.TransactionDAO;
import dao.BookingDAO;
import model.User;
import model.BookingDetail;
import util.EmailUtil;

public class TransactionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        try {

            String roomId = request.getParameter("roomId");
            String checkInStr = request.getParameter("checkIn");
            String checkOutStr = request.getParameter("checkOut");
            String guestsStr = request.getParameter("guests");
            String offerId = request.getParameter("offerId");
            String amountStr = request.getParameter("amount");

            if (roomId == null || amountStr == null) {
                response.sendRedirect(request.getContextPath() + "/views/error.jsp");
                return;
            }

            BigDecimal amount = new BigDecimal(amountStr);
            int guests = Integer.parseInt(guestsStr);

            LocalDate checkIn = LocalDate.parse(checkInStr);
            LocalDate checkOut = LocalDate.parse(checkOutStr);

            BookingDAO bookingDAO = new BookingDAO();

            BookingDetail booking = new BookingDetail();
            booking.setUserId(user.getUserId());
            booking.setRoomId(roomId);
            booking.setCheckinDate(Date.from(
                    checkIn.atStartOfDay(ZoneId.systemDefault()).toInstant()));
            booking.setCheckoutDate(Date.from(
                    checkOut.atStartOfDay(ZoneId.systemDefault()).toInstant()));
            booking.setNoOfGuests(guests);
            booking.setTotalAmount(amount);
            booking.setStatus("CONFIRMED");
            if (offerId == null || offerId.isBlank()) {
                booking.setOfferId(null);
            } else {
                booking.setOfferId(offerId);
            }

            int bookingId = bookingDAO.insertBooking(booking);

            if (bookingId <= 0) {
                response.sendRedirect(request.getContextPath() + "/views/error.jsp");
                return;
            }

            TransactionDAO transactionDAO = new TransactionDAO();
            String transactionId = "TXN" + System.currentTimeMillis();

            boolean transactionSuccess = transactionDAO.insertTransaction(
                    transactionId,
                    bookingId,
                    user.getUserId(),
                    amount
            );

            if (transactionSuccess) {

                String message = "<!DOCTYPE html>"
                        + "<html>"
                        + "<head>"
                        + "<meta charset='UTF-8'>"
                        + "<style>"
                        + "  body { font-family: 'Poppins', sans-serif; background-color: #f9f9f9; color: #333; }"
                        + "  .container { max-width: 600px; margin: auto; background: #fff; padding: 30px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }"
                        + "  h2 { color: #d4af37; }"
                        + "  table { width: 100%; border-collapse: collapse; margin-top: 20px; }"
                        + "  th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }"
                        + "  .footer { text-align: center; margin-top: 30px; font-size: 12px; color: #888; }"
                        + "  .footer img { max-width: 150px; margin-top: 10px; }"
                        + "</style>"
                        + "</head>"
                        + "<body>"
                        + "<div class='container'>"
                        + "<h2>Booking Confirmation</h2>"
                        + "<p>Dear " + user.getName() + ",</p>"
                        + "<p>Thank you for your booking at <b>Principe Grand Hotel</b>.</p>"
                        + "<table>"
                        + "  <tr><th>Transaction ID</th><td>" + transactionId + "</td></tr>"
                        + "  <tr><th>Booking ID</th><td>" + bookingId + "</td></tr>"
                        + "  <tr><th>Amount Paid</th><td>$" + amount + "</td></tr>"
                        + "</table>"
                        + "<p>Your booking is <b>CONFIRMED</b>.</p>"
                        + "<div class='footer'>"
                        + "  <p>Principe Grand Hotel</p>"
                        + "  <img src='https://your-hotel-image-url.com/footer-image.jpg' alt='Hotel Logo'>"
                        + "</div>"
                        + "</div>"
                        + "</body>"
                        + "</html>";

                EmailUtil.sendBill(
                        user.getEmail(),
                        "Booking Confirmation",
                        message,  // your HTML content
                        true      // set true for HTML
                );

                
                // Save details in session to pass to bill.jsp
                session.setAttribute("bookingDetail", booking);
                session.setAttribute("transactionId", transactionId);
                session.setAttribute("amountPaid", amount);

                response.sendRedirect(request.getContextPath() + "/views/UserPages/Bill.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/views/error.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath()
                    + "/views/error.jsp");
        }
    }
}