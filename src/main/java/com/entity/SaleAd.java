package com.entity;

import java.math.BigDecimal;

public class SaleAd extends Ad {
    private BigDecimal price;
    private String currency;
    
    public SaleAd() {
        super();
        this.adType = "SALE";
        this.currency = "EUR";
    }
    
    public SaleAd(User owner, String title, String description, Category category, 
                  String deliveryInfo, BigDecimal price) {
        super(owner, title, description, category, "SALE", deliveryInfo);
        this.price = price;
        this.currency = "EUR";
    }
    
    @Override
    public String getTypeSpecificInfo() {
        return "Prezzo: €" + (price != null ? price.toString() : "N/A");
    }

    @Override
    public boolean isValid() {
        return super.isValid() && price != null && price.signum() >= 0;
    }
    
    // Getters and Setters
    public BigDecimal getPrice() {
        return price;
    }
    
    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    
    public String getCurrency() {
        return currency;
    }
    
    public void setCurrency(String currency) {
        this.currency = currency;
    }
}
