package com.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public abstract class Ad {
    protected Long id;
    protected User owner;
    protected Category category;
    protected String title;
    protected String description;
    protected String adType; // SALE, EXCHANGE, GIFT
    protected String deliveryInfo;
    protected String imageUrl;
    protected String status; // ACTIVE, SOLD, EXPIRED, DELETED
    protected LocalDateTime createdAt;
    protected LocalDateTime updatedAt;
    
    // Costruttore
    public Ad() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
        this.status = "ACTIVE";
    }

    // Costruttore parametrico per comodità delle sottoclassi
    public Ad(User owner, String title, String description, Category category, String adType, String deliveryInfo) {
        this();
        this.owner = owner;
        this.title = title;
        this.description = description;
        this.category = category;
        this.adType = adType;
        this.deliveryInfo = deliveryInfo;
    }
    
    // Metodi astratti/concreti
    public abstract String getTypeSpecificInfo();

    // Compat: forniamo un alias concreto a getTypeSpecificInfo
    public String getAdDetails() {
        return getTypeSpecificInfo();
    }

    // Validazione base (può essere sovrascritta)
    public boolean isValid() {
        return title != null && !title.trim().isEmpty() && adType != null && !adType.trim().isEmpty();
    }
    
    // Metodi concreti
    public void markAsSold() {
        this.status = "SOLD";
        this.updatedAt = LocalDateTime.now();
    }
    
    public void markAsExpired() {
        this.status = "EXPIRED";
        this.updatedAt = LocalDateTime.now();
    }
    
    public void markAsDeleted() {
        this.status = "DELETED";
        this.updatedAt = LocalDateTime.now();
    }
    
    public boolean isActive() {
        return "ACTIVE".equals(this.status);
    }
    
    public boolean canBeModified() {
        return "ACTIVE".equals(this.status);
    }
    
    // Getters e Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public User getOwner() {
        return owner;
    }
    
    public void setOwner(User owner) {
        this.owner = owner;
    }
    
    public Category getCategory() {
        return category;
    }
    
    public void setCategory(Category category) {
        this.category = category;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getAdType() {
        return adType;
    }
    
    public void setAdType(String adType) {
        this.adType = adType;
    }
    
    public String getDeliveryInfo() {
        return deliveryInfo;
    }
    
    public void setDeliveryInfo(String deliveryInfo) {
        this.deliveryInfo = deliveryInfo;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
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
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    @Override
    public String toString() {
        return "Ad{" +
                "id=" + id +
                ", owner=" + owner +
                ", category=" + category +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", adType='" + adType + '\'' +
                ", deliveryInfo='" + deliveryInfo + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                ", status='" + status + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
