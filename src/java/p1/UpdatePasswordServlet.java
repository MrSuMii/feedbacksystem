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

@WebServlet("/UpdatePasswordServlet")
public class UpdatePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // ✅ Retrieve student email from session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            showAlert(out, "error", "Session Expired! Please log in again.", "index.html");
            return;
        }

        String studentEmail = (String) session.getAttribute("username");

        // ✅ Get password inputs from form
        String oldPassword = request.getParameter("old-password");
        String newPassword = request.getParameter("new-password");
        String confirmPassword = request.getParameter("confirm-password");

        if (oldPassword == null || newPassword == null || confirmPassword == null || 
            oldPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            showAlert(out, "error", "All fields are required!", "studentupdatespass.jsp");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            showAlert(out, "warning", "New password and confirm password do not match!", "studentupdatespass.jsp");
            return;
        }

        Connection con = null;
        PreparedStatement psCheck = null, psUpdate = null;
        ResultSet rs = null;

        try {
            // ✅ Connect to MySQL Database
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/feedback_db", "root", "9920201752aA@");

            // ✅ Verify the old password for the specific user
            String query = "SELECT password FROM users WHERE username = ? AND password = ?";
            psCheck = con.prepareStatement(query);
            psCheck.setString(1, studentEmail);
            psCheck.setString(2, oldPassword);
            rs = psCheck.executeQuery();

            if (!rs.next()) {  // If old password does not match for this user
                showAlert(out, "error", "Incorrect old password!", "studentupdatespass.jsp");
                return;
            }

            // ✅ Update the password only if old password matches for the specific user
            String updateQuery = "UPDATE users SET password = ? WHERE username = ? AND password = ?";
            psUpdate = con.prepareStatement(updateQuery);
            psUpdate.setString(1, newPassword);
            psUpdate.setString(2, studentEmail);
            psUpdate.setString(3, oldPassword);
            int updateStatus = psUpdate.executeUpdate();

            if (updateStatus > 0) {
                showAlert(out, "success", "Password updated successfully!", "dashboard.jsp");
            } else {
                showAlert(out, "error", "Password update failed!", "studentupdatespass.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            showAlert(out, "error", "An error occurred. Please try again later.", "studentupdatespass.jsp");
        } finally {
            try {
                if (rs != null) rs.close();
                if (psCheck != null) psCheck.close();
                if (psUpdate != null) psUpdate.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // ✅ Utility method for SweetAlert2
    // ✅ Updated SweetAlert2 method with response completion
private void showAlert(PrintWriter out, String icon, String message, String redirectUrl) {
    out.println("<!DOCTYPE html>");
    out.println("<html><head>");
    out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
    out.println("</head><body>");
    out.println("<script>");
    out.println("Swal.fire({ icon: '" + icon + "', title: '" + message + "', confirmButtonText: 'OK' })");
    out.println(".then(() => { window.location='" + redirectUrl + "'; });");
    out.println("</script>");
    out.println("</body></html>");
    out.flush(); // ✅ Ensures the response is sent properly
}

    }

