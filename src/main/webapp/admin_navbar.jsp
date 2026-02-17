<%@ page import="com.entity.User" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Admin Navbar - Darker Professional Gradient */
        .navbar-admin {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            width: 100%;
            margin-bottom: 30px;
        }

        .navbar-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .navbar-brand {
            color: white;
            font-size: 1.8em;
            font-weight: bold;
            text-decoration: none;
            letter-spacing: 1px;
        }

        .navbar-nav {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
            gap: 20px;
        }

        .navbar-nav a {
            color: #ecf0f1;
            text-decoration: none;
            padding: 8px 15px;
            border-radius: 4px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .navbar-nav a:hover {
            background: rgba(255, 255, 255, 0.1);
            color: white;
        }

        .logout-btn {
            background: #c0392b;
            padding: 8px 20px !important;
            border-radius: 4px;
        }

        .logout-btn:hover {
            background: #e74c3c !important;
        }

        .nav-user-info {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-left: 10px;
        }

        .nav-avatar {
            width: 32px;
            height: 32px;
            background: white;
            color: #2c3e50;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 13px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-decoration: none !important;
        }
    </style>

    <nav class="navbar-admin">
        <div class="navbar-container">
            <a href="adminhome.jsp" class="navbar-brand">
                <i class="fa fa-university" style="margin-right: 8px;"></i>ADMIN PANEL
            </a>
            <div class="navbar-nav">
                <a href="adminhome.jsp">Dashboard</a>
                <a href="managecustomers.jsp">Utenti</a>
                <a href="view_ads.jsp">Annunci</a>
                <a href="managetables.jsp">Tabelle</a>
                <div class="nav-user-info">
                    <a href="logout" class="logout-btn">Logout</a>
                    <% User admin=(User) session.getAttribute("user"); if(admin !=null) { %>
                        <div class="nav-avatar" title="Admin">
                            <%= admin.getFirstName().substring(0,1).toUpperCase() %>
                                <%= admin.getLastName().substring(0,1).toUpperCase() %>
                        </div>
                        <% } %>
                </div>
            </div>
        </div>
    </nav>