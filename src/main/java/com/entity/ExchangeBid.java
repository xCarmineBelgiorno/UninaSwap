package com.entity;

import java.time.LocalDateTime;

public class ExchangeBid {
    private Long id;
    private Long adId;
    private Long userId;
    private String offeredItem;
    private String description;
    private String message;
    private String status; // PENDING, ACCEPTED, REJECTED, WITHDRAWN
    private LocalDateTime createdAt;
    
    // Costruttori
    public ExchangeBid() {}
    
    public ExchangeBid(Long adId, Long userId, String offeredItem, String description, String message) {
        this.adId = adId;
        this.userId = userId;
        this.offeredItem = offeredItem;
        this.description = description;
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
    
    public String getOfferedItem() {
        return offeredItem;
    }
    
    public void setOfferedItem(String offeredItem) {
        this.offeredItem = offeredItem;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
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
        return "ExchangeBid{" +
                "id=" + id +
                ", adId=" + adId +
                ", userId=" + userId +
                ", offeredItem='" + offeredItem + '\'' +
                ", description='" + description + '\'' +
                ", message='" + message + '\'' +
                ", status='" + status + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}
