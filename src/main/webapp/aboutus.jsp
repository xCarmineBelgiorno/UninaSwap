<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Chi Siamo - UninaSwap</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="Css/w3.css">
        <style>
            .about-container {
                max-width: 800px;
                margin: 50px auto;
                padding: 40px;
                background: white;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            }

            .about-title {
                color: #1e293b;
                font-weight: bold;
                margin-bottom: 30px;
                text-align: center;
            }

            .about-text {
                color: #475569;
                line-height: 1.8;
                font-size: 1.1em;
            }
        </style>
    </head>

    <body style="background: #f8fafc;">
        <jsp:include page="navbar.jsp" />
        <div class="about-container text-center">
            <h1 class="about-title">Chi Siamo</h1>
            <div class="about-text">
                <p><strong>UninaSwap</strong> è la piattaforma ufficiale di scambio e mercatino per gli studenti
                    dell'Università di Napoli.</p>
                <p>Nata con l'obiettivo di facilitare il riutilizzo di libri, appunti e materiale didattico, la nostra
                    missione è creare una comunità studentesca più sostenibile e collaborativa.</p>
                <p>Qui puoi vendere, scambiare o regalare oggetti che non ti servono più ad altri colleghi del tuo
                    stesso ateneo.</p>
            </div>
        </div>
    </body>

    </html>