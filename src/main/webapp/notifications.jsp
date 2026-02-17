<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.entity.Notification" %>
            <%@ page import="com.entity.User" %>
                <%@ page import="com.dao.NotificationDAO" %>
                    <%@ page import="com.conn.DBConnect" %>

                        <% User user=(User) session.getAttribute("user"); if (user==null) {
                            response.sendRedirect("customerlogin.jsp"); return; } NotificationDAO dao=new
                            NotificationDAO(DBConnect.getConn()); List<Notification> list = dao.getByUser(user.getId(),
                            false);
                            %>

                            <!DOCTYPE html>
                            <html>

                            <head>
                                <meta charset="UTF-8">
                                <title>Notifiche - UninaSwap</title>
                                <link rel="stylesheet" href="Css/w3.css">
                                <link rel="stylesheet" href="Css/abc.css">
                                <style>
                                    .notification-container {
                                        max-width: 800px;
                                        margin: 30px auto;
                                        padding: 20px;
                                        background: white;
                                        border-radius: 15px;
                                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
                                    }

                                    .notification-header {
                                        display: flex;
                                        justify-content: space-between;
                                        align-items: center;
                                        margin-bottom: 25px;
                                        padding-bottom: 15px;
                                        border-bottom: 2px solid #f1f5f9;
                                    }

                                    .notification-item {
                                        padding: 15px;
                                        margin-bottom: 10px;
                                        border-radius: 10px;
                                        background: #f8fafc;
                                        border-left: 4px solid #667eea;
                                        transition: transform 0.2s ease;
                                    }

                                    .notification-item:hover {
                                        transform: translateX(5px);
                                        background: #f1f5f9;
                                    }

                                    .notification-item.unread {
                                        background: #e0f2fe;
                                        border-left-color: #0891b2;
                                        font-weight: 500;
                                    }

                                    .notification-time {
                                        font-size: 12px;
                                        color: #64748b;
                                        margin-top: 5px;
                                    }

                                    .notification-type {
                                        display: inline-block;
                                        padding: 3px 8px;
                                        border-radius: 12px;
                                        font-size: 11px;
                                        font-weight: bold;
                                        background: #e0e7ff;
                                        color: #4f46e5;
                                        margin-right: 8px;
                                    }

                                    .empty-state {
                                        text-align: center;
                                        padding: 50px 20px;
                                        color: #64748b;
                                    }

                                    .empty-state i {
                                        font-size: 4em;
                                        color: #cbd5e1;
                                        margin-bottom: 15px;
                                    }

                                    .btn-mark-read {
                                        padding: 5px 10px;
                                        background: #10b981;
                                        color: white;
                                        border: none;
                                        border-radius: 5px;
                                        font-size: 12px;
                                        cursor: pointer;
                                        float: right;
                                    }

                                    .btn-mark-read:hover {
                                        background: #059669;
                                    }
                                </style>
                            </head>

                            <body style="background: #f1f5f9; min-height: 100vh;">

                                <jsp:include page="navbar.jsp" />

                                <div class="notification-container">
                                    <div class="notification-header">
                                        <h2 style="margin: 0; color: #1e293b;">
                                            <i class="fas fa-bell" style="color: #667eea; margin-right: 10px;"></i>
                                            Le Tue Notifiche
                                        </h2>
                                        <span style="color: #64748b; font-size: 14px;">
                                            <%= list !=null ? list.size() : 0 %> notifiche
                                        </span>
                                    </div>

                                    <% if (list !=null && !list.isEmpty()) { for (Notification n : list) { boolean
                                        isUnread=n.isRead()==false; %>
                                        <div class="notification-item <%= isUnread ? " unread" : "" %>">
                                            <div>
                                                <span class="notification-type">
                                                    Informazione
                                                </span>
                                                <%= n.getMessage() !=null ? n.getMessage() : "" %>

                                                    <div class="notification-time">
                                                        <i class="far fa-clock"></i>
                                                        <% if (n.getCreatedAt() !=null) { out.print(n.getCreatedAt()); }
                                                            %>
                                                    </div>
                                            </div>

                                        </div>
                                        <% } } else { %>
                                            <div class="empty-state">
                                                <i class="far fa-bell-slash"></i>
                                                <h3>Nessuna notifica</h3>
                                                <p>Non hai ancora ricevuto notifiche.</p>
                                            </div>
                                            <% } %>
                                </div>

                                <script>
                                    // Auto-refresh ogni 30 secondi per nuove notifiche
                                    setTimeout(function () {
                                        location.reload();
                                    }, 30000);
                                </script>

                            </body>

                            </html>