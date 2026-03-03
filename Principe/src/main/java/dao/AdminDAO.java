package dao;

import java.sql.*;
import java.util.*;
import model.Admin;
import util.DBConnection;

public class AdminDAO {
	
	 /*public Admin login(String username, String password) {
	        Admin admin = null;

	        try {
	            Connection con = DBConnection.getConnection();
	            String sql = "SELECT * FROM admin WHERE admin_username=? AND admin_password=?";
	            PreparedStatement ps = con.prepareStatement(sql);
	            ps.setString(1, username);
	            ps.setString(2, password);

	            ResultSet rs = ps.executeQuery();

	            if (rs.next()) {
	                admin = new Admin();
	                admin.setAdminId(rs.getString("admin_id"));
	                admin.setUsername(rs.getString("admin_username"));
	                admin.setName(rs.getString("admin_name"));
	                admin.setRole(rs.getString("admin_role"));
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return admin;
	    }*/
	
	public Admin login(String username, String password) {

	    Admin admin = null;

	    try {
	        Connection con = DBConnection.getConnection();

	        String sql = "SELECT * FROM admin WHERE admin_username=? AND admin_password=?";
	        PreparedStatement ps = con.prepareStatement(sql);

	        ps.setString(1, username);
	        ps.setString(2, password);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {

	            admin = new Admin();
	            admin.setAdminId(rs.getString("admin_id"));
	            admin.setUsername(rs.getString("admin_username"));
	            admin.setPassword(rs.getString("admin_password"));
	            admin.setName(rs.getString("admin_name"));
	            admin.setRole(rs.getString("admin_role"));
	            admin.setImage(rs.getBytes("admin_image")); // ✅ ADD THIS
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return admin;
	}
	 
	 public byte[] getImageById(String id) {

		    String sql = "SELECT admin_image FROM admin WHERE admin_id=?";
		    byte[] image = null;

		    try (Connection con = DBConnection.getConnection();
		         PreparedStatement ps = con.prepareStatement(sql)) {

		        ps.setString(1, id);
		        ResultSet rs = ps.executeQuery();

		        if (rs.next()) {
		            image = rs.getBytes("admin_image");
		        }

		    } catch (Exception e) {
		        e.printStackTrace();
		    }

		    return image;
		}
		

    // CREATE
    public boolean insert(Admin admin) {
        String sql = "INSERT INTO admin VALUES (?,?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, admin.getAdminId());
            ps.setString(2, admin.getUsername());
            ps.setString(3, admin.getPassword());
            ps.setString(4, admin.getName());
            ps.setString(5, admin.getRole());
            ps.setBytes(6, admin.getImage());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // READ ALL
    public List<Admin> getAll() {
        List<Admin> list = new ArrayList<>();

        String sql = "SELECT * FROM admin";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Admin a = new Admin();
                a.setAdminId(rs.getString("admin_id"));
                a.setUsername(rs.getString("admin_username"));
                a.setPassword(rs.getString("admin_password"));
                a.setName(rs.getString("admin_name"));
                a.setRole(rs.getString("admin_role"));
                list.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // UPDATE
    public boolean update(Admin admin) {

        String sql = "UPDATE admin SET "
                + "admin_username=?, "
                + "admin_password=?, "
                + "admin_name=?, "
                + "admin_role=?, "
                + "admin_image=? "
                + "WHERE admin_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, admin.getUsername());
            ps.setString(2, admin.getName());
            ps.setString(3, admin.getPassword());
            ps.setString(4, admin.getRole());
            if (admin.getImage() != null) {
                ps.setBytes(5, admin.getImage());
            } else {
                ps.setNull(5, java.sql.Types.BLOB);
            }

            ps.setString(6, admin.getAdminId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // DELETE
    public boolean delete(String adminId) {
        String sql = "DELETE FROM admin WHERE admin_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, adminId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}