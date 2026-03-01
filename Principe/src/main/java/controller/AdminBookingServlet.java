package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import dao.BookingDAO;
import model.BookingDetail;

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
            dao.deleteBooking(id);
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

        BookingDAO dao = new BookingDAO();

        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String checkInStr = request.getParameter("checkIn");
        String checkOutStr = request.getParameter("checkOut");
        int guests = Integer.parseInt(request.getParameter("guests"));
        String status = request.getParameter("status");

        LocalDate checkIn = LocalDate.parse(checkInStr);
        LocalDate checkOut = LocalDate.parse(checkOutStr);

        BookingDetail booking = new BookingDetail();
        booking.setBookingId(bookingId);
        booking.setCheckinDate(Date.from(checkIn.atStartOfDay(ZoneId.systemDefault()).toInstant()));
        booking.setCheckoutDate(Date.from(checkOut.atStartOfDay(ZoneId.systemDefault()).toInstant()));
        booking.setNoOfGuests(guests);
        booking.setStatus(status);

        dao.updateBooking(booking);

        response.sendRedirect("AdminBookingServlet?action=list");
    }
}