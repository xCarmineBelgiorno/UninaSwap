package com.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Offer {
    private Long id;
    private Long adId;
    private Long userId;
    private String type; // SALE_BID, EXCHANGE_BID, GIFT_BID
    private BigDecimal price;
    private String description;
    private String status; // PENDING, ACCEPTED, REJECTED, WITHDRAWN
    private LocalDateTime createdAt;
    
    // Costruttori
    public Offer() {}
    
    public Offer(Long adId, Long userId, String type, String description) {
        this.adId = adId;
        this.userId = userId;
        this.type = type;
        this.description = description;
        this.status = "PENDING";
        this.createdAt = LocalDateTime.now();
    }
    
    // Getters e Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public Long getAdId() {
        return adId;
    }
    
    public void setAdId(Long adId) {
        this.adId = adId;
    }
    
    public Long getUserId() {
        return userId;
    }
    
    public void setUserId(Long userId) {
        this.userId = userId;
    }
    
    public String getType() {
        return type;
    }
    
    public void setType(String type) {
        this.type = type;
    }
    
    public BigDecimal getPrice() {
        return price;
    }
    
    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
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
    
    @Override
    public String toString() {
        return "Offer{" +
                "id=" + id +
                ", adId=" + adId +
                ", userId=" + userId +
                ", type='" + type + '\'' +
                ", price=" + price +
                ", description='" + description + '\'' +
                ", status='" + status + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}
