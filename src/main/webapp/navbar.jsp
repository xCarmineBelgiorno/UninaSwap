<%@ page import="com.entity.User" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <% User navUser=(User) session.getAttribute("user"); boolean navLoggedIn=(navUser !=null); %>
        <style>
            /* Renamed class to avoid conflict with Bootstrap .navbar */
            .unina-navbar {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                padding: 15px 0;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                width: 100%;
                margin-bottom: 30px;
                display: block;
                /* Ensure it's block-level */
            }

            /* Reset Bootstrap conflicts if any */
            .unina-navbar * {
                box-sizing: border-box;
            }

            .unina-nav-container {
                max-width: 1200px;
                margin: 0 auto;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0 20px;
                flex-direction: row;
                /* Force row */
            }

            .unina-brand {
                color: white !important;
                font-size: 1.8em;
                font-weight: bold;
                text-decoration: none;
                white-space: nowrap;
            }

            .unina-brand:hover {
                color: #f0f0f0 !important;
            }

            .unina-nav-links {
                display: flex;
                list-style: none;
                margin: 0;
                padding: 0;
                gap: 15px;
                flex-direction: row;
                /* Force row */
                align-items: center;
            }

            .unina-nav-links a {
                color: white !important;
                text-decoration: none;
                padding: 8px 12px;
                border-radius: 5px;
                transition: all 0.3s ease;
                font-size: 15px;
                display: flex;
                align-items: center;
                gap: 5px;
                white-space: nowrap;
            }

            .unina-nav-links a:hover {
                background: rgba(255, 255, 255, 0.15);
                transform: translateY(-2px);
            }

            .unina-btn-primary {
                background: #ff6b6b;
                color: white !important;
                padding: 8px 18px !important;
                border-radius: 25px;
                font-weight: bold;
            }

            .unina-btn-primary:hover {
                background: #ff5252;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            }

            .nav-user-info {
                display: flex;
                align-items: center;
                gap: 10px;
                border-left: 1px solid rgba(255, 255, 255, 0.2);
                padding-left: 15px;
                margin-left: 5px;
            }

            .nav-avatar {
                width: 32px;
                height: 32px;
                background: white;
                color: #667eea;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                font-size: 13px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            @media (max-width: 900px) {
                .unina-nav-container {
                    flex-direction: column;
                    gap: 15px;
                }

                .unina-nav-links {
                    flex-wrap: wrap;
                    justify-content: center;
                }
            }
        </style>

        <nav class="unina-navbar">
            <div class="unina-nav-container">
                <a href="index.jsp" class="unina-brand">
                    <i class="fa fa-university" style="margin-right: 8px;"></i>UninaSwap
                </a>
                <div class="unina-nav-links">
                    <a href="index.jsp">Home</a>
                    <a href="view_ads.jsp">Annunci</a>
                    <a href="aboutus.jsp">Chi Siamo</a>
                    <a href="contactus.jsp">Contatti</a>
                    <% if(navLoggedIn) { %>
                        <a href="user_dashboard.jsp">Dashboard</a>
                        <a href="create_ad.jsp" class="unina-btn-primary">Crea Annuncio</a>
                        <div class="nav-user-info">
                            <a href="logout" style="color: #ffcccc !important;">Logout</a>
                            <a href="user_profile.jsp" class="nav-avatar" title="Profilo">
                                <%= navUser.getFirstName().substring(0,1).toUpperCase() %>
                                    <%= navUser.getLastName().substring(0,1).toUpperCase() %>
                            </a>
                        </div>
                        <% } else { %>
                            <a href="customerlogin.jsp">Accedi</a>
                            <a href="customer_reg.jsp" class="unina-btn-primary">Registrati</a>
                            <% } %>
                </div>
            </div>
        </nav>