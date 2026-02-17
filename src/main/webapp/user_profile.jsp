<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.entity.User" %>
        <% User user=(User) session.getAttribute("user"); if (user==null) { response.sendRedirect("customerlogin.jsp");
            return; } %>

            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>Profilo Utente - UninaSwap</title>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="Css/w3.css">
                <link rel="stylesheet" href="Css/abc.css">
                <style>
                    .profile-container {
                        max-width: 800px;
                        margin: 40px auto;
                        padding: 0 20px;
                    }

                    .profile-card {
                        background: white;
                        border-radius: 15px;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                        overflow: hidden;
                    }

                    .profile-header {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        padding: 40px 20px;
                        text-align: center;
                        color: white;
                    }

                    .profile-avatar {
                        width: 120px;
                        height: 120px;
                        background: white;
                        border-radius: 50%;
                        margin: 0 auto 20px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 3em;
                        color: #667eea;
                        border: 4px solid rgba(255, 255, 255, 0.3);
                    }

                    .profile-name {
                        font-size: 1.8em;
                        font-weight: bold;
                        margin-bottom: 5px;
                    }

                    .profile-role {
                        font-size: 0.9em;
                        opacity: 0.9;
                        text-transform: uppercase;
                        letter-spacing: 1px;
                        background: rgba(255, 255, 255, 0.2);
                        padding: 5px 15px;
                        border-radius: 20px;
                        display: inline-block;
                    }

                    .profile-body {
                        padding: 40px;
                    }

                    .info-group {
                        margin-bottom: 25px;
                    }

                    .info-label {
                        color: #64748b;
                        font-size: 0.9em;
                        margin-bottom: 5px;
                        text-transform: uppercase;
                        font-weight: 600;
                        letter-spacing: 0.5px;
                    }

                    .info-value {
                        color: #1e293b;
                        font-size: 1.1em;
                        font-weight: 500;
                        border-bottom: 1px solid #e2e8f0;
                        padding-bottom: 10px;
                    }

                    .btn-edit {
                        background: #667eea;
                        color: white;
                        border: none;
                        padding: 12px 30px;
                        border-radius: 8px;
                        font-weight: bold;
                        cursor: pointer;
                        width: 100%;
                        transition: background 0.3s;
                        text-decoration: none;
                        display: inline-block;
                        text-align: center;
                    }

                    .btn-edit:hover {
                        background: #5a6fd8;
                    }

                    .grid-2 {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 20px;
                    }

                    @media (max-width: 600px) {
                        .grid-2 {
                            grid-template-columns: 1fr;
                        }
                    }
                </style>
            </head>

            <body style="background-color: #f8fafc;">

                <jsp:include page="navbar.jsp" />

                <div class="profile-container">
                    <div class="profile-card">
                        <div class="profile-header">
                            <div class="profile-avatar">
                                <%= user.getFirstName().substring(0, 1) %>
                                    <%= user.getLastName().substring(0, 1) %>
                            </div>
                            <div class="profile-name">
                                <%= user.getFullName() %>
                            </div>
                            <div class="profile-role">
                                <%= user.getRole() %>
                            </div>
                        </div>

                        <div class="profile-body">
                            <form action="update_profile" method="post">
                                <div class="grid-2">
                                    <div class="info-group">
                                        <div class="info-label">Nome</div>
                                        <div class="info-value">
                                            <%= user.getFirstName() %>
                                        </div>
                                    </div>
                                    <div class="info-group">
                                        <div class="info-label">Cognome</div>
                                        <div class="info-value">
                                            <%= user.getLastName() %>
                                        </div>
                                    </div>
                                </div>

                                <div class="info-group">
                                    <div class="info-label">Email Istituzionale</div>
                                    <div class="info-value">
                                        <%= user.getEmail() %>
                                    </div>
                                </div>

                                <div class="grid-2">
                                    <div class="info-group">
                                        <div class="info-label">Facoltà</div>
                                        <div class="info-value">
                                            <%= user.getFaculty() !=null ? user.getFaculty() : "-" %>
                                        </div>
                                    </div>
                                    <div class="info-group">
                                        <div class="info-label">Anno di Corso</div>
                                        <div class="info-value">
                                            <%= user.getYear() !=null ? user.getYear() : "-" %>
                                        </div>
                                    </div>
                                </div>

                                <div class="info-group">
                                    <div class="info-label">Telefono</div>
                                    <div class="info-value">
                                        <%= user.getPhone() !=null ? user.getPhone() : "-" %>
                                    </div>
                                </div>

                                <div style="margin-top: 20px;">
                                    <a href="edit_profile.jsp" class="btn-edit">
                                        <i class="fas fa-edit"></i> Modifica Profilo
                                    </a>
                                </div>

                                <div style="margin-top: 15px; text-align: center;">
                                    <a href="logout" style="color: #ef4444; text-decoration: none; font-weight: bold;">
                                        <i class="fas fa-sign-out-alt"></i> Logout
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </body>

            </html>