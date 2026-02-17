package com.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Transaction {
    private Long id;
    private Ad ad;
    private Offer offer;
    private BigDecimal finalPrice;
    private String status; // PENDING_DELIVERY, DELIVERED, CLOSED
    private LocalDateTime createdAt;
    private LocalDateTime closedAt;
    
    public Transaction() {
        this.status = "PENDING_DELIVERY";
        this.createdAt = LocalDateTime.now();
    }
    
    public Transaction(Ad ad, Offer offer) {
        this();
        this.ad = ad;
        this.offer = offer;
        // Set final price based on offer type if sale
        if (offer != null && "SALE_BID".equals(offer.getType())) {
            this.finalPrice = offer.getPrice();
        }
    }
    
    // Utility methods
    public void markDelivered() {
        if ("PENDING_DELIVERY".equals(this.status)) {
            this.status = "DELIVERED";
            this.updatedAt();
        }
    }
    
    public void closeTransaction() {
        if ("DELIVERED".equals(this.status)) {
            this.status = "CLOSED";
            this.closedAt = LocalDateTime.now();
        }
    }
    
    private void updatedAt() {
        // Helper method for updating timestamp
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public Ad getAd() {
        return ad;
    }
    
    public void setAd(Ad ad) {
        this.ad = ad;
    }
    
    public Offer getOffer() {
        return offer;
    }
    
    public void setOffer(Offer offer) {
        this.offer = offer;
    }
    
    public BigDecimal getFinalPrice() {
        return finalPrice;
    }
    
    public void setFinalPrice(BigDecimal finalPrice) {
        this.finalPrice = finalPrice;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getClosedAt() {
        return closedAt;
    }
    
    public void setClosedAt(LocalDateTime closedAt) {
        this.closedAt = closedAt;
    }
}
