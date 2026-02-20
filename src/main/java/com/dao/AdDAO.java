package com.dao;

import com.conn.DBConnect;
import com.entity.SimpleAd;
import com.entity.User;
import com.entity.Category;
import java.sql.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class AdDAO {
    private Connection conn;

    public AdDAO(Connection conn) {
        this.conn = conn;
    }

    /**
     * Crea un nuovo annuncio
     */
    public boolean createAd(SimpleAd ad) {
        boolean success = false;
        try {
            // Prima ottieni l'ID della categoria dal nome
            int categoryId = getCategoryIdByName(ad.getCategory().getName());

            String sql = "INSERT INTO ads (user_id, title, description, type, category_id, price, location, pickup_time, image_url, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setLong(1, ad.getUserId());
            ps.setString(2, ad.getTitle());
            ps.setString(3, ad.getDescription());
            ps.setString(4, ad.getType());
            ps.setInt(5, categoryId);
            ps.setBigDecimal(6, ad.getPrice());
            ps.setString(7, ad.getLocation());
            ps.setString(8, ad.getPickupTime());

            // Per compatibilità, salviamo la prima immagine (o quella di default) anche
            // nella colonna image_url della tabella ads
            String mainImage = (ad.getImageUrls() != null && !ad.getImageUrls().isEmpty()) ? ad.getImageUrls().get(0)
                    : ad.getImageUrl();
            ps.setString(9, mainImage);
            ps.setString(10, "ACTIVE");

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    long adId = rs.getLong(1);
                    ad.setId(adId);

                    // Inserisci tutte le immagini nella tabella ad_images
                    if (ad.getImageUrls() != null && !ad.getImageUrls().isEmpty()) {
                        System.out.println("DEBUG: Inserting " + ad.getImageUrls().size()
                                + " images into ad_images for adId " + adId);
                        String imgSql = "INSERT INTO ad_images (ad_id, image_url) VALUES (?, ?)";
                        PreparedStatement imgPs = conn.prepareStatement(imgSql);
                        for (String url : ad.getImageUrls()) {
                            System.out.println("DEBUG: Prepare insert image: " + url);
                            imgPs.setLong(1, adId);
                            imgPs.setString(2, url);
                            imgPs.addBatch();
                        }
                        int[] results = imgPs.executeBatch();
                        System.out.println("DEBUG: Batch execution results: " + java.util.Arrays.toString(results));
                    } else {
                        System.out.println("DEBUG: No images to insert into ad_images");
                    }
                }
                success = true;
            } else {
                System.out.println("DEBUG: No rows affected in ads table insert");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    /**
     * Ottiene l'ID della categoria dal nome
     */
    private int getCategoryIdByName(String categoryName) throws SQLException {
        String sql = "SELECT id FROM categories WHERE name = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, categoryName);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt("id");
        }
        // Se non trova la categoria, restituisci 1 (Libri) come fallback
        return 1;
    }

    /**
     * Ottiene tutti gli annunci
     */
    public List<SimpleAd> getAllAds() {
        List<SimpleAd> ads = new ArrayList<>();
        try {
            String sql = "SELECT a.*, c.name as category_name FROM ads a LEFT JOIN categories c ON a.category_id = c.id ORDER BY a.created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SimpleAd ad = createAdFromResultSet(rs);
                ads.add(ad);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ads;
    }

    /**
     * Ottiene tutti gli annunci di un utente specifico
     */
    public List<SimpleAd> getAdsByUserId(Long userId) {
        List<SimpleAd> list = new ArrayList<>();
        try {
            String sql = "SELECT a.*, c.name as category_name FROM ads a LEFT JOIN categories c ON a.category_id = c.id WHERE a.user_id = ? ORDER BY a.created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, userId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SimpleAd ad = createAdFromResultSet(rs);
                list.add(ad);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Ottiene un annuncio per ID
     */
    public SimpleAd getAdById(Long id) {
        SimpleAd ad = null;
        try {
            String sql = "SELECT a.*, c.name as category_name FROM ads a LEFT JOIN categories c ON a.category_id = c.id WHERE a.id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ad = createAdFromResultSet(rs);
                // Carica le immagini aggiuntive
                ad.setImageUrls(getAdImages(ad.getId()));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ad;
    }

    /**
     * Aggiorna un annuncio
     */
    public boolean updateAd(SimpleAd ad) {
        boolean success = false;
        try {
            int categoryId = getCategoryIdByName(ad.getCategory().getName());

            String sql = "UPDATE ads SET title = ?, description = ?, type = ?, category_id = ?, price = ?, location = ?, pickup_time = ?, image_url = ?, status = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, ad.getTitle());
            ps.setString(2, ad.getDescription());
            ps.setString(3, ad.getType());
            ps.setInt(4, categoryId);
            ps.setBigDecimal(5, ad.getPrice());
            ps.setString(6, ad.getLocation());
            ps.setString(7, ad.getPickupTime());

            String mainImage = (ad.getImageUrls() != null && !ad.getImageUrls().isEmpty()) ? ad.getImageUrls().get(0)
                    : ad.getImageUrl();
            ps.setString(8, mainImage);
            ps.setString(9, ad.getStatus());
            ps.setLong(10, ad.getId());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                // Aggiorna le immagini: cancella e reinserisci (approccio semplice)
                if (ad.getImageUrls() != null && !ad.getImageUrls().isEmpty()) {
                    String deleteSql = "DELETE FROM ad_images WHERE ad_id = ?";
                    PreparedStatement delPs = conn.prepareStatement(deleteSql);
                    delPs.setLong(1, ad.getId());
                    delPs.executeUpdate();

                    String imgSql = "INSERT INTO ad_images (ad_id, image_url) VALUES (?, ?)";
                    PreparedStatement imgPs = conn.prepareStatement(imgSql);
                    for (String url : ad.getImageUrls()) {
                        imgPs.setLong(1, ad.getId());
                        imgPs.setString(2, url);
                        imgPs.addBatch();
                    }
                    imgPs.executeBatch();
                }
                success = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    private List<String> getAdImages(long adId) {
        List<String> images = new ArrayList<>();
        try {
            String sql = "SELECT image_url FROM ad_images WHERE ad_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, adId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                images.add(rs.getString("image_url"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return images;
    }

    /**
     * Elimina un annuncio
     */
    public boolean deleteAd(Long id) {
        boolean success = false;
        try {
            String sql = "DELETE FROM ads WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, id);

            int rowsAffected = ps.executeUpdate();
            success = rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    /**
     * Ottiene gli annunci per categoria
     */
    public List<SimpleAd> getAdsByCategory(String categoryName) {
        List<SimpleAd> ads = new ArrayList<>();
        try {
            String sql = "SELECT a.*, c.name as category_name FROM ads a LEFT JOIN categories c ON a.category_id = c.id WHERE c.name = ? AND a.status = 'ACTIVE' ORDER BY a.created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, categoryName);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SimpleAd ad = createAdFromResultSet(rs);
                ads.add(ad);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ads;
    }

    /**
     * Ottiene gli annunci per tipo
     */
    public List<SimpleAd> getAdsByType(String type) {
        List<SimpleAd> ads = new ArrayList<>();
        try {
            String sql = "SELECT a.*, c.name as category_name FROM ads a LEFT JOIN categories c ON a.category_id = c.id WHERE a.type = ? AND a.status = 'ACTIVE' ORDER BY a.created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, type);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SimpleAd ad = createAdFromResultSet(rs);
                ads.add(ad);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ads;
    }

    /**
     * Ottiene gli annunci filtrati per categoria, tipo e prezzo min/max
     */
    public List<SimpleAd> getAdsByFilters(String category, String type, BigDecimal minPrice, BigDecimal maxPrice) {
        List<SimpleAd> ads = new ArrayList<>();
        try {
            StringBuilder sql = new StringBuilder(
                    "SELECT a.*, c.name as category_name FROM ads a LEFT JOIN categories c ON a.category_id = c.id WHERE a.status = 'ACTIVE'");
            List<Object> params = new ArrayList<>();

            if (category != null && !category.trim().isEmpty()) {
                sql.append(" AND c.name = ?");
                params.add(category);
            }
            if (type != null && !type.trim().isEmpty()) {
                sql.append(" AND a.type = ?");
                params.add(type);
            }
            if (minPrice != null) {
                sql.append(" AND a.price >= ?");
                params.add(minPrice);
            }
            if (maxPrice != null) {
                sql.append(" AND a.price <= ?");
                params.add(maxPrice);
            }

            sql.append(" ORDER BY a.created_at DESC");

            PreparedStatement ps = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SimpleAd ad = createAdFromResultSet(rs);
                ads.add(ad);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ads;
    }

    /**
     * Crea un annuncio dal ResultSet
     */
    private SimpleAd createAdFromResultSet(ResultSet rs) throws SQLException {
        SimpleAd ad = new SimpleAd();
        ad.setId(rs.getLong("id"));
        ad.setUserId(rs.getLong("user_id"));
        ad.setTitle(rs.getString("title"));
        ad.setDescription(rs.getString("description"));
        ad.setType(rs.getString("type"));

        Category category = new Category();
        // Usa category_name se disponibile, altrimenti fallback su category
        String categoryName = rs.getString("category_name");
        if (categoryName == null) {
            categoryName = rs.getString("category");
        }
        category.setName(categoryName);
        ad.setCategory(category);

        ad.setPrice(rs.getBigDecimal("price"));
        ad.setLocation(rs.getString("location"));
        ad.setPickupTime(rs.getString("pickup_time"));
        ad.setImageUrl(rs.getString("image_url"));
        ad.setStatus(rs.getString("status"));

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            ad.setCreatedAt(createdAt.toLocalDateTime());
        }

        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            ad.setUpdatedAt(updatedAt.toLocalDateTime());
        }

        return ad;
    }
}
