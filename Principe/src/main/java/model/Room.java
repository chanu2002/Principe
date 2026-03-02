package model;

import java.math.BigDecimal;

public class Room {

    private String roomId;
    private String type;
    private BigDecimal price;
    private String description;
    private String size;
    private int maxGuest;
    public int getMaxGuest() {
		return maxGuest;
	}

	public void setMaxGuest(int maxGuest) {
		this.maxGuest = maxGuest;
	}
	private String availability;

    public Room() {}

    public Room(String roomId, String type, BigDecimal price,
            String description, String size, int maxGuest, String availability) {
    this.roomId = roomId;
    this.type = type;
    this.price = price;
    this.description = description;
    this.size = size;
    this.maxGuest = maxGuest;
    this.availability = availability;
}

    public String getRoomId() { return roomId; }
    public void setRoomId(String roomId) { this.roomId = roomId; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getSize() { return size; }
    public void setSize(String size) { this.size = size; }

    public String getAvailability() { return availability; }
    public void setAvailability(String availability) { this.availability = availability; }
}