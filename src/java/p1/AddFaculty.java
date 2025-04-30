package p1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Properties;
import java.util.Random;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import javax.mail.*;
import javax.mail.internet.*;

@WebServlet(name = "AddFaculty", urlPatterns = {"/AddFaculty"})
public class AddFaculty extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String program = request.getParameter("program");
        String semester = request.getParameter("semester");
        String courseName = request.getParameter("course-name");

        // Generate random username and password
        String username = generateUsername();
        String password = generatePassword();

        Connection conn = null;
        PreparedStatement checkStmt = null;
        PreparedStatement insertStmt = null;
        ResultSet rs = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_management", "root", "9920201752aA@");

            // Check if faculty already exists
            String checkSql = "SELECT * FROM faculty WHERE email = ?";
            checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, email);
            rs = checkStmt.executeQuery();

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            if (rs.next()) {
                // Faculty already exists
                out.println("<script>alert('Faculty already exists!'); window.location='managefaculty.jsp';</script>");
            } else {
                // Insert new faculty
                String insertSql = "INSERT INTO faculty (name, email, mobile, program, semester, courseName, username, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setString(1, name);
                insertStmt.setString(2, email);
                insertStmt.setString(3, mobile);
                insertStmt.setString(4, program);
                insertStmt.setString(5, semester);
                insertStmt.setString(6, courseName);
                insertStmt.setString(7, username);
                insertStmt.setString(8, password);

                int rowsInserted = insertStmt.executeUpdate();

                if (rowsInserted > 0) {
                    // Store email in session
                    HttpSession session = request.getSession();
                    session.setAttribute("facultyEmail", email);

                    // Send email with credentials
                    sendEmail(email, username, password);

                    out.println("<script>alert('Faculty added successfully and email sent!'); window.location='managefaculty.jsp';</script>");
                } else {
                    out.println("<h1>Failed to add faculty. Please try again.</h1>");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (checkStmt != null) checkStmt.close();
                if (insertStmt != null) insertStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Generate a random username
    private String generateUsername() {
        return "TCSC" + (1000 + new Random().nextInt(9000));
    }

    // Generate a random password
    private String generatePassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder password = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < 8; i++) {
            password.append(chars.charAt(random.nextInt(chars.length())));
        }
        return password.toString();
    }

    // Send email function
    private void sendEmail(String toEmail, String username, String password) {
        final String fromEmail = "tcsc.feedbacksys@gmail.com"; // Your Gmail address
        final String emailPassword = "xdysuxnrprjtinnb"; // Use app password
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, emailPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Faculty Account Created");

            String emailContent = "<h3>Dear Faculty,</h3>"
                    + "<p>Your faculty account has been created successfully.</p>"
                    + "<p><strong>Username:</strong> " + username + "</p>"
                    + "<p><strong>Password:</strong> " + password + "</p>"
                    + "<p>Please log in and change your password.</p>"
                    + "<br><p>Regards,<br>Admin Team</p>";

            message.setContent(emailContent, "text/html");

            Transport.send(message);
            System.out.println("Email sent successfully to " + toEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
