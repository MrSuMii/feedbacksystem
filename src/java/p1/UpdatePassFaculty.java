package p1;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/UpdatePassFaculty")
public class UpdatePassFaculty extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // ✅ Retrieve faculty email from session
        HttpSession session = request.getSession(false); // Do not create a new session
        if (session == null) {
            out.println("<script>alert('Session expired! Please log in again.'); window.location='index.html';</script>");
            return;
        }

        String facultyEmail = (String) session.getAttribute("facultyEmail");
        if (facultyEmail == null || facultyEmail.isEmpty()) {
            out.println("<script>alert('Session expired! Please log in again.'); window.location='index.html';</script>");
            return;
        }

        String oldPassword = request.getParameter("old-password");
        String newPassword = request.getParameter("new-password");
        String confirmPassword = request.getParameter("confirm-password");

        if (!newPassword.equals(confirmPassword)) {
            out.println("<script>alert('New password and confirm password do not match!'); window.location='updatepass.html';</script>");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_management", "root", "9920201752aA@");

            // ✅ Verify the old password (no hashing)
            PreparedStatement ps = con.prepareStatement("SELECT password FROM faculty WHERE email = ?");
            ps.setString(1, facultyEmail);
            ResultSet rs = ps.executeQuery();

            if (rs.next() && !rs.getString("password").equals(oldPassword)) {
                out.println("<script>alert('Incorrect old password!'); window.location='updatepass.html';</script>");
                return;
            }

            // ✅ Update the password
            PreparedStatement psUpdate = con.prepareStatement("UPDATE faculty SET password = ? WHERE email = ?");
            psUpdate.setString(1, newPassword);
            psUpdate.setString(2, facultyEmail);
            psUpdate.executeUpdate();

            out.println("<script>alert('Password updated successfully!'); window.location='faculty.html';</script>");
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
