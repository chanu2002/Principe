package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import dao.BookingDAO;
import dao.RoomDAO;
import model.BookingDetail;
import model.Room;

public class AdminBookingServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        BookingDAO dao = new BookingDAO();

        if (action == null || action.equals("list")) {

            List<BookingDetail> list = dao.getAllBookings();
            request.setAttribute("bookingList", list);
            request.getRequestDispatcher("/views/admin/handleBooking.jsp")
                   .forward(request, response);
        }

        else if (action.equals("delete")) {

            int id = Integer.parseInt(request.getParameter("id"));

            BookingDAO bookingDAO = new BookingDAO();
            RoomDAO roomDAO = new RoomDAO();

            // Get booking first
            BookingDetail booking = bookingDAO.getBookingById(id);

            if (booking != null) {

                // Get room
                Room room = roomDAO.getRoomById(booking.getRoomId());

                if (room != null) {

                    // If booking was confirmed → make room available
                    if ("CONFIRMED".equals(booking.getStatus()) ||
                        "PENDING".equals(booking.getStatus())) {

                        room.setAvailability("AVAILABLE");
                        roomDAO.update(room);
                    }
                }

                // Now delete booking
                bookingDAO.deleteBooking(id);
            }

            response.sendRedirect("AdminBookingServlet?action=list");
        }

        else if (action.equals("edit")) {

            int id = Integer.parseInt(request.getParameter("id"));
            BookingDetail booking = dao.getBookingById(id);

            request.setAttribute("booking", booking);
            request.getRequestDispatcher("/views/admin/editBooking.jsp")
                   .forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
throws ServletException, IOException {

try {

BookingDAO bookingDAO = new BookingDAO();
RoomDAO roomDAO = new RoomDAO();

int bookingId = Integer.parseInt(request.getParameter("bookingId"));
String checkInStr = request.getParameter("checkin");
String checkOutStr = request.getParameter("checkout");
int guests = Integer.parseInt(request.getParameter("guests"));
String status = request.getParameter("status");

// =========================
// Null Check
// =========================
if (checkInStr == null || checkOutStr == null) {
  response.sendRedirect("AdminBookingServlet?action=list");
  return;
}

// =========================
// Date Validation
// =========================
LocalDate checkIn = LocalDate.parse(checkInStr);
LocalDate checkOut = LocalDate.parse(checkOutStr);

if (checkIn.isBefore(LocalDate.now()) ||
  !checkOut.isAfter(checkIn)) {

  response.sendRedirect(
      "AdminBookingServlet?action=edit&id=" + bookingId);
  return;
}

// =========================
// Get Room
// =========================
BookingDetail existingBooking =
      bookingDAO.getBookingById(bookingId);

Room room = roomDAO.getRoomById(existingBooking.getRoomId());

// =========================
// Calculate Total
// =========================
long days =
  java.time.temporal.ChronoUnit.DAYS
      .between(checkIn, checkOut);

java.math.BigDecimal totalAmount =
  room.getPrice()
      .multiply(java.math.BigDecimal.valueOf(days));

// =========================
// Update Booking
// =========================
BookingDetail booking = new BookingDetail();
booking.setBookingId(bookingId);
booking.setCheckinDate(java.sql.Date.valueOf(checkIn));
booking.setCheckoutDate(java.sql.Date.valueOf(checkOut));
booking.setNoOfGuests(guests);
booking.setTotalAmount(totalAmount);
booking.setStatus(status);

bookingDAO.updateBooking(booking);

// =========================
// Update Room Availability
// =========================
if ("CONFIRMED".equals(status)) {
  room.setAvailability("NOT_AVAILABLE");
}
else if ("CANCELLED".equals(status)) {
  room.setAvailability("AVAILABLE");
}

roomDAO.update(room);

response.sendRedirect("AdminBookingServlet?action=list");

} catch (Exception e) {
e.printStackTrace();
response.sendRedirect("AdminBookingServlet?action=list");
}
}
}