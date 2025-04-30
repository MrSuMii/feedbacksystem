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

@WebServlet("/FacultyFeedbackReport")
public class FacultyFeedbackReport extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        StringBuilder jsonOutput = new StringBuilder();
        jsonOutput.append("["); // Start JSON array

        try {
            // Database Connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/feedback_question", "root", "9920201752aA@");


            // Query to get feedback count for each rating
            String query = "SELECT rating, COUNT(*) as count FROM faculty_feedback GROUP BY rating";
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();

            boolean first = true;
            while (rs.next()) {
                if (!first) {
                    jsonOutput.append(","); // Add comma between objects
                }
                jsonOutput.append("{")
                          .append("\"rating\":").append(rs.getInt("rating")).append(",")
                          .append("\"count\":").append(rs.getInt("count"))
                          .append("}");
                first = false;
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        jsonOutput.append("]"); // End JSON array
        out.print(jsonOutput.toString());
        out.flush();
    }
}
