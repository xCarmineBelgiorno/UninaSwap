package com.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.entity.SimpleAd;
import com.entity.Category;
import com.entity.User;

@MultipartConfig
public class CreateAdServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private String readParam(HttpServletRequest request, String name) throws IOException, ServletException {
        String value = request.getParameter(name);
        if (value != null)
            return value;
        Part p = request.getPart(name);
        if (p != null) {
            byte[] bytes = p.getInputStream().readAllBytes();
            return new String(bytes, java.nio.charset.StandardCharsets.UTF_8).trim();
        }
        return null;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            // Recupera i parametri dal form
            String title = readParam(request, "title");
            String description = readParam(request, "description");
            String categoryName = readParam(request, "category");
            String adType = readParam(request, "adType");
            String price = readParam(request, "price");
            String deliveryInfo = readParam(request, "deliveryInfo");

            System.out.println("=== CREAZIONE ANNUNCIO ===");
            System.out.println("Titolo: " + title);
            System.out.println("Descrizione: " + description);
            System.out.println("Categoria: " + categoryName);
            System.out.println("Tipo: " + adType);
            System.out.println("Prezzo: " + price);
            System.out.println("Consegna: " + deliveryInfo);

            // Validazioni base
            if (title == null || title.trim().isEmpty()) {
                request.setAttribute("error", "Il titolo è obbligatorio");
                request.getRequestDispatcher("create_ad.jsp").forward(request, response);
                return;
            }

            if (description == null || description.trim().isEmpty()) {
                request.setAttribute("error", "La descrizione è obbligatoria");
                request.getRequestDispatcher("create_ad.jsp").forward(request, response);
                return;
            }

            if (categoryName == null || categoryName.trim().isEmpty()) {
                request.setAttribute("error", "La categoria è obbligatoria");
                request.getRequestDispatcher("create_ad.jsp").forward(request, response);
                return;
            }

            if (adType == null || adType.trim().isEmpty()) {
                request.setAttribute("error", "Il tipo di annuncio è obbligatorio");
                request.getRequestDispatcher("create_ad.jsp").forward(request, response);
                return;
            }

            // Controlla se l'utente è loggato
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect("customerlogin.jsp");
                return;
            }
            User user = (User) session.getAttribute("user");

            // Gestione Caricamento Immagini
            java.util.List<String> fileNames = new java.util.ArrayList<>();

            String srcPath = "c:\\Users\\carmi\\Desktop\\EcommerceApp\\EcommerceApp\\src\\main\\webapp\\images";
            String runtimePath = getServletContext().getRealPath("") + java.io.File.separator + "images";

            com.control.AdControl adControl = new com.control.AdControl();

            try {
                java.util.Collection<Part> parts = request.getParts();
                System.out.println("DEBUG: Risorse ricevute: " + parts.size());
                for (Part p : parts) {
                    System.out.println("DEBUG: Part name: " + p.getName() + ", size: " + p.getSize() + ", type: "
                            + p.getContentType());
                }

                fileNames = adControl.processMultipleImageUpload(parts, srcPath, runtimePath);
                System.out.println("DEBUG: File salvati: " + fileNames.size());

                if (fileNames.isEmpty()) {
                    fileNames.add("default_ad.png");
                }
            } catch (Exception e) {
                System.out.println("Errore caricamento immagini: " + e.getMessage());
                fileNames.add("default_ad.png");
            }

            // Crea l'oggetto Category
            Category category = new Category();
            category.setName(categoryName);

            // Crea l'oggetto SimpleAd
            SimpleAd ad = new SimpleAd();
            ad.setTitle(title);
            ad.setDescription(description);
            ad.setCategory(category);
            ad.setAdType(adType); // per compatibilità con la classe base
            ad.setType(adType); // per compatibilità con il DAO
            ad.setDeliveryInfo(deliveryInfo);
            ad.setOwner(user);
            ad.setUserId(user.getId());
            ad.setImageUrls(fileNames); // Imposta la lista delle immagini
            ad.setImageUrl(fileNames.get(0)); // Imposta l'immagine principale

            // Imposta il prezzo se è una vendita
            if ("SALE".equals(adType) && price != null && !price.trim().isEmpty()) {
                try {
                    ad.setPrice(new BigDecimal(price));
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Prezzo non valido");
                    request.getRequestDispatcher("create_ad.jsp").forward(request, response);
                    return;
                }
            }

            // Informazioni di consegna
            String safeDelivery = (deliveryInfo != null && !deliveryInfo.trim().isEmpty()) ? deliveryInfo.trim()
                    : "Da concordare";
            ad.setLocation(safeDelivery);
            ad.setPickupTime("Da concordare");

            // Salva l'annuncio tramite Control
            boolean success = adControl.createAd(ad);

            if (success) {
                System.out.println("=== ANNUNCIO CREATO CON SUCCESSO ===");
                response.sendRedirect("user_dashboard.jsp?ad_created=1");
            } else {
                System.out.println("=== ERRORE NELLA CREAZIONE DELL'ANNUNCIO ===");
                request.setAttribute("error", "Errore durante la pubblicazione dell'annuncio. Riprova.");
                request.getRequestDispatcher("create_ad.jsp").forward(request, response);
            }

        } catch (Exception e) {
            System.out.println("=== ERRORE CRITICO nella creazione annuncio: " + e.getMessage() + " ===");
            e.printStackTrace();
            request.setAttribute("error", "Errore del server: " + e.getMessage());
            request.getRequestDispatcher("create_ad.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("create_ad.jsp");
    }
}
