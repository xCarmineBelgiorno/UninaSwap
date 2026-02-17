package com.entity;

import java.time.LocalDateTime;

public class GiftBid {
    private Long id;
    private Long adId;
    private Long userId;
    private String motivation;
    private String message;
    private String status; // PENDING, ACCEPTED, REJECTED, WITHDRAWN
    private LocalDateTime createdAt;
    
    // Costruttori
    public GiftBid() {}
    
    public GiftBid(Long adId, Long userId, String motivation, String message) {
        this.adId = adId;
        this.userId = userId;
        this.motivation = motivation;
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
    
    public String getMotivation() {
        return motivation;
    }
    
    public void setMotivation(String motivation) {
        this.motivation = motivation;
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
        return "GiftBid{" +
                "id=" + id +
                ", adId=" + adId +
                ", userId=" + userId +
                ", motivation='" + motivation + '\'' +
                ", message='" + message + '\'' +
                ", status='" + status + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}
