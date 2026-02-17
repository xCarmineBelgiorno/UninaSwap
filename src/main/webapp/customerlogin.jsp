<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UninaSwap - Login</title>
<link rel="stylesheet" href="Css/w3.css">
<link rel="stylesheet" href="Css/abc.css">
<style>
.login-container {
    max-width: 400px;
    margin: 50px auto;
    padding: 30px;
    background: white;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

.login-title {
    text-align: center;
    color: #333;
    margin-bottom: 30px;
    font-size: 2em;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 5px;
    color: #555;
    font-weight: bold;
}

.form-group input {
    width: 100%;
    padding: 12px;
    border: 2px solid #ddd;
    border-radius: 5px;
    font-size: 16px;
    transition: border-color 0.3s ease;
}

.form-group input:focus {
    outline: none;
    border-color: #667eea;
}

.login-btn {
    width: 100%;
    background: #667eea;
    color: white;
    padding: 12px;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    transition: background 0.3s ease;
}

.login-btn:hover {
    background: #5a6fd8;
}

.register-link {
    text-align: center;
    margin-top: 20px;
}

.register-link a {
    color: #667eea;
    text-decoration: none;
}

.register-link a:hover {
    text-decoration: underline;
}

.error-message {
    background: #ff6b6b;
    color: white;
    padding: 10px;
    border-radius: 5px;
    margin-bottom: 20px;
    text-align: center;
}

.success-message {
    background: #51cf66;
    color: white;
    padding: 10px;
    border-radius: 5px;
    margin-bottom: 20px;
    text-align: center;
}
</style>
</head>
<body style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh;">

<div class="login-container">
    <h1 class="login-title">UninaSwap</h1>
    
    <% if(request.getAttribute("error") != null) { %>
        <div class="error-message">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>
    
    <% if(request.getAttribute("success") != null) { %>
        <div class="success-message">
            <%= request.getAttribute("success") %>
        </div>
    <% } %>
    
    <form action="login" method="post" class="login-form">
        <div class="form-group">
            <label for="email">Email Universitaria</label>
            <input type="email" id="email" name="email" required placeholder="esempio@studenti.unina.it">
        </div>
        
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required placeholder="Inserisci la tua password">
        </div>
        
        <button type="submit" class="login-btn">Accedi</button>
    </form>
    
    <div class="register-link">
        <p>Non hai un account? <a href="customer_reg.jsp">Registrati qui</a></p>
    </div>
    
    <div style="text-align: center; margin-top: 30px;">
        <a href="index.jsp" style="color: #667eea; text-decoration: none;">← Torna alla Home</a>
    </div>
</div>

</body>
</html>