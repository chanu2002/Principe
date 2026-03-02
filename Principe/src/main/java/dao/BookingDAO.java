package dao;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import model.BookingDetail;
import util.DBConnection;

public class BookingDAO {

    // INSERT BOOKING
    public int insertBooking(BookingDetail booking) {

        int bookingId = 0;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO booking_detail " +
                    "(user_id, room_id, booking_date, checkin_date, checkout_date, no_of_guests, total_amount, status) " +
                    "VALUES (?, ?, NOW(), ?, ?, ?, ?, ?)";

            PreparedStatement ps =
                    con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setInt(1, booking.getUserId());
            ps.setString(2, booking.getRoomId());
            ps.setDate(3, new java.sql.Date(booking.getCheckinDate().getTime()));
            ps.setDate(4, new java.sql.Date(booking.getCheckoutDate().getTime()));
            ps.setInt(5, booking.getNoOfGuests());
            ps.setBigDecimal(6, booking.getTotalAmount());
            ps.setString(7, booking.getStatus());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                bookingId = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return bookingId;
    }
 // UPDATE BOOKING STATUS
    public boolean updateStatus(int bookingId, String status) {

        boolean result = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "UPDATE booking_detail SET status=? WHERE booking_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, bookingId);

            result = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    
 
    
    public List<BookingDetail> getAllBookings() {

        List<BookingDetail> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM booking_detail ORDER BY booking_id DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                BookingDetail b = new BookingDetail();

                b.setBookingId(rs.getInt("booking_id"));
                b.setUserId(rs.getInt("user_id"));
                b.setRoomId(rs.getString("room_id"));
                b.setBookingDate(rs.getDate("booking_date"));
                b.setCheckinDate(rs.getDate("checkin_date"));
                b.setCheckoutDate(rs.getDate("checkout_date"));
                b.setNoOfGuests(rs.getInt("no_of_guests"));
                b.setTotalAmount(rs.getBigDecimal("total_amount"));
                b.setStatus(rs.getString("status"));

                list.add(b);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public boolean updateBooking(BookingDetail booking) {

        boolean result = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "UPDATE booking_detail SET " +
                    "checkin_date=?, checkout_date=?, " +
                    "no_of_guests=?, total_amount=?, status=? " +
                    "WHERE booking_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setDate(1, new java.sql.Date(booking.getCheckinDate().getTime()));
            ps.setDate(2, new java.sql.Date(booking.getCheckoutDate().getTime()));
            ps.setInt(3, booking.getNoOfGuests());
            ps.setBigDecimal(4, booking.getTotalAmount());
            ps.setString(5, booking.getStatus());
            ps.setInt(6, booking.getBookingId());

            result = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    
    public boolean deleteBooking(int bookingId) {

        boolean result = false;

        try {
            Connection con = DBConnection.getConnection();
            String sql = "DELETE FROM booking_detail WHERE booking_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, bookingId);

            result = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    
    public BookingDetail getBookingById(int bookingId) {

        BookingDetail booking = null;

        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM booking_detail WHERE booking_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, bookingId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                booking = new BookingDetail();

                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setRoomId(rs.getString("room_id"));
                booking.setBookingDate(rs.getDate("booking_date"));
                booking.setCheckinDate(rs.getDate("checkin_date"));
                booking.setCheckoutDate(rs.getDate("checkout_date"));
                booking.setNoOfGuests(rs.getInt("no_of_guests"));
                booking.setTotalAmount(rs.getBigDecimal("total_amount"));
                booking.setStatus(rs.getString("status"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return booking;
    }
    
    public boolean isRoomAvailable(String roomId, LocalDate checkIn, LocalDate checkOut) {

        boolean available = true;

        try {
            Connection con = DBConnection.getConnection();

            String sql =
                "SELECT COUNT(*) FROM booking_detail " +
                "WHERE room_id = ? " +
                "AND status IN ('PENDING','CONFIRMED') " +
                "AND checkin_date < ? " +
                "AND checkout_date > ?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, roomId);
            ps.setDate(2, java.sql.Date.valueOf(checkOut));   // FIXED
            ps.setDate(3, java.sql.Date.valueOf(checkIn));    // FIXED

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                available = rs.getInt(1) == 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return available;
    }
}

