package com.dao;

import com.entity.Offer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OfferDAO {
    private Connection conn;

    public OfferDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean hasPendingOffer(Long adId, Long userId) {
        try {
            String sql = "SELECT COUNT(*) FROM offers WHERE ad_id = ? AND user_id = ? AND status = 'PENDING'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, adId);
            ps.setLong(2, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Crea una nuova offerta
     */
    public boolean createOffer(Offer offer) {
        boolean success = false;
        try {
            String sql = "INSERT INTO offers (ad_id, user_id, type, price, description, status) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, offer.getAdId());
            ps.setLong(2, offer.getUserId());
            ps.setString(3, offer.getType());
            ps.setBigDecimal(4, offer.getPrice());
            ps.setString(5, offer.getDescription());
            ps.setString(6, offer.getStatus());

            int rowsAffected = ps.executeUpdate();
            success = rowsAffected > 0;

            if (success) {
                // Notifica all'owner dell'annuncio
                notifyOwnerNewOffer(offer.getAdId(), offer.getUserId());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    private void notifyOwnerNewOffer(Long adId, Long bidderId) {
        try {
            Long ownerId = null;
            String adTitle = null;
            PreparedStatement psAd = conn.prepareStatement("SELECT user_id, title FROM ads WHERE id = ?");
            psAd.setLong(1, adId);
            ResultSet rsAd = psAd.executeQuery();
            if (rsAd.next()) {
                ownerId = rsAd.getLong(1);
                adTitle = rsAd.getString(2);
            }
            if (ownerId == null)
                return;

            PreparedStatement psBidder = conn.prepareStatement("SELECT email FROM users WHERE id = ?");
            psBidder.setLong(1, bidderId);
            ResultSet rsBidder = psBidder.executeQuery();
            String bidderEmail = rsBidder.next() ? rsBidder.getString(1) : "Un utente";

            PreparedStatement psN = conn
                    .prepareStatement("INSERT INTO notifications (user_id, title, message, link) VALUES (?, ?, ?, ?)");
            psN.setLong(1, ownerId);
            psN.setString(2, "Nuova offerta ricevuta");
            psN.setString(3, "Hai ricevuto una nuova offerta da " + bidderEmail + " per: " + adTitle);
            psN.setString(4, "/received_offers.jsp");
            psN.executeUpdate();
        } catch (Exception ignore) {
        }
    }

    /**
     * Offerte per un annuncio specifico
     */
    public List<Offer> getOffersByAdId(Long adId) {
        List<Offer> offers = new ArrayList<>();
        try {
            String sql = "SELECT * FROM offers WHERE ad_id = ? ORDER BY created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, adId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                offers.add(createOfferFromResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return offers;
    }

    /**
     * Offerte inviate da un utente
     */
    public List<Offer> getOffersByUserId(Long userId) {
        List<Offer> offers = new ArrayList<>();
        try {
            String sql = "SELECT * FROM offers WHERE user_id = ? ORDER BY created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                offers.add(createOfferFromResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return offers;
    }

    /**
     * Offerte ricevute per i propri annunci (owner)
     */
    public List<Offer> getOffersReceivedByOwnerId(Long ownerUserId) {
        List<Offer> offers = new ArrayList<>();
        try {
            String sql = "SELECT o.* FROM offers o JOIN ads a ON o.ad_id = a.id WHERE a.user_id = ? ORDER BY o.created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, ownerUserId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                offers.add(createOfferFromResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return offers;
    }

    /**
     * Numero offerte pendenti ricevute per i propri annunci (badge)
     */
    public int countPendingOffersForOwner(Long ownerUserId) {
        try {
            String sql = "SELECT COUNT(*) FROM offers o JOIN ads a ON o.ad_id = a.id WHERE a.user_id = ? AND o.status = 'PENDING'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, ownerUserId);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Offerta per ID
     */
    public Offer getOfferById(Long id) {
        Offer offer = null;
        try {
            String sql = "SELECT * FROM offers WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                offer = createOfferFromResultSet(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return offer;
    }

    /**
     * Aggiorna status offerta
     */
    public boolean updateOfferStatus(Long offerId, String newStatus) {
        boolean success = false;
        try {
            String sql = "UPDATE offers SET status = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newStatus);
            ps.setLong(2, offerId);
            success = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    /**
     * Accetta un'offerta: accetta l'offerta, rifiuta le altre, aggiorna annuncio e
     * crea transazione.
     */
    public boolean acceptOfferAndCreateTransaction(Long offerId) {
        boolean success = false;
        try {
            conn.setAutoCommit(false);

            // Carica offerta
            Offer offer = getOfferById(offerId);
            if (offer == null) {
                conn.rollback();
                conn.setAutoCommit(true);
                return false;
            }
            Long adId = offer.getAdId();
            String adType = null;
            Long sellerId = null;
            PreparedStatement psAd = conn.prepareStatement("SELECT user_id, type, title FROM ads WHERE id = ?");
            psAd.setLong(1, adId);
            ResultSet rsAd = psAd.executeQuery();
            String adTitle = null;
            if (rsAd.next()) {
                sellerId = rsAd.getLong(1);
                adType = rsAd.getString(2);
                adTitle = rsAd.getString(3);
            } else {
                conn.rollback();
                conn.setAutoCommit(true);
                return false;
            }
            Long buyerId = offer.getUserId();

            // 1) ACCEPTED
            PreparedStatement ps1 = conn.prepareStatement("UPDATE offers SET status = 'ACCEPTED' WHERE id = ?");
            ps1.setLong(1, offerId);
            ps1.executeUpdate();

            // 2) REJECT OTHERS
            PreparedStatement ps2 = conn.prepareStatement(
                    "UPDATE offers SET status = 'REJECTED' WHERE ad_id = ? AND id <> ? AND status = 'PENDING'");
            ps2.setLong(1, adId);
            ps2.setLong(2, offerId);
            ps2.executeUpdate();

            // 3) UPDATE AD STATUS (annuncio chiuso per qualsiasi tipo)
            PreparedStatement ps3 = conn.prepareStatement("UPDATE ads SET status = 'SOLD' WHERE id = ?");
            ps3.setLong(1, adId);
            ps3.executeUpdate();

            // 4) CREATE TRANSACTION
            PreparedStatement ps4 = conn.prepareStatement(
                    "INSERT INTO transactions (ad_id, offer_id, buyer_id, seller_id, status, notes) VALUES (?, ?, ?, ?, 'COMPLETED', ?)");
            ps4.setLong(1, adId);
            ps4.setLong(2, offerId);
            ps4.setLong(3, buyerId);
            ps4.setLong(4, sellerId);
            ps4.setString(5, "Accettata automaticamente dal proprietario");
            ps4.executeUpdate();

            // 5) NOTIFY BIDDER (buyer)
            PreparedStatement psBuyer = conn
                    .prepareStatement("INSERT INTO notifications (user_id, title, message, link) VALUES (?, ?, ?, ?)");
            psBuyer.setLong(1, buyerId);
            psBuyer.setString(2, "La tua offerta è stata accettata");
            psBuyer.setString(3, "La tua offerta per '" + adTitle + "' è stata accettata. Lascia una recensione!");
            psBuyer.setString(4, "/create_review.jsp?adId=" + adId + "&offerId=" + offerId);
            psBuyer.executeUpdate();

            conn.commit();
            success = true;
        } catch (Exception e) {
            try {
                conn.rollback();
            } catch (Exception ignored) {
            }
            e.printStackTrace();
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (Exception ignored) {
            }
        }
        return success;
    }

    /**
     * Rifiuta un'offerta e notifica il bidder
     */
    public boolean rejectOffer(Long offerId) {
        boolean ok = updateOfferStatus(offerId, "REJECTED");
        if (ok) {
            try {
                Offer offer = getOfferById(offerId);
                if (offer != null) {
                    PreparedStatement psAd = conn.prepareStatement("SELECT title FROM ads WHERE id = ?");
                    psAd.setLong(1, offer.getAdId());
                    ResultSet rs = psAd.executeQuery();
                    String adTitle = rs.next() ? rs.getString(1) : "Annuncio";
                    PreparedStatement psN = conn.prepareStatement(
                            "INSERT INTO notifications (user_id, title, message, link) VALUES (?, ?, ?, ?)");
                    psN.setLong(1, offer.getUserId());
                    psN.setString(2, "La tua offerta è stata rifiutata");
                    psN.setString(3, "La tua offerta per '" + adTitle + "' è stata rifiutata.");
                    psN.setString(4, "/sent_offers.jsp");
                    psN.executeUpdate();
                }
            } catch (Exception ignore) {
            }
        }
        return ok;
    }

    /**
     * Mapper ResultSet -> Offer
     */
    private Offer createOfferFromResultSet(ResultSet rs) throws SQLException {
        Offer offer = new Offer();
        offer.setId(rs.getLong("id"));
        offer.setAdId(rs.getLong("ad_id"));
        offer.setUserId(rs.getLong("user_id"));
        offer.setType(rs.getString("type"));
        offer.setPrice(rs.getBigDecimal("price"));
        offer.setDescription(rs.getString("description"));
        offer.setStatus(rs.getString("status"));
        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            offer.setCreatedAt(createdAt.toLocalDateTime());
        }
        return offer;
    }
}
