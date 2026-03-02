package model;

public class Offer {

    private String offerId;
    private String offerName;
    private int offerRate; // percentage
    private String description;

    public String getOfferId() {
        return offerId;
    }

    public void setOfferId(String offerId) {
        this.offerId = offerId;
    }

    public String getOfferName() {
        return offerName;
    }

    public void setOfferName(String offerName) {
        this.offerName = offerName;
    }

    public int getOfferRate() {
        return offerRate;
    }

    public void setOfferRate(int offerRate) {
        this.offerRate = offerRate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}