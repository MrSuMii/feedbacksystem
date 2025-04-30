<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Feedback Form</title>
    <style>
        .question-section {
            display: flex;
            flex-direction: column;
        }

        .question {
            margin-bottom: 20px;
        }

        .rating-options label {
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <h1>Feedback Form</h1>
    <div class="question-section">
        <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/feedback_db", "username", "password");
            stmt = conn.createStatement();
            String sql = "SELECT * FROM questions";
            rs = stmt.executeQuery(sql);
            int questionNumber = 1;
            while(rs.next()) {
                String questionText = rs.getString("question_text");
                String[] options = rs.getString("options").split(",");
        %>
            <div class="question">
                <h2><%= questionNumber %>. <%= questionText %></h2>
                <div class="rating-options">
                    <% for(int i = 0; i < options.length; i++) { %>
                        <label><input type="radio" name="q<%= questionNumber %>" value="<%= i+1 %>"> <%= options[i].trim() %></label>
                    <% } %>
                </div>
            </div>
        <%
                questionNumber++;
            }
        } catch(SQLException se) {
            se.printStackTrace();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(rs != null) rs.close();
                if(stmt != null) stmt.close();
                if(conn != null) conn.close();
            } catch(SQLException se) {
                se.printStackTrace();
            }
        }
        %>
    </div>
    <button type="submit">Submit</button>

    <script>
        const questions = document.querySelectorAll('.question');
        const totalQuestions = questions.length;
        console.log("Total Questions: " + totalQuestions);

        // ... rest of the JavaScript remains the same

    </script>
</body>
</html>

