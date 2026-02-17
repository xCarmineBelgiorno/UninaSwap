<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UninaSwap - Registrazione</title>
<link rel="stylesheet" href="Css/w3.css">
<link rel="stylesheet" href="Css/abc.css">
<style>
.registration-container {
    max-width: 600px;
    margin: 30px auto;
    padding: 40px;
    background: white;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
}

.registration-title {
    text-align: center;
    color: #333;
    margin-bottom: 30px;
    font-size: 2.5em;
}

.registration-subtitle {
    text-align: center;
    color: #666;
    margin-bottom: 40px;
    font-size: 1.1em;
}

.form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
    margin-bottom: 20px;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    color: #555;
    font-weight: bold;
    font-size: 14px;
}

.form-group input, .form-group select {
    width: 100%;
    padding: 12px;
    border: 2px solid #ddd;
    border-radius: 8px;
    font-size: 16px;
    transition: all 0.3s ease;
    box-sizing: border-box;
}

.form-group input:focus, .form-group select:focus {
    outline: none;
    border-color: #667eea;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.form-group.full-width {
    grid-column: 1 / -1;
}

.register-btn {
    width: 100%;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 15px;
    border: none;
    border-radius: 8px;
    font-size: 18px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s ease;
    margin-top: 20px;
}

.register-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 20px rgba(102, 126, 234, 0.3);
}

.login-link {
    text-align: center;
    margin-top: 25px;
    padding-top: 20px;
    border-top: 1px solid #eee;
}

.login-link a {
    color: #667eea;
    text-decoration: none;
    font-weight: bold;
}

.login-link a:hover {
    text-decoration: underline;
}

.error-message {
    background: #ff6b6b;
    color: white;
    padding: 12px;
    border-radius: 8px;
    margin-bottom: 20px;
    text-align: center;
}

.success-message {
    background: #51cf66;
    color: white;
    padding: 12px;
    border-radius: 8px;
    margin-bottom: 20px;
    text-align: center;
}

.required-field {
    color: #ff6b6b;
}

@media (max-width: 768px) {
    .form-row {
        grid-template-columns: 1fr;
    }
    
    .registration-container {
        margin: 20px;
        padding: 30px;
    }
}
</style>
</head>
<body style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh;">

<div class="registration-container">
    <h1 class="registration-title">UninaSwap</h1>
    <p class="registration-subtitle">Registrati alla piattaforma di scambio universitario</p>
    
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
    
    <form action="register" method="post" class="registration-form">
        <div class="form-row">
            <div class="form-group">
                <label for="firstName">Nome <span class="required-field">*</span></label>
                <input type="text" id="firstName" name="firstName" required placeholder="Il tuo nome">
            </div>
            
            <div class="form-group">
                <label for="lastName">Cognome <span class="required-field">*</span></label>
                <input type="text" id="lastName" name="lastName" required placeholder="Il tuo cognome">
            </div>
        </div>
        
        <div class="form-group">
            <label for="email">Email Universitaria <span class="required-field">*</span></label>
            <input type="email" id="email" name="email" required placeholder="esempio@studenti.unina.it">
        </div>
        
        <div class="form-row">
            <div class="form-group">
                <label for="password">Password <span class="required-field">*</span></label>
                <input type="password" id="password" name="password" required placeholder="Minimo 8 caratteri">
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">Conferma Password <span class="required-field">*</span></label>
                <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="Ripeti la password">
            </div>
        </div>
        
        <div class="form-row">
            <div class="form-group">
                <label for="faculty">Facoltà <span class="required-field">*</span></label>
                <select id="faculty" name="faculty" required>
                    <option value="">Seleziona la facoltà</option>
                    <option value="Ingegneria">Ingegneria</option>
                    <option value="Economia">Economia</option>
                    <option value="Medicina">Medicina</option>
                    <option value="Giurisprudenza">Giurisprudenza</option>
                    <option value="Lettere">Lettere</option>
                    <option value="Scienze">Scienze</option>
                    <option value="Architettura">Architettura</option>
                    <option value="Farmacia">Farmacia</option>
                    <option value="Veterinaria">Veterinaria</option>
                    <option value="Altro">Altro</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="year">Anno di Corso</label>
                <select id="year" name="year">
                    <option value="">Seleziona l'anno</option>
                    <option value="1">Primo Anno</option>
                    <option value="2">Secondo Anno</option>
                    <option value="3">Terzo Anno</option>
                    <option value="4">Quarto Anno</option>
                    <option value="5">Quinto Anno</option>
                    <option value="6">Sesto Anno</option>
                    <option value="Laureato">Laureato</option>
                </select>
            </div>
        </div>
        
        <div class="form-group">
            <label for="phone">Telefono (opzionale)</label>
            <input type="tel" id="phone" name="phone" placeholder="Il tuo numero di telefono">
        </div>
        
        <button type="submit" class="register-btn">Registrati a UninaSwap</button>
    </form>
    
    <div class="login-link">
        <p>Hai già un account? <a href="customerlogin.jsp">Accedi qui</a></p>
    </div>
    
    <div style="text-align: center; margin-top: 20px;">
        <a href="index.jsp" style="color: #667eea; text-decoration: none;">← Torna alla Home</a>
    </div>
</div>

</body>
</html>