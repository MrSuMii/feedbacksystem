package p1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CheckPasswordUpdateServlet", urlPatterns = {"/CheckPasswordUpdateServlet"})
public class CheckPasswordUpdateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        response.setContentType("text/plain");
        
        HttpSession session = request.getSession();
        String facultyUsername = (String) session.getAttribute("facultyUsername");

        if (facultyUsername == null) {
            response.getWriter().write("unauthorized");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_management", "root", "9920201752aA@");

            // ✅ Check if the password has been changed
            String sql = "SELECT password FROM faculty WHERE username=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, facultyUsername);
            rs = ps.executeQuery();

            if (rs.next()) {
                String password = rs.getString("password");

                if ("default123".equals(password)) { // ✅ Replace 'default123' with the default password set by the admin
                    response.getWriter().write("update_required");
                } else {
                    response.getWriter().write("updated");
                }
            }

        } catch (Exception e) {
            response.getWriter().write("error");
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
