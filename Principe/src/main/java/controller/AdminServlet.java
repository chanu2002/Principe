package controller;

import java.io.IOException;
import java.io.InputStream;

import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import dao.AdminDAO;
import model.Admin;
@MultipartConfig(maxFileSize = 16177215) // 16MB

public class AdminServlet extends HttpServlet {
	
	
	protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
throws ServletException, IOException {

String action = request.getParameter("action");
AdminDAO dao = new AdminDAO();

if("delete".equals(action)){
String id = request.getParameter("adminId");
dao.delete(id);
response.sendRedirect("views/admin/listAdmins.jsp");
}
}

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        String action = request.getParameter("action");
        AdminDAO dao = new AdminDAO();

        if ("add".equals(action)) {

            Admin admin = new Admin();
            admin.setAdminId(request.getParameter("adminId"));
            admin.setUsername(request.getParameter("username"));
            admin.setPassword(request.getParameter("password"));
            admin.setName(request.getParameter("name"));
            admin.setRole(request.getParameter("role"));

         // IMAGE UPLOAD
            Part filePart = request.getPart("image");

            if (filePart != null && filePart.getSize() > 0) {
                InputStream inputStream = filePart.getInputStream();
                admin.setImage(inputStream.readAllBytes());
            }

            dao.insert(admin);

            response.sendRedirect(request.getContextPath() + "/views/admin/addAdmin.jsp?success=1");
            
            
        } else if ("update".equals(action)) {

        	Admin admin = new Admin();
            admin.setAdminId(request.getParameter("adminId"));
            admin.setUsername(request.getParameter("username"));
            admin.setPassword(request.getParameter("password"));
            admin.setName(request.getParameter("name"));
            admin.setRole(request.getParameter("role"));
            Part filePart = request.getPart("image");

            if (filePart != null && filePart.getSize() > 0) {

                InputStream inputStream = filePart.getInputStream();
                byte[] imageBytes = inputStream.readAllBytes();

                admin.setImage(imageBytes);
            }
            

            dao.update(admin);

            response.sendRedirect(request.getContextPath() +
                    "/views/admin/listAdmins.jsp");

        } else if ("delete".equals(action)) {

            String id = request.getParameter("adminId");
            dao.delete(id);
            response.sendRedirect("views/admin/listAdmins.jsp");
        }
    }
}