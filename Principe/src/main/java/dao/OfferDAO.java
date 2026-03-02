package dao;

import java.sql.*;
import java.util.*;
import model.Offer;
import util.DBConnection;

public class OfferDAO {

    // INSERT
    public boolean insert(Offer offer) {

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO offer(offer_id, offer_name, offer_rate, description) "
                       + "VALUES(?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, offer.getOfferId());
            ps.setString(2, offer.getOfferName());
            ps.setInt(3, offer.getOfferRate());
            ps.setString(4, offer.getDescription());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // UPDATE
    public boolean update(Offer offer) {

        try {
            Connection con = DBConnection.getConnection();

            String sql = "UPDATE offer SET offer_name=?, offer_rate=?, description=? "
                       + "WHERE offer_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, offer.getOfferName());
            ps.setInt(2, offer.getOfferRate());
            ps.setString(3, offer.getDescription());
            ps.setString(4, offer.getOfferId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // DELETE
    public boolean delete(String offerId) {

        try {
            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM offer WHERE offer_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, offerId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // GET BY ID
    public Offer getById(String offerId) {

        Offer offer = null;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM offer WHERE offer_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, offerId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                offer = new Offer();
                offer.setOfferId(rs.getString("offer_id"));
                offer.setOfferName(rs.getString("offer_name"));
                offer.setOfferRate(rs.getInt("offer_rate"));
                offer.setDescription(rs.getString("description"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return offer;
    }

    // GET ALL
    public List<Offer> getAll() {

        List<Offer> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM offer";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Offer offer = new Offer();
                offer.setOfferId(rs.getString("offer_id"));
                offer.setOfferName(rs.getString("offer_name"));
                offer.setOfferRate(rs.getInt("offer_rate"));
                offer.setDescription(rs.getString("description"));

                list.add(offer);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}