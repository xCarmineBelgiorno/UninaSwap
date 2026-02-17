package com.entity;

public class GiftAd extends Ad {
    private String conditions;
    
    public GiftAd() {
        super();
        this.adType = "GIFT";
    }
    
    public GiftAd(User owner, String title, String description, Category category, 
                  String deliveryInfo, String conditions) {
        super(owner, title, description, category, "GIFT", deliveryInfo);
        this.conditions = conditions;
    }
    
    @Override
    public String getTypeSpecificInfo() {
        return "Condizioni: " + (conditions != null && !conditions.trim().isEmpty() ? conditions : "Nessuna condizione");
    }

    @Override
    public boolean isValid() {
        return super.isValid();
    }
    
    // Getters and Setters
    public String getConditions() {
        return conditions;
    }
    
    public void setConditions(String conditions) {
        this.conditions = conditions;
    }
}
