package model;

import java.math.BigDecimal;
import java.util.Date;

public class BookingDetail {

    public int getBookingId() {
		return bookingId;
	}
	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getRoomId() {
		return roomId;
	}
	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}
	public Date getBookingDate() {
		return bookingDate;
	}
	public void setBookingDate(Date bookingDate) {
		this.bookingDate = bookingDate;
	}
	public Date getCheckinDate() {
		return checkinDate;
	}
	public void setCheckinDate(Date checkinDate) {
		this.checkinDate = checkinDate;
	}
	public Date getCheckoutDate() {
		return checkoutDate;
	}
	public void setCheckoutDate(Date checkoutDate) {
		this.checkoutDate = checkoutDate;
	}
	
	public int getNoOfGuests() {
		return noOfGuests;
	}
	public void setNoOfGuests(int noOfGuests) {
		this.noOfGuests = noOfGuests;
	}
	public BigDecimal getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	private String offerId;

	public String getOfferId() {
	    return offerId;
	}

	public void setOfferId(String offerId) {
	    this.offerId = offerId;
	}
	private int bookingId;
    private int userId;
    private String roomId;
    private Date bookingDate;
    private Date checkinDate;
    private Date checkoutDate;
    private int noOfGuests;
    private BigDecimal totalAmount;
    private String status;

    // Getters and Setters
}