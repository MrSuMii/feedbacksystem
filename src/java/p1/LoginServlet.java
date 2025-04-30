package p1;

import jakarta.servlet.RequestDispatcher;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String uname = request.getParameter("username");
        String password = request.getParameter("password");

        HttpSession session = request.getSession(); // Ensure session is created

        // ✅ Admin Login
        if ("admin".equals(uname) && "admin".equals(password)) {
            session.setAttribute("role", "admin");
            response.sendRedirect("admin.html");
            return;
        }

        Connection userCon = null;
        Connection facultyCon = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // ✅ Check in feedback_db (users table)
            userCon = DriverManager.getConnection("jdbc:mysql://localhost:3306/feedback_db", "root", "9920201752aA@");
            String userQuery = "SELECT * FROM users WHERE username=? AND password=?";
            ps = userCon.prepareStatement(userQuery);
            ps.setString(1, uname);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                session.setAttribute("username", uname);
                session.setAttribute("role", rs.getString("role")); // Store user role
                session.setMaxInactiveInterval(30 * 60); // Session timeout: 30 minutes

                response.sendRedirect("dashboard.jsp");
                return;
            }

            rs.close();
            ps.close();
            userCon.close();

            // ✅ Check in faculty_management (faculty table)
            facultyCon = DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_management", "root", "9920201752aA@");
            String facultyQuery = "SELECT * FROM faculty WHERE username=? AND password=?";
            ps = facultyCon.prepareStatement(facultyQuery);
            ps.setString(1, uname);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                session.setAttribute("facultyName", rs.getString("name"));
                session.setAttribute("facultyUsername", uname);
                session.setAttribute("facultyEmail", rs.getString("email")); // ✅ Store email
                session.setMaxInactiveInterval(30 * 60); // Set session timeout: 30 minutes

                response.sendRedirect("faculty.jsp");
                return;
            }

            // ✅ If not found in either database
            out.println("<script>alert('Invalid Username or Password!'); window.location='singup.html';</script>");

        } catch (Exception e) {
            out.println("Database connection error: " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (userCon != null) userCon.close();
                if (facultyCon != null) facultyCon.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
