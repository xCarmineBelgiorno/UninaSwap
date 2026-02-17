package com.entity;

public class ExchangeAd extends Ad {
    private String requestedItemDescription;
    
    public ExchangeAd() {
        super();
        this.adType = "EXCHANGE";
    }
    
    public ExchangeAd(User owner, String title, String description, Category category, 
                     String deliveryInfo, String requestedItemDescription) {
        super(owner, title, description, category, "EXCHANGE", deliveryInfo);
        this.requestedItemDescription = requestedItemDescription;
    }
    
    @Override
    public String getTypeSpecificInfo() {
        return "Richiede in cambio: " + (requestedItemDescription != null ? requestedItemDescription : "N/A");
    }

    @Override
    public boolean isValid() {
        return super.isValid() && requestedItemDescription != null && !requestedItemDescription.trim().isEmpty();
    }
    
    // Getters and Setters
    public String getRequestedItemDescription() {
        return requestedItemDescription;
    }
    
    public void setRequestedItemDescription(String requestedItemDescription) {
        this.requestedItemDescription = requestedItemDescription;
    }
}
