<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.entity.User" %>
        <%@ page import="java.time.format.DateTimeFormatter" %>
            <% User user=(User) session.getAttribute("user"); if (user==null) {
                response.sendRedirect("customerlogin.jsp"); return; } %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Dashboard - UninaSwap</title>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <link rel="stylesheet" href="Css/w3.css">
                    <link rel="stylesheet" href="Css/abc.css">
                    <style>
                        .dashboard {
                            max-width: 900px;
                            margin: 30px auto;
                            background: #fff;
                            padding: 20px;
                            border-radius: 8px;
                            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                        }

                        .card {
                            border: 1px solid #eee;
                            border-radius: 6px;
                            padding: 16px;
                            margin-bottom: 16px;
                        }

                        .actions a {
                            margin-right: 12px;
                            color: #667eea;
                            text-decoration: none;
                        }
                    </style>
                </head>

                <body style="background: #f5f7fb; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">

                    <div style="display: flex; min-height: 100vh;">

                        <!-- Sidebar Navigation -->
                        <div class="sidebar"
                            style="width: 280px; background: linear-gradient(180deg, #2c3e50 0%, #3498db 100%); color: white; padding: 20px; display: flex; flex-direction: column; box-shadow: 4px 0 15px rgba(0,0,0,0.1);">
                            <div style="margin-bottom: 40px; text-align: center;">
                                <h2 style="font-weight: 800; letter-spacing: 1px; margin:0;">UninaSwap</h2>
                                <p style="opacity: 0.7; font-size: 0.9em; margin-top: 5px;">Student Marketplace</p>
                            </div>

                            <nav class="nav-menu" style="flex-grow: 1;">
                                <a href="user_dashboard.jsp" class="nav-item active">
                                    <i class="fas fa-home"></i> Home Dashboard
                                </a>
                                <a href="view_ads.jsp" class="nav-item">
                                    <i class="fas fa-search"></i> Visualizza Annunci
                                </a>
                                <a href="create_ad.jsp" class="nav-item">
                                    <i class="fas fa-plus-circle"></i> Crea Annuncio
                                </a>
                                <a href="my_ads.jsp" class="nav-item">
                                    <i class="fas fa-layer-group"></i> Miei Annunci
                                </a>
                                <a href="received_offers.jsp" class="nav-item">
                                    <i class="fas fa-inbox"></i> Offerte Ricevute
                                </a>
                                <a href="sent_offers.jsp" class="nav-item">
                                    <i class="fas fa-paper-plane"></i> Offerte Inviate
                                </a>
                                <a href="notifications.jsp" class="nav-item">
                                    <i class="fas fa-bell"></i> Notifiche
                                </a>
                                <a href="user_profile.jsp?userId=<%=user.getId()%>" class="nav-item">
                                    <i class="fas fa-user"></i> Profilo
                                </a>
                            </nav>

                            <div
                                style="margin-top: auto; padding-top: 20px; border-top: 1px solid rgba(255,255,255,0.1);">
                                <div style="display: flex; align-items: center; margin-bottom: 15px;">
                                    <div
                                        style="background: rgba(255,255,255,0.2); width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin-right: 10px;">
                                        <span style="font-weight: bold; font-size: 1.2em;">
                                            <%= user.getFirstName().charAt(0) %>
                                        </span>
                                    </div>
                                    <div>
                                        <div style="font-weight: bold;">
                                            <%= user.getFirstName() %>
                                        </div>
                                        <div style="font-size: 0.8em; opacity: 0.7;">Studente</div>
                                    </div>
                                </div>
                                <a href="logout" class="nav-item logout" style="color: #ff6b6b;">
                                    <i class="fas fa-sign-out-alt"></i> Logout
                                </a>
                            </div>
                        </div>

                        <!-- Main Content -->
                        <div class="main-content" style="flex-grow: 1; padding: 40px; overflow-y: auto;">

                            <header style="margin-bottom: 40px;">
                                <h1 style="font-size: 2.5em; color: #2c3e50; margin-bottom: 10px;">Benvenuto, <%=
                                        user.getFirstName() %>! 👋</h1>
                                <p style="color: #7f8c8d; font-size: 1.1em;">Ecco cosa sta succedendo nel tuo
                                    marketplace universitario.</p>
                            </header>

                            <!-- Stats Grid -->
                            <div class="stats-grid"
                                style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 25px; margin-bottom: 40px;">

                                <a href="view_ads.jsp" class="stat-card" style="text-decoration: none;">
                                    <div class="icon-box" style="background: #e3f2fd; color: #3498db;">
                                        <i class="fas fa-shopping-bag"></i>
                                    </div>
                                    <div class="stat-info">
                                        <h3>Visualizza Annunci</h3>
                                        <p>Sfoglia tutti i prodotti disponibili</p>
                                    </div>
                                </a>

                                <a href="create_ad.jsp" class="stat-card" style="text-decoration: none;">
                                    <div class="icon-box" style="background: #e8f5e9; color: #2ecc71;">
                                        <i class="fas fa-plus"></i>
                                    </div>
                                    <div class="stat-info">
                                        <h3>Pubblica Annuncio</h3>
                                        <p>Vendi, scambia o regala oggetti</p>
                                    </div>
                                </a>

                                <a href="notifications.jsp" class="stat-card" style="text-decoration: none;">
                                    <div class="icon-box" style="background: #fff3e0; color: #f39c12;">
                                        <i class="fas fa-bell"></i>
                                    </div>
                                    <div class="stat-info">
                                        <h3>Notifiche</h3>
                                        <p>Controlla gli aggiornamenti recenti</p>
                                    </div>
                                </a>

                                <a href="received_offers.jsp" class="stat-card" style="text-decoration: none;">
                                    <div class="icon-box" style="background: #fce4ec; color: #e91e63;">
                                        <i class="fas fa-envelope-open-text"></i>
                                    </div>
                                    <div class="stat-info">
                                        <h3>Messaggi / Offerte</h3>
                                        <p>Gestisci le trattative in corso</p>
                                    </div>
                                </a>

                            </div>

                            <!-- Recent Activity Section (Example) -->
                            <div
                                style="background: white; padding: 30px; border-radius: 20px; box-shadow: 0 5px 20px rgba(0,0,0,0.05);">
                                <div
                                    style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                                    <h3 style="color: #2c3e50; margin: 0;">Attività Recenti</h3>
                                    <a href="notifications.jsp"
                                        style="color: #3498db; text-decoration: none; font-weight: 600;">Vedi tutto</a>
                                </div>

                                <div style="display: grid; gap: 15px;">
                                    <div
                                        style="padding: 15px; border-radius: 10px; background: #f8f9fa; display: flex; align-items: center; border-left: 4px solid #3498db;">
                                        <div style="margin-right: 15px; color: #3498db;"><i
                                                class="fas fa-info-circle fa-lg"></i></div>
                                        <div>
                                            <div style="font-weight: 600; color: #2c3e50;">Accesso effettuato</div>
                                            <div style="font-size: 0.85em; color: #7f8c8d;">Hai effettuato l'accesso
                                                alla piattaforma con successo.</div>
                                        </div>
                                    </div>
                                    <!-- More items can be populated dynamically -->
                                </div>
                            </div>

                        </div>
                    </div>

                    <style>
                        /* Dashboard Specific Styles */
                        .nav-item {
                            display: block;
                            padding: 12px 20px;
                            color: rgba(255, 255, 255, 0.8);
                            text-decoration: none;
                            border-radius: 10px;
                            margin-bottom: 8px;
                            transition: all 0.3s ease;
                            font-weight: 500;
                        }

                        .nav-item:hover,
                        .nav-item.active {
                            background: rgba(255, 255, 255, 0.15);
                            color: white;
                            transform: translateX(5px);
                        }

                        .nav-item i {
                            width: 25px;
                            text-align: center;
                            margin-right: 10px;
                        }

                        .stat-card {
                            background: white;
                            padding: 25px;
                            border-radius: 20px;
                            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
                            display: flex;
                            align-items: center;
                            transition: transform 0.3s ease, box-shadow 0.3s ease;
                            cursor: pointer;
                        }

                        .stat-card:hover {
                            transform: translateY(-5px);
                            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                        }

                        .icon-box {
                            width: 60px;
                            height: 60px;
                            border-radius: 15px;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            font-size: 1.5em;
                            margin-right: 20px;
                            flex-shrink: 0;
                        }

                        .stat-info h3 {
                            margin: 0 0 5px 0;
                            color: #2c3e50;
                            font-size: 1.1em;
                        }

                        .stat-info p {
                            margin: 0;
                            color: #7f8c8d;
                            font-size: 0.9em;
                        }

                        @media (max-width: 900px) {
                            .sidebar {
                                display: none !important;
                                /* Hide sidebar on mobile for now, or convert to hamburger menu */
                            }
                        }
                    </style>

                </html>