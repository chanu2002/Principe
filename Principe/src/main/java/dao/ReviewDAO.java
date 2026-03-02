package dao;

import java.sql.*;
import java.util.*;
import model.Review;
import util.DBConnection;

public class ReviewDAO {

    // INSERT
    public boolean insert(Review r) {

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO review(user_id, room_id, rating, comments, review_date) "
                       + "VALUES(?,?,?,?,NOW())";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, r.getUserId());
            ps.setString(2, r.getRoomId());
            ps.setInt(3, r.getRating());
            ps.setString(4, r.getComments());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // UPDATE (ONLY SAME USER)
    public boolean updateReview(Review r) {

        try {
            Connection con = DBConnection.getConnection();

            String sql = "UPDATE review SET rating=?, comments=? "
                       + "WHERE review_id=? AND user_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, r.getRating());
            ps.setString(2, r.getComments());
            ps.setInt(3, r.getReviewId());
            ps.setInt(4, r.getUserId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // DELETE (ONLY SAME USER)
    public boolean deleteReview(int reviewId, int userId) {

        try {
            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM review WHERE review_id=? AND user_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, reviewId);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // CHECK IF USER ALREADY REVIEWED
    public boolean hasUserReviewed(String roomId, int userId) {

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT COUNT(*) FROM review WHERE room_id=? AND user_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, roomId);
            ps.setInt(2, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // GET REVIEWS WITH CUSTOMER NAME
    public List<Review> getByRoom(String roomId) {

        List<Review> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql =
                "SELECT r.*, u.name AS customer_name "
              + "FROM review r "
              + "JOIN user u ON r.user_id = u.user_id "
              + "WHERE r.room_id=? "
              + "ORDER BY r.review_id DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, roomId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Review r = new Review();
                r.setReviewId(rs.getInt("review_id"));
                r.setUserId(rs.getInt("user_id"));
                r.setRoomId(rs.getString("room_id"));
                r.setRating(rs.getInt("rating"));
                r.setComments(rs.getString("comments"));
                r.setReviewDate(rs.getDate("review_date"));
                r.setCustomerName(rs.getString("customer_name"));

                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public List<Review> getAllReviews() {

        List<Review> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql =
                "SELECT r.*, u.name AS customer_name, rm.type AS room_type " +
                "FROM review r " +
                "JOIN user u ON r.user_id = u.user_id " +
                "JOIN room rm ON r.room_id = rm.room_id " +
                "ORDER BY r.review_id DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Review r = new Review();
                r.setReviewId(rs.getInt("review_id"));
                r.setUserId(rs.getInt("user_id"));
                r.setRoomId(rs.getString("room_id"));
                r.setRating(rs.getInt("rating"));
                r.setComments(rs.getString("comments"));
                r.setReviewDate(rs.getDate("review_date"));
                r.setCustomerName(rs.getString("customer_name"));

                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public boolean deleteReviewByAdmin(int reviewId) {

        try {
            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM review WHERE review_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, reviewId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}