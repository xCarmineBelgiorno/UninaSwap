package com.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.entity.SimpleAd;
import com.entity.Category;
import com.entity.User;

@WebServlet("/editAd")
@MultipartConfig
public class EditAdServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private String readParam(HttpServletRequest request, String name) throws IOException, ServletException {
        String value = request.getParameter(name);
        if (value != null)
            return value;
        try {
            Part p = request.getPart(name);
            if (p != null) {
                byte[] bytes = p.getInputStream().readAllBytes();
                return new String(bytes, java.nio.charset.StandardCharsets.UTF_8).trim();
            }
        } catch (Exception e) {
        }
        return null;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            Long adId = Long.parseLong(readParam(request, "id"));
            String title = readParam(request, "title");
            String description = readParam(request, "description");
            String categoryName = readParam(request, "category");
            String adType = readParam(request, "adType");
            String price = readParam(request, "price");
            String deliveryInfo = readParam(request, "deliveryInfo");

            // Validazioni base
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            com.control.AdControl adControl = new com.control.AdControl();
            SimpleAd ad = adControl.getAdById(adId);

            if (ad == null || !ad.getUserId().equals(user.getId())) {
                session.setAttribute("failedMsg", "Non hai i permessi per modificare questo annuncio");
                response.sendRedirect("my_ads.jsp");
                return;
            }

            // Gestione Caricamento Immagini
            java.util.List<String> fileNames = ad.getImageUrls();
            try {
                String srcPath = "c:\\Users\\carmi\\Desktop\\EcommerceApp\\EcommerceApp\\src\\main\\webapp\\images";
                String runtimePath = getServletContext().getRealPath("") + java.io.File.separator + "images";

                java.util.Collection<Part> parts = request.getParts();
                java.util.List<String> newFiles = adControl.processMultipleImageUpload(parts, srcPath, runtimePath);

                if (!newFiles.isEmpty()) {
                    fileNames = newFiles;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Aggiorna oggetto Ad
            ad.setTitle(title);
            ad.setDescription(description);

            Category category = new Category();
            category.setName(categoryName);
            ad.setCategory(category);

            ad.setType(adType);
            ad.setImageUrls(fileNames);
            if (!fileNames.isEmpty()) {
                ad.setImageUrl(fileNames.get(0));
            }

            if ("SALE".equals(adType) && price != null && !price.trim().isEmpty()) {
                ad.setPrice(new BigDecimal(price));
            } else {
                ad.setPrice(null);
            }

            String safeDelivery = (deliveryInfo != null && !deliveryInfo.trim().isEmpty()) ? deliveryInfo.trim()
                    : "Da concordare";
            ad.setLocation(safeDelivery); // Usiamo location per info consegna per semplicità

            boolean f = adControl.updateAd(ad);

            if (f) {
                session.setAttribute("succMsg", "Annuncio aggiornato con successo");
                response.sendRedirect("view_ad.jsp?adId=" + adId);
            } else {
                session.setAttribute("failedMsg", "Errore durante l'aggiornamento");
                response.sendRedirect("edit_ad.jsp?id=" + adId);
            }

        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("failedMsg", "Errore del server: " + e.getMessage());
            response.sendRedirect("my_ads.jsp");
        }
    }
}
