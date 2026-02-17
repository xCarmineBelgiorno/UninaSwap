package com.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class SaleBid {
    private Long id;
    private Long adId;
    private Long userId;
    private BigDecimal bidPrice;
    private String message;
    private String status; // PENDING, ACCEPTED, REJECTED, WITHDRAWN
    private LocalDateTime createdAt;
    
    // Costruttori
    public SaleBid() {}
    
    public SaleBid(Long adId, Long userId, BigDecimal bidPrice, String message) {
        this.adId = adId;
        this.userId = userId;
        this.bidPrice = bidPrice;
        this.message = message;
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
    
    public BigDecimal getBidPrice() {
        return bidPrice;
    }
    
    public void setBidPrice(BigDecimal bidPrice) {
        this.bidPrice = bidPrice;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String message) {
        this.message = message;
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
        return "SaleBid{" +
                "id=" + id +
                ", adId=" + adId +
                ", userId=" + userId +
                ", bidPrice=" + bidPrice +
                ", message='" + message + '\'' +
                ", status='" + status + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}
