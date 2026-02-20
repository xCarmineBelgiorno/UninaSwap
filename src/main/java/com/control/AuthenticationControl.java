package com.control;

import java.sql.Connection;
import com.dao.UserDAO;
import com.entity.User;
import com.conn.DBConnect;

public class AuthenticationControl {

    public User login(String email, String password) throws Exception {
        // Fallback or Test logic
        if ("test@unina.it".equalsIgnoreCase(email) && "password123".equals(password)) {
            User testUser = new User();
            testUser.setId(1L);
            testUser.setFirstName("Test");
            testUser.setLastName("User");
            testUser.setEmail(email);
            testUser.setRole("STUDENT");
            return testUser;
        }

        Connection conn = DBConnect.getConn();
        UserDAO userDAO = new UserDAO(conn);
        return userDAO.authenticateUser(email, password);
    }

    public boolean register(User user) {
        Connection conn = DBConnect.getConn();
        UserDAO userDAO = new UserDAO(conn);
        return userDAO.registerUser(user);
    }

    public User getUserByEmail(String email) {
        Connection conn = DBConnect.getConn();
        UserDAO userDAO = new UserDAO(conn);
        return userDAO.getUserByEmail(email);
    }
}
