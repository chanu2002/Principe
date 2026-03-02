package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Room;
import util.DBConnection;

public class RoomDAO {

    // INSERT
    public boolean insert(Room room) {

        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO room (room_id, type, price, description, size, max_guest, availability) VALUES (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, room.getRoomId());
            ps.setString(2, room.getType());
            ps.setBigDecimal(3, room.getPrice());
            ps.setString(4, room.getDescription());
            ps.setString(5, room.getSize());
            ps.setInt(6, room.getMaxGuest());
            ps.setString(7, room.getAvailability());

            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // GET ALL
    public List<Room> getAllRooms() {

        List<Room> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM room";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Room room = new Room();
                room.setRoomId(rs.getString("room_id"));
                room.setType(rs.getString("type"));
                room.setPrice(rs.getBigDecimal("price"));
                room.setDescription(rs.getString("description"));
                room.setSize(rs.getString("size"));
                room.setMaxGuest(rs.getInt("max_guest"));
                room.setAvailability(rs.getString("availability"));

                list.add(room);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // GET BY ID
    public Room getRoomById(String id) {

        Room room = null;

        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM room WHERE room_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                room = new Room();
                room.setRoomId(rs.getString("room_id"));
                room.setType(rs.getString("type"));
                room.setPrice(rs.getBigDecimal("price"));
                room.setDescription(rs.getString("description"));
                room.setSize(rs.getString("size"));
                room.setMaxGuest(rs.getInt("max_guest"));
                room.setAvailability(rs.getString("availability"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return room;
    }

    // UPDATE
    public boolean update(Room room) {

        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "UPDATE room SET type=?, price=?, description=?, size=?, max_guest=?, availability=? WHERE room_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, room.getType());
            ps.setBigDecimal(2, room.getPrice());
            ps.setString(3, room.getDescription());
            ps.setString(4, room.getSize());
            ps.setInt(5, room.getMaxGuest());
            ps.setString(6, room.getAvailability());
            ps.setString(7, room.getRoomId());

            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // DELETE
    public boolean delete(String id) {

        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();
            String sql = "DELETE FROM room WHERE room_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, id);

            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    
    public List<String> getFacilitiesByRoom(String roomId) {

        List<String> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql =
            "SELECT f.facility_name " +
            "FROM facility f " +
            "JOIN room_facility rf ON f.facility_id = rf.facility_id " +
            "WHERE rf.room_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, roomId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(rs.getString("facility_name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public boolean updateAvailability(String roomId, String status) {

        boolean result = false;

        try {
            Connection con = DBConnection.getConnection();
            String sql = "UPDATE room SET availability=? WHERE room_id=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, status);
            ps.setString(2, roomId);

            result = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    
    /*public List<Room> getAvailableRooms(String checkIn,
            String checkOut,
            int guests) {

List<Room> list = new ArrayList<>();

try {
Connection con = DBConnection.getConnection();

String sql =
"SELECT * FROM room r " +
"WHERE r.max_guest >= ? " +
"AND r.room_id NOT IN ( " +
"   SELECT b.room_id FROM booking_detail b " +
"   WHERE ( ? < b.checkout_date AND ? > b.checkin_date ) " +
")";

PreparedStatement ps = con.prepareStatement(sql);

ps.setInt(1, guests);
ps.setDate(2, Date.valueOf(checkIn));
ps.setDate(3, Date.valueOf(checkOut));

ResultSet rs = ps.executeQuery();

while (rs.next()) {
Room room = new Room();
room.setRoomId(rs.getString("room_id"));
room.setType(rs.getString("type"));
room.setPrice(rs.getBigDecimal("price"));
room.setDescription(rs.getString("description"));
room.setSize(rs.getString("size"));
room.setMaxGuest(rs.getInt("max_guest"));
room.setAvailability(rs.getString("availability"));
list.add(room);
}

} catch (Exception e) {
e.printStackTrace();
}

return list;
}*/
    
    public List<Room> getAvailableRooms(String checkIn,
            String checkOut,
            Integer guests) {

List<Room> list = new ArrayList<>();

try {
Connection con = DBConnection.getConnection();

String sql =
"SELECT * FROM room r " +
"WHERE r.availability = 'AVAILABLE' " +   // NEW FILTER
"AND (? IS NULL OR r.max_guest >= ?) " +
"AND NOT EXISTS ( " +
"   SELECT 1 FROM booking_detail b " +
"   WHERE b.room_id = r.room_id " +
"   AND b.status IN ('PENDING','CONFIRMED') " +
"   AND b.checkin_date < ? " +
"   AND b.checkout_date > ? " +
")";

PreparedStatement ps = con.prepareStatement(sql);

if (guests == null) {
ps.setNull(1, java.sql.Types.INTEGER);
ps.setNull(2, java.sql.Types.INTEGER);
} else {
ps.setInt(1, guests);
ps.setInt(2, guests);
}

ps.setDate(3, java.sql.Date.valueOf(checkOut));
ps.setDate(4, java.sql.Date.valueOf(checkIn));

ResultSet rs = ps.executeQuery();

while (rs.next()) {

Room room = new Room();
room.setRoomId(rs.getString("room_id"));
room.setType(rs.getString("type"));
room.setPrice(rs.getBigDecimal("price"));
room.setDescription(rs.getString("description"));
room.setSize(rs.getString("size"));
room.setMaxGuest(rs.getInt("max_guest"));
room.setAvailability(rs.getString("availability"));

list.add(room);
}

} catch (Exception e) {
e.printStackTrace();
}

return list;
}
}