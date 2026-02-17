<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.entity.User" %>
<%
    User sessionUser = (User) session.getAttribute("user");
    boolean loggedIn = (sessionUser != null);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UninaSwap - Piattaforma di Scambio Universitario</title>
<link rel="stylesheet" href="Css/w3.css">
<link rel="stylesheet" href="Css/font.css">
<link rel="stylesheet" href="Css/abc.css">

<style>
.w3-sidebar a {font-family: "Roboto", sans-serif}
body,h1,h2,h3,h4,h5,h6,.w3-wide {font-family: "Montserrat", sans-serif;}

/* Navbar styles */
.navbar {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    padding: 15px 0;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
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
}

.navbar-brand:hover {
    color: #f0f0f0;
}

.navbar-nav {
    display: flex;
    list-style: none;
    margin: 0;
    padding: 0;
    gap: 20px;
}

.navbar-nav a {
    color: white;
    text-decoration: none;
    padding: 10px 15px;
    border-radius: 5px;
    transition: all 0.3s ease;
}

.navbar-nav a:hover {
    background: rgba(255,255,255,0.1);
    transform: translateY(-2px);
}

.navbar-nav .btn-primary {
    background: #ff6b6b;
    color: white;
    padding: 10px 20px;
    border-radius: 25px;
    font-weight: bold;
}

.navbar-nav .btn-primary:hover {
    background: #ff5252;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

@media (max-width: 768px) {
    .navbar-container {
        flex-direction: column;
        gap: 15px;
    }
    
    .navbar-nav {
        flex-wrap: wrap;
        justify-content: center;
    }
}

.hero-section {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 80px 20px;
    text-align: center;
}

.hero-title {
    font-size: 3.5em;
    margin-bottom: 20px;
    font-weight: bold;
}

.hero-subtitle {
    font-size: 1.5em;
    margin-bottom: 40px;
    opacity: 0.9;
}

.feature-section {
    padding: 60px 20px;
    background: #f8f9fa;
}

.feature-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 30px;
    max-width: 1200px;
    margin: 0 auto;
}

.feature-card {
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    text-align: center;
}

.feature-icon {
    font-size: 3em;
    color: #667eea;
    margin-bottom: 20px;
}

.stats-section {
    background: #667eea;
    color: white;
    padding: 60px 20px;
    text-align: center;
}

.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 30px;
    max-width: 800px;
    margin: 0 auto;
}

.stat-item {
    text-align: center;
}

.stat-number {
    font-size: 2.5em;
    font-weight: bold;
    margin-bottom: 10px;
}

.stat-label {
    font-size: 1.1em;
    opacity: 0.9;
}

.cta-section {
    padding: 60px 20px;
    text-align: center;
    background: white;
}

.cta-button {
    display: inline-block;
    background: #667eea;
    color: white;
    padding: 15px 30px;
    text-decoration: none;
    border-radius: 25px;
    font-size: 1.2em;
    margin: 10px;
    transition: all 0.3s ease;
}

.cta-button:hover {
    background: #5a6fd8;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}
</style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<!-- Hero Section -->
<div class="hero-section">
    <h1 class="hero-title">UninaSwap</h1>
    <p class="hero-subtitle">La piattaforma di scambio universitario per studenti dell'Università di Napoli</p>
    <div>
        <% if (!loggedIn) { %>
            <a href="customer_reg.jsp" class="cta-button">Registrati Ora</a>
            <a href="customerlogin.jsp" class="cta-button">Accedi</a>
        <% } else { %>
            <a href="user_dashboard.jsp" class="cta-button">Vai alla Dashboard</a>
            <a href="create_ad.jsp" class="cta-button">Crea Annuncio</a>
        <% } %>
    </div>
</div>

<!-- Features Section -->
<div class="feature-section">
    <div class="w3-container">
        <h2 class="w3-center" style="margin-bottom: 50px;">Perché scegliere UninaSwap?</h2>
        <div class="feature-grid">
            <div class="feature-card">
                <div class="feature-icon">🛒</div>
                <h3>Vendi</h3>
                <p>Pubblica annunci per vendere i tuoi oggetti universitari a prezzi competitivi</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🔄</div>
                <h3>Scambia</h3>
                <p>Trova oggetti interessanti da scambiare con i tuoi</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🎁</div>
                <h3>Regala</h3>
                <p>Dona oggetti che non usi più ad altri studenti</p>
            </div>
        </div>
    </div>
</div>

<!-- Stats Section -->
<div class="stats-section">
    <div class="w3-container">
        <h2 class="w3-center" style="margin-bottom: 50px;">UninaSwap in numeri</h2>
        <div class="stats-grid">
            <div class="stat-item">
                <div class="stat-number">1000+</div>
                <div class="stat-label">Studenti registrati</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">500+</div>
                <div class="stat-label">Annunci attivi</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">200+</div>
                <div class="stat-label">Scambi completati</div>
            </div>
        </div>
    </div>
</div>

<!-- Call to Action Section -->
<div class="cta-section">
    <div class="w3-container">
        <h2 class="w3-center" style="margin-bottom: 30px;">Pronto a iniziare?</h2>
        <p style="font-size: 1.2em; color: #666; margin-bottom: 40px;">
            Unisciti alla comunità UninaSwap e inizia a scambiare oggetti con altri studenti!
        </p>
        <div>
            <% if (!loggedIn) { %>
                <a href="customer_reg.jsp" class="cta-button">Registrati Gratis</a>
                <a href="view_ads.jsp" class="cta-button">Sfoglia Annunci</a>
                <a href="create_ad.jsp" class="cta-button">Crea Annuncio</a>
            <% } else { %>
                <a href="view_ads.jsp" class="cta-button">Sfoglia Annunci</a>
                <a href="create_ad.jsp" class="cta-button">Crea Annuncio</a>
            <% } %>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>