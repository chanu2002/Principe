package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import dao.BookingDAO;
import dao.RoomDAO;
import model.BookingDetail;
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

BookingDAO bookingDAO = new BookingDAO();

boolean available =
      bookingDAO.isRoomAvailable(roomId, checkIn, checkOut);

if (!available) {
  response.sendRedirect(request.getContextPath()
          + "/views/error.jsp");
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
// CREATE BOOKING
// ==========================

BookingDetail booking = new BookingDetail();

booking.setUserId(user.getUserId());
booking.setRoomId(roomId);
booking.setCheckinDate(Date.from(
      checkIn.atStartOfDay(ZoneId.systemDefault()).toInstant()));
booking.setCheckoutDate(Date.from(
      checkOut.atStartOfDay(ZoneId.systemDefault()).toInstant()));
booking.setNoOfGuests(guests);
booking.setTotalAmount(totalAmount);
booking.setStatus("PENDING");
booking.setOfferId(offerId);

int bookingId = bookingDAO.insertBooking(booking);

if (bookingId > 0) {

  response.sendRedirect(request.getContextPath()
          + "/views/transaction.jsp?bookingId="
          + bookingId
          + "&amount="
          + totalAmount);
}

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

            // ==========================
            // CHECK ROOM AVAILABILITY
            // ==========================
            BookingDAO bookingDAO = new BookingDAO();

            boolean available = bookingDAO.isRoomAvailable(roomId, checkIn, checkOut);

            if (!available) {
                response.sendRedirect(request.getContextPath()
                        + "/views/error.jsp?msg=Room already booked for selected dates");
                return;
            }

            BigDecimal totalAmount =
                    room.getPrice().multiply(BigDecimal.valueOf(days));

            BookingDetail booking = new BookingDetail();
            booking.setUserId(user.getUserId());
            booking.setRoomId(roomId);
            booking.setCheckinDate(Date.from(
                    checkIn.atStartOfDay(ZoneId.systemDefault()).toInstant()));
            booking.setCheckoutDate(Date.from(
                    checkOut.atStartOfDay(ZoneId.systemDefault()).toInstant()));
            booking.setNoOfGuests(guests);
            booking.setTotalAmount(totalAmount);
            booking.setStatus("PENDING");

            int bookingId = bookingDAO.insertBooking(booking);

            if (bookingId > 0) {

                response.sendRedirect(request.getContextPath()
                        + "/views/transaction.jsp?bookingId="
                        + bookingId
                        + "&amount="
                        + totalAmount);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath()
                    + "/views/error.jsp");
        }
    }
}