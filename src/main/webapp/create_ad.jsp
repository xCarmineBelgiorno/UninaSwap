<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Crea Annuncio - UninaSwap</title>
        <link rel="stylesheet" href="images/bootstrap.css">
        <link rel="stylesheet" href="Css/w3.css">
        <link rel="stylesheet" href="Css/abc.css">
        <link rel="stylesheet" href="Css/font.css">
        <link rel="stylesheet" href="Css/whitespace.css">

        <style>
            .w3-sidebar a {
                font-family: "Roboto", sans-serif
            }

            body,
            h1,
            h2,
            h3,
            h4,
            h5,
            h6,
            .w3-wide {
                font-family: "Montserrat", sans-serif;
            }

            .create-ad-form {
                background-color: white;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                padding: 40px;
            }

            .form-title {
                color: #667eea;
                text-align: center;
                margin-bottom: 30px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-control,
            .form-select {
                border-radius: 10px;
                border: 2px solid #e9ecef;
                padding: 12px 15px;
                transition: border-color 0.3s ease;
            }

            .form-control:focus,
            .form-select:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            }

            .btn-create {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                border-radius: 10px;
                padding: 12px 30px;
                font-weight: bold;
                transition: transform 0.3s ease;
            }

            .btn-create:hover {
                transform: translateY(-2px);
            }

            .ad-type-section {
                background-color: #f8f9fa;
                border-radius: 10px;
                padding: 20px;
                margin: 20px 0;
            }

            .image-upload-area {
                border: 2px dashed #dee2e6;
                border-radius: 10px;
                padding: 40px;
                text-align: center;
                background-color: #f8f9fa;
                transition: border-color 0.3s ease;
            }

            .image-upload-area:hover {
                border-color: #667eea;
            }

            .image-preview {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-top: 15px;
            }

            .image-preview img {
                width: 100px;
                height: 100px;
                object-fit: cover;
                border-radius: 8px;
                border: 2px solid #dee2e6;
            }

            .remove-image {
                position: absolute;
                top: -5px;
                right: -5px;
                background: #dc3545;
                color: white;
                border: none;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                font-size: 12px;
                cursor: pointer;
            }

            .image-container {
                position: relative;
                display: inline-block;
            }
        </style>
    </head>

    <body>

        <%@ include file="customer_navbar.jsp" %>

            <div class="container my-5">
                <div class="row justify-content-center">
                    <div class="col-md-10 col-lg-8">
                        <div class="create-ad-form">
                            <h2 class="form-title">Crea un Nuovo Annuncio</h2>
                            <p class="text-center text-muted mb-4">Pubblica un annuncio per vendere, scambiare o
                                regalare oggetti</p>

                            <form method="post" action="createad" enctype="multipart/form-data" id="createAdForm">
                                <!-- Basic Information -->
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <label for="title" class="form-label">Titolo dell'Annuncio *</label>
                                            <input type="text" class="form-control" id="title" name="title" required
                                                placeholder="Es: Libro di Java per Informatica">
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="category" class="form-label">Categoria *</label>
                                            <select class="form-select" id="category" name="category" required>
                                                <option value="">Seleziona categoria</option>
                                                <option value="Libri">Libri</option>
                                                <option value="Elettronica">Elettronica</option>
                                                <option value="Abbigliamento">Abbigliamento</option>
                                                <option value="Sport">Sport</option>
                                                <option value="Casa">Casa</option>
                                                <option value="Altro">Altro</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="description" class="form-label">Descrizione *</label>
                                    <textarea class="form-control" id="description" name="description" rows="4" required
                                        placeholder="Descrivi l'oggetto, le sue condizioni, il motivo della vendita/scambio..."></textarea>
                                </div>

                                <!-- Ad Type Selection -->
                                <div class="ad-type-section">
                                    <h5 class="mb-3">Tipo di Annuncio *</h5>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="adType" id="saleType"
                                                    value="SALE" required>
                                                <label class="form-check-label" for="saleType">
                                                    <strong>Vendita</strong><br>
                                                    <small class="text-muted">Vendi l'oggetto a un prezzo fisso</small>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="adType"
                                                    id="exchangeType" value="EXCHANGE">
                                                <label class="form-check-label" for="exchangeType">
                                                    <strong>Scambio</strong><br>
                                                    <small class="text-muted">Scambia con altri oggetti</small>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="adType" id="giftType"
                                                    value="GIFT">
                                                <label class="form-check-label" for="giftType">
                                                    <strong>Regalo</strong><br>
                                                    <small class="text-muted">Regala l'oggetto gratuitamente</small>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Type-specific fields -->
                                <div id="saleFields" class="type-fields" style="display: none;">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="price" class="form-label">Prezzo (€) *</label>
                                                <input type="number" class="form-control" id="price" name="price"
                                                    step="0.01" min="0" placeholder="0.00">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="currency" class="form-label">Valuta</label>
                                                <select class="form-select" id="currency" name="currency">
                                                    <option value="EUR" selected>Euro (€)</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div id="exchangeFields" class="type-fields" style="display: none;">
                                    <div class="form-group">
                                        <label for="requestedItem" class="form-label">Cosa vorresti in cambio? *</label>
                                        <textarea class="form-control" id="requestedItem" name="requestedItem" rows="3"
                                            placeholder="Descrivi gli oggetti che vorresti ricevere in cambio..."></textarea>
                                    </div>
                                </div>

                                <div id="giftFields" class="type-fields" style="display: none;">
                                    <div class="form-group">
                                        <label for="conditions" class="form-label">Condizioni (opzionale)</label>
                                        <textarea class="form-control" id="conditions" name="conditions" rows="3"
                                            placeholder="Eventuali condizioni per ricevere il regalo..."></textarea>
                                    </div>
                                </div>

                                <!-- Delivery Information -->
                                <div class="form-group">
                                    <label for="deliveryInfo" class="form-label">Informazioni di Consegna *</label>
                                    <textarea class="form-control" id="deliveryInfo" name="deliveryInfo" rows="3"
                                        required
                                        placeholder="Specifica sede universitaria e fascia oraria per il ritiro..."></textarea>
                                    <small class="form-text text-muted">Es: Sede di via Toledo, lunedì-venerdì
                                        14:00-18:00</small>
                                </div>

                                <!-- Image Upload -->
                                <div class="form-group">
                                    <label class="form-label">Immagini dell'Oggetto</label>
                                    <div class="image-upload-area" id="imageUploadArea">
                                        <i class="fas fa-cloud-upload-alt fa-3x text-muted mb-3"></i>
                                        <p class="text-muted">Trascina qui le immagini o clicca per selezionare</p>
                                        <input type="file" id="imageInput" name="images" multiple accept="image/*"
                                            style="display: none;">
                                        <button type="button" class="btn btn-outline-primary"
                                            onclick="document.getElementById('imageInput').click()">
                                            Seleziona Immagini
                                        </button>
                                    </div>
                                    <div class="image-preview" id="imagePreview"></div>
                                    <small class="form-text text-muted">Puoi caricare fino a 5 immagini (JPG, PNG, max
                                        5MB ciascuna)</small>
                                </div>

                                <div class="text-center">
                                    <button type="submit" class="btn btn-create btn-lg text-white">Pubblica
                                        Annuncio</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <br>
            <footer style="text-align: center; padding: 3px; background-color: DarkSalmon; color: white;">
                <%@ include file="footer.jsp" %>
            </footer>

            <script>
                // Show/hide type-specific fields based on selection
                document.querySelectorAll('input[name="adType"]').forEach(radio => {
                    radio.addEventListener('change', function () {
                        // Hide all type fields
                        document.querySelectorAll('.type-fields').forEach(field => {
                            field.style.display = 'none';
                        });

                        // Show selected type fields
                        if (this.value === 'SALE') {
                            document.getElementById('saleFields').style.display = 'block';
                        } else if (this.value === 'EXCHANGE') {
                            document.getElementById('exchangeFields').style.display = 'block';
                        } else if (this.value === 'GIFT') {
                            document.getElementById('giftFields').style.display = 'block';
                        }
                    });
                });

                // Image upload handling
                // Image upload handling
                let allFiles = [];

                document.getElementById('imageInput').addEventListener('change', function (e) {
                    const newFiles = Array.from(e.target.files);

                    // Prevent duplicates based on name and size
                    newFiles.forEach(file => {
                        if (!allFiles.some(f => f.name === file.name && f.size === file.size)) {
                            if (file.type.startsWith('image/')) {
                                allFiles.push(file);
                            }
                        }
                    });

                    updatePreviewAndInput();
                });

                function updatePreviewAndInput() {
                    const preview = document.getElementById('imagePreview');
                    preview.innerHTML = ''; // Clear current preview

                    // Update input files
                    const dataTransfer = new DataTransfer();
                    allFiles.forEach(file => dataTransfer.items.add(file));
                    document.getElementById('imageInput').files = dataTransfer.files;

                    // Limits
                    if (allFiles.length > 5) {
                        alert("Puoi caricare massimo 5 immagini.");
                        allFiles = allFiles.slice(0, 5);
                        updatePreviewAndInput(); // Recursive call to refresh with 5
                        return;
                    }

                    allFiles.forEach((file, index) => {
                        const reader = new FileReader();
                        reader.onload = function (e) {
                            const imageContainer = document.createElement('div');
                            imageContainer.className = 'image-container';

                            const img = document.createElement('img');
                            img.src = e.target.result;
                            img.alt = 'Preview';

                            const removeBtn = document.createElement('button');
                            removeBtn.className = 'remove-image';
                            removeBtn.innerHTML = '×';
                            removeBtn.onclick = function () {
                                allFiles = allFiles.filter(f => f !== file);
                                updatePreviewAndInput();
                            };

                            imageContainer.appendChild(img);
                            imageContainer.appendChild(removeBtn);
                            preview.appendChild(imageContainer);
                        };
                        reader.readAsDataURL(file);
                    });
                }

                // Form validation
                document.getElementById('createAdForm').addEventListener('submit', function (e) {
                    const adType = document.querySelector('input[name="adType"]:checked');
                    if (!adType) {
                        e.preventDefault();
                        alert('Seleziona il tipo di annuncio!');
                        return false;
                    }

                    if (adType.value === 'SALE') {
                        const price = document.getElementById('price').value;
                        if (!price || parseFloat(price) <= 0) {
                            e.preventDefault();
                            alert('Inserisci un prezzo valido per la vendita!');
                            return false;
                        }
                    }

                    if (adType.value === 'EXCHANGE') {
                        const requestedItem = document.getElementById('requestedItem').value;
                        if (!requestedItem.trim()) {
                            e.preventDefault();
                            alert('Descrivi cosa vorresti in cambio!');
                            return false;
                        }
                    }

                    const title = document.getElementById('title').value;
                    if (title.length < 10) {
                        e.preventDefault();
                        alert('Il titolo deve essere di almeno 10 caratteri!');
                        return false;
                    }

                    const description = document.getElementById('description').value;
                    if (description.length < 20) {
                        e.preventDefault();
                        alert('La descrizione deve essere di almeno 20 caratteri!');
                        return false;
                    }
                });

                // Drag and drop functionality
                const uploadArea = document.getElementById('imageUploadArea');

                uploadArea.addEventListener('dragover', function (e) {
                    e.preventDefault();
                    this.style.borderColor = '#667eea';
                    this.style.backgroundColor = '#f0f8ff';
                });

                uploadArea.addEventListener('dragleave', function (e) {
                    e.preventDefault();
                    this.style.borderColor = '#dee2e6';
                    this.style.backgroundColor = '#f8f9fa';
                });

                uploadArea.addEventListener('drop', function (e) {
                    e.preventDefault();
                    this.style.borderColor = '#dee2e6';
                    this.style.backgroundColor = '#f8f9fa';

                    const files = Array.from(e.dataTransfer.files);
                    // document.getElementById('imageInput').files = e.dataTransfer.files; // Removing this as we handle it via allFiles

                    // Trigger change event to process files
                    // Create a manual event with the files
                    const event = { target: { files: files } };

                    // Manually call the handler because we can't easily trigger a native change event with dataTransfer files on the input directly before processing
                    // But better: let's just add to allFiles directly
                    files.forEach(file => {
                        if (!allFiles.some(f => f.name === file.name && f.size === file.size)) {
                            if (file.type.startsWith('image/')) {
                                allFiles.push(file);
                            }
                        }
                    });
                    updatePreviewAndInput();
                });
            </script>

    </body>

    </html>