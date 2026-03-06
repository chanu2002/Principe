package controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import dao.UserDAO;
import model.User;

public class UserRegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        User user = new User();
        user.setUsername(request.getParameter("username"));
        user.setPassword(request.getParameter("password"));
        user.setName(request.getParameter("name"));
        user.setEmail(request.getParameter("email"));
        user.setTelNo(request.getParameter("tel"));
        user.setAddress(request.getParameter("address"));

        UserDAO dao = new UserDAO();

        if (dao.insert(user)) {
        	// After saving user successfully in database
        	response.sendRedirect(request.getContextPath() 
        	        + "/views/register.jsp?success=1");
        } else {
            response.sendRedirect("views/register.jsp?error=1");
        }
    }
}