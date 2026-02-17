package com.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class SimpleAd extends Ad {
    private Long userId;
    private String type;
    private BigDecimal price;
    private String location;
    private String pickupTime;
    private String imageUrl;
    private List<String> imageUrls = new ArrayList<>();

    public SimpleAd() {
        super();
    }

    public SimpleAd(Long userId, String title, String description, String type,
            String category, BigDecimal price, String location, String pickupTime) {
        super();
        this.userId = userId;
        this.title = title;
        this.description = description;
        this.type = type;
        this.category = new Category();
        this.category.setName(category);
        this.price = price;
        this.location = location;
        this.pickupTime = pickupTime;
    }

    @Override
    public String getTypeSpecificInfo() {
        return "Type: " + type + ", Price: " + (price != null ? "€" + price : "N/A");
    }

    @Override
    public boolean isValid() {
        return super.isValid();
    }

    // Getters and Setters specifici
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

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getPickupTime() {
        return pickupTime;
    }

    public void setPickupTime(String pickupTime) {
        this.pickupTime = pickupTime;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public List<String> getImageUrls() {
        return imageUrls;
    }

    public void setImageUrls(List<String> imageUrls) {
        this.imageUrls = imageUrls;
    }

    public void addImageUrl(String url) {
        if (this.imageUrls == null) {
            this.imageUrls = new ArrayList<>();
        }
        this.imageUrls.add(url);
    }

    // Metodi per compatibilità con il database
    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return this.status;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getCreatedAt() {
        return this.createdAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public LocalDateTime getUpdatedAt() {
        return this.updatedAt;
    }
}
