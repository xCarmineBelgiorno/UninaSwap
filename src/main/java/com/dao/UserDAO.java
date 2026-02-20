package com.dao;

import com.conn.DBConnect;
import com.entity.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private Connection conn;
    
    public UserDAO(Connection conn) {
        this.conn = conn;
    }
    
    // Register new user
    public boolean registerUser(User user) {
        boolean success = false;
        try {
            String sql = "INSERT INTO users (first_name, last_name, email, password, faculty, year, phone, role, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getFaculty());
            ps.setString(6, user.getYear());
            ps.setString(7, user.getPhone());
            ps.setString(8, user.getRole());
            
            int rowsAffected = ps.executeUpdate();
            success = rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }
    
    // Authenticate user (login)
    public User authenticateUser(String email, String password) {
        User user = null;
        try {
            System.out.println("=== AUTHENTICATE USER ===");
            System.out.println("Email ricevuta: " + email);
            System.out.println("Password ricevuta: " + password);
            
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            System.out.println("SQL query: " + sql);
            
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            
            System.out.println("Esecuzione query...");
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                System.out.println("Utente trovato nel database!");
                user = new User();
                user.setId(rs.getLong("id"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFaculty(rs.getString("faculty"));
                user.setYear(rs.getString("year"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                
                Timestamp createdAt = rs.getTimestamp("created_at");
                if (createdAt != null) {
                    user.setCreatedAt(createdAt.toLocalDateTime());
                }
                
                Timestamp updatedAt = rs.getTimestamp("updated_at");
                if (updatedAt != null) {
                    user.setUpdatedAt(updatedAt.toLocalDateTime());
                }
                
                System.out.println("Utente creato: " + user.getFirstName() + " " + user.getLastName());
            } else {
                System.out.println("Nessun utente trovato con queste credenziali");
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            System.out.println("ERRORE SQL durante autenticazione: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("ERRORE GENERICO durante autenticazione: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("Risultato finale: " + (user != null ? "UTENTE VALIDO" : "UTENTE NULL"));
        return user;
    }
    
    // Get user by ID
    public User getUserById(Long id) {
        User user = null;
        try {
            String sql = "SELECT * FROM users WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, id);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getLong("id"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFaculty(rs.getString("faculty"));
                user.setYear(rs.getString("year"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                
                Timestamp createdAt = rs.getTimestamp("created_at");
                if (createdAt != null) {
                    user.setCreatedAt(createdAt.toLocalDateTime());
                }
                
                Timestamp updatedAt = rs.getTimestamp("updated_at");
                if (updatedAt != null) {
                    user.setUpdatedAt(updatedAt.toLocalDateTime());
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
    
    // Get user by email
    public User getUserByEmail(String email) {
        User user = null;
        try {
            String sql = "SELECT * FROM users WHERE email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getLong("id"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFaculty(rs.getString("faculty"));
                user.setYear(rs.getString("year"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                
                Timestamp createdAt = rs.getTimestamp("created_at");
                if (createdAt != null) {
                    user.setCreatedAt(createdAt.toLocalDateTime());
                }
                
                Timestamp updatedAt = rs.getTimestamp("updated_at");
                if (updatedAt != null) {
                    user.setUpdatedAt(updatedAt.toLocalDateTime());
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
    
    // Update user
    public boolean updateUser(User user) {
        boolean success = false;
        try {
            String sql = "UPDATE users SET first_name = ?, last_name = ?, faculty = ?, year = ?, phone = ?, updated_at = NOW() WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getFaculty());
            ps.setString(4, user.getYear());
            ps.setString(5, user.getPhone());
            ps.setLong(6, user.getId());
            
            int rowsAffected = ps.executeUpdate();
            success = rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }
    
    // Change password
    public boolean changePassword(Long userId, String newPassword) {
        boolean success = false;
        try {
            String sql = "UPDATE users SET password = ?, updated_at = NOW() WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setLong(2, userId);
            
            int rowsAffected = ps.executeUpdate();
            success = rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }
    
    // Delete user
    public boolean deleteUser(Long id) {
        boolean success = false;
        try {
            String sql = "DELETE FROM users WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, id);
            
            int rowsAffected = ps.executeUpdate();
            success = rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }
    
    // Get all users
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try {
            String sql = "SELECT * FROM users ORDER BY created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getLong("id"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFaculty(rs.getString("faculty"));
                user.setYear(rs.getString("year"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                
                Timestamp createdAt = rs.getTimestamp("created_at");
                if (createdAt != null) {
                    user.setCreatedAt(createdAt.toLocalDateTime());
                }
                
                Timestamp updatedAt = rs.getTimestamp("updated_at");
                if (updatedAt != null) {
                    user.setUpdatedAt(updatedAt.toLocalDateTime());
                }
                
                users.add(user);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
}
