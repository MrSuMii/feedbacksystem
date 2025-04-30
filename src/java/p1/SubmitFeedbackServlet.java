package p1;

import java.io.IOException;
import java.sql.*;
import java.util.Enumeration;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/SubmitFeedbackServlet")
public class SubmitFeedbackServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection con = null;
        PreparedStatement pst = null;
        PreparedStatement checkPst = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/feedback_question", "root", "9920201752aA@");

            // Retrieve the selected faculty email from the dropdown
            String facultyEmail = request.getParameter("faculty_email");

            if (facultyEmail == null || facultyEmail.isEmpty()) {
                response.getWriter().println("Error: Faculty not selected.");
                return;
            }

            // Get student name from session
            HttpSession session = request.getSession();
            String studentName = (String) session.getAttribute("username");

            if (studentName == null || studentName.isEmpty()) {
                response.getWriter().println("Error: Student not logged in.");
                return;
            }

            // **Check if student has already given feedback to this faculty**
            String checkFeedbackQuery = "SELECT COUNT(*) FROM feedback_responses WHERE student_name = ? AND faculty_email = ?";
            checkPst = con.prepareStatement(checkFeedbackQuery);
            checkPst.setString(1, studentName);
            checkPst.setString(2, facultyEmail);
            ResultSet checkRs = checkPst.executeQuery();
            checkRs.next();

            if (checkRs.getInt(1) > 0) {
                response.getWriter().println("Error: You have already given feedback to this faculty.");
                return;
            }

            // Fetch the faculty name using the selected faculty email
            String facultyName = null;
            String facultyQuery = "SELECT name FROM faculty_management.faculty WHERE email = ?";
            PreparedStatement facultyPst = con.prepareStatement(facultyQuery);
            facultyPst.setString(1, facultyEmail);
            ResultSet facultyRs = facultyPst.executeQuery();

            if (facultyRs.next()) {
                facultyName = facultyRs.getString("name");
            } else {
                response.getWriter().println("Error: Faculty not found.");
                return;
            }

            // Query to insert feedback along with faculty name, email, and student name
            String insertQuery = "INSERT INTO feedback_responses (question_id, response_value, student_name, faculty_email, faculty_name) VALUES (?, ?, ?, ?, ?)";
            pst = con.prepareStatement(insertQuery);

            Enumeration<String> parameterNames = request.getParameterNames();
            while (parameterNames.hasMoreElements()) {
                String paramName = parameterNames.nextElement();

                if (paramName.startsWith("response_")) {  // Only process response fields
                    int questionId = Integer.parseInt(paramName.substring(9));  // Extract question ID from name
                    String responseText = request.getParameter(paramName);

                    // Map response text to numeric value
                    int responseValue = mapResponseToValue(responseText);

                    pst.setInt(1, questionId);
                    pst.setInt(2, responseValue);
                    pst.setString(3, studentName);  // Store student name
                    pst.setString(4, facultyEmail); // Store faculty email
                    pst.setString(5, facultyName);  // Store faculty name
                    pst.executeUpdate();
                }
            }

            response.sendRedirect("feedback.jsp");  // Redirect to feedback page
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (checkPst != null) checkPst.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // Method to map response text to numeric value
    private int mapResponseToValue(String responseText) {
        switch (responseText) {
            case "Strongly Agree":
                return 5;
            case "Agree":
                return 4;
            case "Neutral":
                return 3;
            case "Disagree":
                return 2;
            case "Strongly Disagree":
                return 1;
            default:
                return 0; // Handle unexpected input
        }
    }
}
