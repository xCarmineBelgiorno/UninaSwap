<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.entity.SimpleAd" %>
        <%@ page import="com.control.AdControl" %>
            <%@ page import="com.entity.User" %>
                <% User user=(User) session.getAttribute("user"); if (user==null) {
                    response.sendRedirect("customerlogin.jsp"); return; } String idParam=request.getParameter("adId");
                    if (idParam==null) { response.sendRedirect("my_ads.jsp"); return; } Long
                    adId=Long.parseLong(idParam); AdControl adControl=new AdControl(); SimpleAd
                    ad=adControl.getAdById(adId); if (ad==null || !ad.getUserId().equals(user.getId())) {
                    response.sendRedirect("my_ads.jsp"); return; } %>

                    <!DOCTYPE html>
                    <html>

                    <head>
                        <meta charset="UTF-8">
                        <title>Modifica Annuncio - UninaSwap</title>
                        <link rel="stylesheet"
                            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                        <link rel="stylesheet" href="Css/w3.css">
                        <link rel="stylesheet" href="Css/abc.css">
                        <style>
                            .form-container {
                                max-width: 800px;
                                margin: 40px auto;
                                padding: 0 20px;
                            }

                            .form-card {
                                background: white;
                                border-radius: 15px;
                                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                                padding: 40px;
                            }

                            .form-header {
                                text-align: center;
                                margin-bottom: 30px;
                            }

                            .form-group {
                                margin-bottom: 20px;
                            }

                            .form-label {
                                display: block;
                                color: #64748b;
                                font-weight: 600;
                                margin-bottom: 8px;
                            }

                            .form-control {
                                width: 100%;
                                padding: 12px;
                                border: 2px solid #e2e8f0;
                                border-radius: 8px;
                                transition: border-color 0.3s;
                            }

                            .form-control:focus {
                                outline: none;
                                border-color: #667eea;
                            }

                            .btn-submit {
                                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                color: white;
                                border: none;
                                padding: 14px;
                                border-radius: 8px;
                                font-weight: bold;
                                width: 100%;
                                cursor: pointer;
                                margin-top: 20px;
                            }
                        </style>
                    </head>

                    <body style="background-color: #f8fafc;">

                        <jsp:include page="navbar.jsp" />

                        <div class="form-container">
                            <div class="form-card">
                                <div class="form-header">
                                    <h2>Modifica Annuncio</h2>
                                    <p>Aggiorna i dettagli del tuo annuncio</p>
                                </div>

                                <form action="editAd" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="id" value="<%= ad.getId() %>">

                                    <div class="form-group">
                                        <label class="form-label">Titolo</label>
                                        <input type="text" name="title" class="form-control"
                                            value="<%= ad.getTitle() %>" required>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Descrizione</label>
                                        <textarea name="description" class="form-control" rows="5"
                                            required><%= ad.getDescription() %></textarea>
                                    </div>

                                    <div class="w3-row-padding" style="margin:0 -16px;">
                                        <div class="w3-half form-group">
                                            <label class="form-label">Tipo</label>
                                            <select name="adType" class="form-control" required>
                                                <option value="SALE" <%="SALE" .equals(ad.getType()) ? "selected" : ""
                                                    %>>Vendita</option>
                                                <option value="EXCHANGE" <%="EXCHANGE" .equals(ad.getType())
                                                    ? "selected" : "" %>>Scambio</option>
                                                <option value="GIFT" <%="GIFT" .equals(ad.getType()) ? "selected" : ""
                                                    %>>Regalo</option>
                                            </select>
                                        </div>
                                        <div class="w3-half form-group">
                                            <label class="form-label">Prezzo (€)</label>
                                            <input type="number" name="price" class="form-control"
                                                value="<%= ad.getPrice() %>" step="0.01">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Informazioni di Consegna (Luogo e Orario)</label>
                                        <textarea name="deliveryInfo" class="form-control" rows="3"
                                            required><%= ad.getLocation() %></textarea>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Immagini (max 5, lascia vuoto per mantenere le
                                            attuali)</label>
                                        <input type="file" name="images" class="form-control" multiple accept="image/*">
                                    </div>

                                    <button type="submit" class="btn-submit">Salva Modifiche</button>
                                    <a href="view_ad.jsp?adId=<%= ad.getId() %>"
                                        style="display:block; text-align:center; margin-top:15px; color:#64748b; text-decoration:none;">Annulla</a>
                                </form>
                            </div>
                        </div>

                    </body>

                    </html>