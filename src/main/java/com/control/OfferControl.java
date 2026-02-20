package com.control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.dao.OfferDAO;
import com.dao.AdDAO;
import com.dao.NotificationDAO;
import com.entity.Offer;
import com.entity.Notification;
import com.entity.SimpleAd;
import com.conn.DBConnect;

public class OfferControl {

    public boolean hasPendingOffer(Long adId, Long userId) {
        Connection conn = DBConnect.getConn();
        OfferDAO dao = new OfferDAO(conn);
        return dao.hasPendingOffer(adId, userId);
    }

    public List<Offer> getAcceptedOffers(Long userId) {
        List<Offer> acceptedOffers = new ArrayList<>();
        try {
            Connection conn = DBConnect.getConn();
            // Get offers sent by user that are ACCEPTED
            String sqlSent = "SELECT * FROM offers WHERE user_id = ? AND status = 'ACCEPTED' ORDER BY created_at DESC";
            PreparedStatement psSent = conn.prepareStatement(sqlSent);
            psSent.setLong(1, userId);
            ResultSet rsSent = psSent.executeQuery();
            while (rsSent.next()) {
                acceptedOffers.add(createOfferFromResultSet(rsSent));
            }

            // Get offers received by user (owner of ad) that are ACCEPTED
            String sqlReceived = "SELECT o.* FROM offers o JOIN ads a ON o.ad_id = a.id WHERE a.user_id = ? AND o.status = 'ACCEPTED' ORDER BY o.created_at DESC";
            PreparedStatement psReceived = conn.prepareStatement(sqlReceived);
            psReceived.setLong(1, userId);
            ResultSet rsReceived = psReceived.executeQuery();
            while (rsReceived.next()) {
                acceptedOffers.add(createOfferFromResultSet(rsReceived));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return acceptedOffers;
    }

    private Offer createOfferFromResultSet(ResultSet rs) throws java.sql.SQLException {
        Offer offer = new Offer();
        offer.setId(rs.getLong("id"));
        offer.setAdId(rs.getLong("ad_id"));
        offer.setUserId(rs.getLong("user_id"));
        offer.setType(rs.getString("type"));
        offer.setPrice(rs.getBigDecimal("price"));
        offer.setDescription(rs.getString("description"));
        offer.setStatus(rs.getString("status"));
        java.sql.Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            offer.setCreatedAt(createdAt.toLocalDateTime());
        }
        return offer;
    }

    public boolean createOffer(Offer offer) {
        Connection conn = DBConnect.getConn();
        OfferDAO dao = new OfferDAO(conn);
        return dao.createOffer(offer);
    }

    public Offer getOfferById(Long offerId) {
        Connection conn = DBConnect.getConn();
        OfferDAO dao = new OfferDAO(conn);
        return dao.getOfferById(offerId);
    }

    public List<Offer> getOffersByAdId(Long adId) {
        Connection conn = DBConnect.getConn();
        OfferDAO dao = new OfferDAO(conn);
        return dao.getOffersByAdId(adId);
    }

    public int countPendingOffers(Long adId) {
        int count = 0;
        try {
            Connection conn = DBConnect.getConn();
            String sql = "SELECT COUNT(*) FROM offers WHERE ad_id = ? AND status = 'PENDING'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, adId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean acceptOffer(Long offerId) {
        Connection conn = DBConnect.getConn();
        OfferDAO dao = new OfferDAO(conn);
        // This method in DAO handles transaction and notifications for acceptance
        return dao.acceptOfferAndCreateTransaction(offerId);
    }

    public boolean rejectOffer(Long offerId) {
        Connection conn = DBConnect.getConn();
        OfferDAO dao = new OfferDAO(conn);
        // This method in DAO handles notification for rejection
        return dao.rejectOffer(offerId);
    }

    public boolean withdrawOffer(Long offerId) {
        Connection conn = DBConnect.getConn();
        OfferDAO offerDAO = new OfferDAO(conn);

        // 1. Get offer details before updating
        Offer offer = offerDAO.getOfferById(offerId);
        if (offer == null)
            return false;

        // 2. Update status
        boolean success = offerDAO.updateOfferStatus(offerId, "WITHDRAWN");

        // 3. Notify owner
        if (success) {
            try {
                AdDAO adDAO = new AdDAO(conn);
                SimpleAd ad = adDAO.getAdById(offer.getAdId());
                if (ad != null) {
                    NotificationDAO notificationDAO = new NotificationDAO(conn);
                    Notification notification = new Notification();
                    notification.setUserId(ad.getUserId());
                    notification.setTitle("Offerta ritirata");
                    notification.setMessage("Un'offerta per il tuo annuncio '" + ad.getTitle() + "' è stata ritirata.");
                    notification.setLink("received_offers.jsp");
                    notification.setRead(false);

                    notificationDAO.create(notification);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return success;
    }

    public Long getAdOwnerId(Long adId) {
        Long ownerId = null;
        try {
            Connection conn = DBConnect.getConn();
            PreparedStatement ps = conn.prepareStatement("SELECT user_id FROM ads WHERE id = ?");
            ps.setLong(1, adId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ownerId = rs.getLong(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ownerId;
    }
}
