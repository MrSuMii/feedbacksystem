<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Feedback Questions</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="createquestions.css">
<
    <script>
        function enableEdit(id) {
            document.getElementById("questionText" + id).style.display = "none";
            document.getElementById("editInput" + id).style.display = "inline";
            document.getElementById("saveButton" + id).style.display = "inline";
            document.getElementById("removeButton" + id).style.display = "inline";
        }

        function saveEdit(id) {
            let newQuestion = document.getElementById("editInput" + id).value;
            let form = document.getElementById("editForm" + id);
            form.question_text.value = newQuestion;
            form.submit();
        }

        function removeQuestion(id) {
            if (confirm("Are you sure you want to delete this question?")) {
                let form = document.createElement("form");
                form.method = "POST";
                form.action = "questionslist.jsp";

                let input = document.createElement("input");
                input.type = "hidden";
                input.name = "remove_id";
                input.value = id;
                form.appendChild(input);

                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</head>
<body>
    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/feedback_question", "root", "9920201752aA@");

                // Handle Edit Question
                if (request.getParameter("question_id") != null && request.getParameter("question_text") != null) {
                    String questionId = request.getParameter("question_id");
                    String updatedText = request.getParameter("question_text");

                    if (!updatedText.trim().isEmpty()) {
                        String updateSql = "UPDATE questions SET question_text = ? WHERE id = ?";
                        pstmt = conn.prepareStatement(updateSql);
                        pstmt.setString(1, updatedText);
                        pstmt.setInt(2, Integer.parseInt(questionId));
                        pstmt.executeUpdate();
                    }
                }

                // Handle Remove Question
                if (request.getParameter("remove_id") != null) {
                    String removeId = request.getParameter("remove_id");
                    String deleteSql = "DELETE FROM questions WHERE id = ?";
                    pstmt = conn.prepareStatement(deleteSql);
                    pstmt.setInt(1, Integer.parseInt(removeId));
                    pstmt.executeUpdate();
                }

            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            } finally {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        }
    %>

    <div class="container">
        <aside class="sidebar">
            <div class="user-info">
                <img src="admin.png" alt="Admin Image" class="user-image">
                <h3>Admin Panel</h3>
            </div>
            <nav class="menu">
                <ul>
                    <li><a href="admin.html"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="addfaculty.html"><i class="fas fa-user-plus"></i> Add Faculty</a></li>
                    <li><a href="managefaculty.jsp"><i class="fas fa-users-cog"></i> Manage Faculty</a></li>
                    <li><a href="managestudents.html"><i class="fas fa-user-graduate"></i> Manage Students</a></li>
                    <li><a href="adminveiwFeedback.jsp"><i class="fas fa-comments"></i> View Feedbacks</a></li>
                    <li><a href="createquestions.jsp"><i class="fas fa-question-circle"></i> Create Feedback Questions</a></li>
                    <li><a href="questionslist.jsp"><i class="fas fa-edit"></i> Edit Question</a></li>
                    <li><a href="adminprofile.html"><i class="fas fa-user"></i> View/Edit Profile</a></li>
                    <li><a href="adminupdatepass.html"><i class="fas fa-key"></i> Update Password</a></li>
                    <li><a href="logoutstudent.html"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
            </nav>
        </aside>

        <div class="content">
            <div class="header">
                <h1>View Feedback Questions</h1>
                <button class="logout-btn" onclick="window.location.href='logout.html';">Logout</button>
            </div>

            <div class="question-section">
                <h2>Questions List</h2>
                <div id="questionList">
                    <%
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/feedback_question", "root", "9920201752aA@");
                            stmt = conn.createStatement();
                            String sql = "SELECT * FROM questions";
                            rs = stmt.executeQuery(sql);

                            while (rs.next()) {
                                int questionId = rs.getInt("id");
                                String questionText = rs.getString("question_text");

                                out.println("<div class='question-block'>");
                                out.println("<strong id='questionText" + questionId + "'>" + questionText + "</strong> ");
                                out.println("<input type='text' id='editInput" + questionId + "' value='" + questionText + "' style='display: none;'>");
                                out.println("<button onclick='enableEdit(" + questionId + ")'>Edit</button>");
                                out.println("<button id='saveButton" + questionId + "' style='display: none;' onclick='saveEdit(" + questionId + ")'>Save</button>");
                                out.println("<button id='removeButton" + questionId + "' style='display: none;' onclick='removeQuestion(" + questionId + ")'>Remove</button>");

                                out.println("<form id='editForm" + questionId + "' method='POST' action='' style='display: none;'>");
                                out.println("<input type='hidden' name='question_id' value='" + questionId + "'>");
                                out.println("<input type='hidden' name='question_text' value=''>");
                                out.println("</form>");
                                out.println("<div class='options-container'>");
                                out.println("<label><input type='radio' name='question_" + questionId + "' value='Strongly Agree'> Strongly Agree</label>");
                                out.println("<label><input type='radio' name='question_" + questionId + "' value='Agree'> Agree</label>");
                                out.println("<label><input type='radio' name='question_" + questionId + "' value='Neutral'> Neutral</label>");
                                out.println("<label><input type='radio' name='question_" + questionId + "' value='Disagree'> Disagree</label>");
                                out.println("<label><input type='radio' name='question_" + questionId + "' value='Strongly Disagree'> Strongly Disagree</label>");
                                out.println("</div>");
                                
                            
                                out.println("</div>");
                            }
                        } catch (SQLException se) {
                            se.printStackTrace();
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        }
                    %>
                </div>
            </div>
            <button class="dashboard-btn" onclick="window.location.href='admin.html';">PUBLISH</button>
        </div>
    </div>
</body>
</html>
