package com.dao;

import com.entity.Notification;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {
    private final Connection conn;

    public NotificationDAO(Connection conn) { this.conn = conn; }

    public boolean create(Notification n) {
        try {
            String sql = "INSERT INTO notifications (user_id, title, message, link, is_read) VALUES (?, ?, ?, ?, false)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, n.getUserId());
            ps.setString(2, n.getTitle());
            ps.setString(3, n.getMessage());
            ps.setString(4, n.getLink());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Notification> getByUser(Long userId, boolean onlyUnread) {
        List<Notification> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM notifications WHERE user_id = ?" + (onlyUnread ? " AND is_read = false" : "") + " ORDER BY created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(map(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean markAsRead(Long id, Long userId) {
        try {
            String sql = "UPDATE notifications SET is_read = true WHERE id = ? AND user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, id);
            ps.setLong(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public int markAllAsRead(Long userId) {
        try {
            String sql = "UPDATE notifications SET is_read = true WHERE user_id = ? AND is_read = false";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, userId);
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    private Notification map(ResultSet rs) throws SQLException {
        Notification n = new Notification();
        n.setId(rs.getLong("id"));
        n.setUserId(rs.getLong("user_id"));
        n.setTitle(rs.getString("title"));
        n.setMessage(rs.getString("message"));
        n.setLink(rs.getString("link"));
        n.setRead(rs.getBoolean("is_read"));
        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) n.setCreatedAt(ts.toLocalDateTime());
        return n;
    }
}
