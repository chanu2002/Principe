package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import dao.UserDAO;

public class UserServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            String userIdStr = request.getParameter("userId");
            if (userIdStr != null) {
                int userId = Integer.parseInt(userIdStr);
                UserDAO dao = new UserDAO();
                dao.delete(userId);  // make sure delete() exists in UserDAO
            }
            response.sendRedirect(request.getContextPath() + "/views/admin/allusers.jsp");
        }
    }
}
