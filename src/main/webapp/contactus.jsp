<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Contatti - UninaSwap</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="Css/w3.css">
        <style>
            .contact-container {
                max-width: 600px;
                margin: 50px auto;
                padding: 40px;
                background: white;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            }

            .contact-title {
                color: #1e293b;
                font-weight: bold;
                margin-bottom: 30px;
                text-align: center;
            }
        </style>
    </head>

    <body style="background: #f8fafc;">
        <jsp:include page="navbar.jsp" />
        <div class="contact-container">
            <h1 class="contact-title">Contatti</h1>
            <div class="w3-container w3-padding-16">
                <div class="w3-margin-bottom">
                    <i class="fas fa-envelope w3-text-indigo w3-xlarge"></i>
                    <span class="w3-margin-left">support@uninaswap.it</span>
                </div>
                <div class="w3-margin-bottom">
                    <i class="fas fa-map-marker-alt w3-text-indigo w3-xlarge"></i>
                    <span class="w3-margin-left">Università di Napoli - Complesso MSA</span>
                </div>
                <hr>
                <p class="w3-text-grey">Hai suggerimenti? Scrivici o seguici sui social!</p>
            </div>
        </div>
    </body>

    </html>