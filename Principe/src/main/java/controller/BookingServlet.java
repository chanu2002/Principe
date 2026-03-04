package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import dao.BookingDAO;
import dao.RoomDAO;
import model.Room;
import model.User;

public class BookingServlet extends HttpServlet {

    // ==========================================
    // POST METHOD (Booking from booking page)
    // ==========================================
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
            String finalAmountStr = request.getParameter("finalAmount");
            String offerId = request.getParameter("offerId");

            if (roomId == null || checkInStr == null ||
                checkOutStr == null || guestsStr == null) {

                response.sendRedirect(request.getContextPath() + "/views/error.jsp");
                return;
            }

            int guests = Integer.parseInt(guestsStr);

            RoomDAO roomDAO = new RoomDAO();
            Room room = roomDAO.getRoomById(roomId);

            if (room == null) {
                response.sendRedirect(request.getContextPath() + "/views/error.jsp");
                return;
            }

            LocalDate checkIn = LocalDate.parse(checkInStr);
            LocalDate checkOut = LocalDate.parse(checkOutStr);

            long days = ChronoUnit.DAYS.between(checkIn, checkOut);

            if (days <= 0) {
                response.sendRedirect(request.getContextPath()
                        + "/views/booking.jsp?roomId=" + roomId);
                return;
            }

            // ==========================
            // CHECK ROOM AVAILABILITY
            // ==========================
            BookingDAO bookingDAO = new BookingDAO();
            boolean available =
                    bookingDAO.isRoomAvailable(roomId, checkIn, checkOut);

            if (!available) {
                response.sendRedirect(request.getContextPath()
                        + "/views/error.jsp?msg=Room already booked for selected dates");
                return;
            }

            // ==========================
            // CALCULATE TOTAL
            // ==========================
            BigDecimal totalAmount;

            if (finalAmountStr != null && !finalAmountStr.isEmpty()) {
                totalAmount = new BigDecimal(finalAmountStr);
            } else {
                totalAmount =
                        room.getPrice().multiply(BigDecimal.valueOf(days));
            }

            // ==========================
            // REDIRECT TO PAYMENT PAGE
            // ==========================
            response.sendRedirect(request.getContextPath()
                    + "/views/transaction.jsp?roomId="
                    + roomId
                    + "&checkIn="
                    + checkInStr
                    + "&checkOut="
                    + checkOutStr
                    + "&guests="
                    + guestsStr
                    + "&amount="
                    + totalAmount
                    + "&offerId="
                    + offerId);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath()
                    + "/views/error.jsp");
        }
    }

    // ==========================================
    // GET METHOD (Booking after room selection)
    // ==========================================
    protected void doGet(HttpServletRequest request,
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

            String checkInStr = (String) session.getAttribute("checkIn");
            String checkOutStr = (String) session.getAttribute("checkOut");
            String guestsStr = (String) session.getAttribute("guests");

            if (roomId == null || checkInStr == null ||
                checkOutStr == null || guestsStr == null) {

                response.sendRedirect(request.getContextPath() + "/views/error.jsp");
                return;
            }

            int guests = Integer.parseInt(guestsStr);

            RoomDAO roomDAO = new RoomDAO();
            Room room = roomDAO.getRoomById(roomId);

            if (room == null) {
                response.sendRedirect(request.getContextPath() + "/views/error.jsp");
                return;
            }

            LocalDate checkIn = LocalDate.parse(checkInStr);
            LocalDate checkOut = LocalDate.parse(checkOutStr);

            long days = ChronoUnit.DAYS.between(checkIn, checkOut);

            if (days <= 0) {
                response.sendRedirect(request.getContextPath() + "/views/error.jsp");
                return;
            }

            BookingDAO bookingDAO = new BookingDAO();
            boolean available = bookingDAO.isRoomAvailable(roomId, checkIn, checkOut);

            if (!available) {
                response.sendRedirect(request.getContextPath()
                        + "/views/error.jsp?msg=Room already booked for selected dates");
                return;
            }

            BigDecimal totalAmount =
                    room.getPrice().multiply(BigDecimal.valueOf(days));

            response.sendRedirect(request.getContextPath()
                    + "/views/transaction.jsp?roomId="
                    + roomId
                    + "&checkIn="
                    + checkInStr
                    + "&checkOut="
                    + checkOutStr
                    + "&guests="
                    + guestsStr
                    + "&amount="
                    + totalAmount
                    + "&offerId=");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath()
                    + "/views/error.jsp");
        }
    }
}