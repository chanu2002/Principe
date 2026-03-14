package model;

import java.math.BigDecimal;
import java.util.Date;

public class DailyIncome {
    private Date bookingDate;
    private BigDecimal income;

    public Date getBookingDate() {
        return bookingDate;
    }
    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }
    public BigDecimal getIncome() {
        return income;
    }
    public void setIncome(BigDecimal income) {
        this.income = income;
    }
}
