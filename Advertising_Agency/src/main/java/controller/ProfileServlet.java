package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("deleteProfile".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));

            if (userDAO.deleteUser(userId)) {
                session.invalidate(); // logout user
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            } else {
                request.setAttribute("error", "Failed to delete profile!");
                request.getRequestDispatcher("/profile.jsp").forward(request, response);
            }
        } else {
            // default: show profile
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Update user info
        int userId = user.getUserId();
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User updatedUser = new User(userId, name, email, password, user.getRole(), user.getStatus());

        if (userDAO.updateUser(updatedUser)) {
            session.setAttribute("user", updatedUser);
            request.setAttribute("msg", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Profile update failed!");
        }

        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }
}
