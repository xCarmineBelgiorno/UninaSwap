package com.entity;

import java.time.LocalDateTime;

public class Review {
    private Long id;
    private Transaction transaction;
    private User reviewer;
    private User reviewee;
    private int rating;
    private String comment;
    private LocalDateTime createdAt;
    
    public Review() {
        this.createdAt = LocalDateTime.now();
    }
    
    public Review(Transaction transaction, User reviewer, User reviewee, int rating, String comment) {
        this();
        this.transaction = transaction;
        this.reviewer = reviewer;
        this.reviewee = reviewee;
        this.rating = rating;
        this.comment = comment;
    }
    
    // Validation method
    public boolean isValidRating() {
        return rating >= 1 && rating <= 5;
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public Transaction getTransaction() {
        return transaction;
    }
    
    public void setTransaction(Transaction transaction) {
        this.transaction = transaction;
    }
    
    public User getReviewer() {
        return reviewer;
    }
    
    public void setReviewer(User reviewer) {
        this.reviewer = reviewer;
    }
    
    public User getReviewee() {
        return reviewee;
    }
    
    public void setReviewee(User reviewee) {
        this.reviewee = reviewee;
    }
    
    public int getRating() {
        return rating;
    }
    
    public void setRating(int rating) {
        if (rating >= 1 && rating <= 5) {
            this.rating = rating;
        }
    }
    
    public String getComment() {
        return comment;
    }
    
    public void setComment(String comment) {
        this.comment = comment;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
