/*package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import dao.AdminDAO;

public class AdminImageServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        AdminDAO dao = new AdminDAO();
        
        byte[] image = dao.getImageById(id);

        
        
        if (image != null) {
            response.setContentType("image/jpeg");


            response.getOutputStream().write(image);
        }
    }
}*/

package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import dao.AdminDAO;

public class AdminImageServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        if (id == null) return;

        AdminDAO dao = new AdminDAO();
        byte[] image = dao.getImageById(id);

        if (image != null) {

            response.setContentType("image/jpeg");
            response.setContentLength(image.length);

            OutputStream out = response.getOutputStream();
            out.write(image);
            out.flush();
        }
    }
}