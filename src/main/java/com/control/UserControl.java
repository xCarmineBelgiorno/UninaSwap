package com.control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.conn.DBConnect;
import com.dao.UserDAO;
import com.entity.User;

public class UserControl {

    public User getUserById(Long id) {
        Connection conn = DBConnect.getConn();
        UserDAO dao = new UserDAO(conn);
        return dao.getUserById(id);
    }

    public User getUserByEmail(String email) {
        Connection conn = DBConnect.getConn();
        UserDAO dao = new UserDAO(conn);
        return dao.getUserByEmail(email);
    }

    public boolean updateUser(User user) {
        Connection conn = DBConnect.getConn();
        UserDAO dao = new UserDAO(conn);
        return dao.updateUser(user);
    }

    public boolean changePassword(Long userId, String newPassword) {
        Connection conn = DBConnect.getConn();
        UserDAO dao = new UserDAO(conn);
        return dao.changePassword(userId, newPassword);
    }

    /**
     * Restituisce un array con [media_voti, numero_recensioni]
     */
    public double[] getUserRating(Long userId) {
        double[] stats = { 0.0, 0.0 };
        try {
            Connection conn = DBConnect.getConn();
            String sql = "SELECT COALESCE(AVG(rating), 0), COUNT(*) FROM reviews WHERE reviewed_user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                stats[0] = rs.getDouble(1); // Media
                stats[1] = rs.getInt(2); // Conteggio
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stats;
    }
}
