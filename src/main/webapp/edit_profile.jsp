<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.entity.User" %>
        <% User user=(User) session.getAttribute("user"); if (user==null) { response.sendRedirect("customerlogin.jsp");
            return; } %>

            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>Modifica Profilo - UninaSwap</title>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="Css/w3.css">
                <link rel="stylesheet" href="Css/abc.css">
                <style>
                    .edit-container {
                        max-width: 600px;
                        margin: 40px auto;
                        padding: 0 20px;
                    }

                    .edit-card {
                        background: white;
                        border-radius: 15px;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                        padding: 40px;
                    }

                    .edit-header {
                        text-align: center;
                        margin-bottom: 30px;
                    }

                    .edit-header h2 {
                        color: #1e293b;
                        font-weight: bold;
                    }

                    .form-group {
                        margin-bottom: 20px;
                    }

                    .form-label {
                        display: block;
                        color: #64748b;
                        font-size: 0.9em;
                        font-weight: 600;
                        margin-bottom: 8px;
                    }

                    .form-control {
                        width: 100%;
                        padding: 12px 15px;
                        border: 2px solid #e2e8f0;
                        border-radius: 8px;
                        font-size: 1em;
                        transition: border-color 0.3s;
                    }

                    .form-control:focus {
                        outline: none;
                        border-color: #667eea;
                    }

                    .btn-save {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: white;
                        border: none;
                        padding: 14px;
                        border-radius: 8px;
                        font-weight: bold;
                        width: 100%;
                        cursor: pointer;
                        transition: transform 0.2s;
                        margin-top: 20px;
                    }

                    .btn-save:hover {
                        transform: translateY(-2px);
                    }

                    .btn-cancel {
                        display: block;
                        text-align: center;
                        margin-top: 15px;
                        color: #64748b;
                        text-decoration: none;
                        font-size: 0.9em;
                    }
                </style>
            </head>

            <body style="background-color: #f8fafc;">

                <jsp:include page="navbar.jsp" />

                <div class="edit-container">
                    <div class="edit-card">
                        <div class="edit-header">
                            <h2>Modifica Profilo</h2>
                            <p class="text-muted">Aggiorna le tue informazioni personali</p>
                        </div>

                        <form action="update_profile" method="post">
                            <input type="hidden" name="id" value="<%= user.getId() %>">

                            <div class="w3-row-padding" style="margin:0 -16px;">
                                <div class="w3-half form-group">
                                    <label class="form-label">Nome</label>
                                    <input type="text" name="firstName" class="form-control"
                                        value="<%= user.getFirstName() %>" required>
                                </div>
                                <div class="w3-half form-group">
                                    <label class="form-label">Cognome</label>
                                    <input type="text" name="lastName" class="form-control"
                                        value="<%= user.getLastName() %>" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Facoltà</label>
                                <select name="faculty" class="form-control">
                                    <option value="Informatica" <%="Informatica" .equals(user.getFaculty()) ? "selected"
                                        : "" %>>Informatica</option>
                                    <option value="Ingegneria" <%="Ingegneria" .equals(user.getFaculty()) ? "selected"
                                        : "" %>>Ingegneria</option>
                                    <option value="Economia" <%="Economia" .equals(user.getFaculty()) ? "selected" : ""
                                        %>>Economia</option>
                                    <option value="Medicina" <%="Medicina" .equals(user.getFaculty()) ? "selected" : ""
                                        %>>Medicina</option>
                                    <option value="Giurisprudenza" <%="Giurisprudenza" .equals(user.getFaculty())
                                        ? "selected" : "" %>>Giurisprudenza</option>
                                    <option value="Altro" <%="Altro" .equals(user.getFaculty()) ? "selected" : "" %>
                                        >Altro</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Anno di Corso</label>
                                <input type="text" name="year" class="form-control"
                                    value="<%= user.getYear() != null ? user.getYear() : "" %>"
                                    placeholder="Es: 1, 2, 3, Fuori Corso">
                            </div>

                            <div class="form-group">
                                <label class="form-label">Telefono</label>
                                <input type="text" name="phone" class="form-control"
                                    value="<%= user.getPhone() != null ? user.getPhone() : "" %>">
                            </div>

                            <button type="submit" class="btn-save">Salva Modifiche</button>
                            <a href="user_profile.jsp" class="btn-cancel">Annulla e Torna al Profilo</a>
                        </form>
                    </div>
                </div>

            </body>

            </html>