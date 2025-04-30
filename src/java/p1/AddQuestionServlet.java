package p1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddQuestionServlet")
public class AddQuestionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve arrays of questions and options from the form
        String[] questions = request.getParameterValues("question");
        String[] options = request.getParameterValues("options");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load the JDBC driver and establish a connection
            Class.forName("com.mysql.cj.jdbc.Driver");  // Ensure you're using the correct MySQL driver
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/feedback_question", "root", "9920201752aA@");

            // SQL query to insert a question
            String sql = "INSERT INTO questions (question_text) VALUES (?)";
            pstmt = conn.prepareStatement(sql);

            // Loop through the questions and options and add them to the batch
            for (int i = 0; i < questions.length; i++) {
                pstmt.setString(1, questions[i]);
//                pstmt.setString(2, options[i]);
                pstmt.addBatch(); // Add to batch for bulk insertion
            }

            // Execute the batch insert
            pstmt.executeBatch();

            // Redirect to viewquestion.jsp after successful insertion
            response.sendRedirect("questionslist.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Handle any errors appropriately (e.g., show an error page or message)
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error while processing the request.");
        } finally {
            // Close resources
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
