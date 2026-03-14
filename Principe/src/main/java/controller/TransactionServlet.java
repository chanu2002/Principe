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

                String message =
                        "Payment Successful!\n\n" +
                        "Transaction ID: " + transactionId + "\n" +
                        "Booking ID: " + bookingId + "\n" +
                        "Amount: " + amount + "\n\n" +
                        "Your booking is CONFIRMED.";

                EmailUtil.sendBill(
                        user.getEmail(),
                        "Booking Confirmation",
                        message
                );
                
                // Save details in session to pass to bill.jsp
                session.setAttribute("bookingDetail", booking);
                session.setAttribute("transactionId", transactionId);
                session.setAttribute("amountPaid", amount);

                response.sendRedirect(request.getContextPath() + "/views/UserPages/bill.jsp");
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