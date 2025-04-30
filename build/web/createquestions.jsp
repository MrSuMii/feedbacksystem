<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Feedback Questions</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="createquestions.css" class="rel">
    <style>
        /* Insert your CSS styling here */
                 /* General styles */
  body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #c850c0, #4158d0);
    margin: 0;
    padding: 0;
    height: 100vh; /* Ensures full height */
    display: flex;
}

/* Container styles */
.container {
    display: flex;
    width: 100%;
    height: 100vh; /* Full height for both sidebar and content */
}

/* Sidebar Styles */
.sidebar {
    background: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(10px);
    color: white;
    width: 260px;
    padding: 20px;
    display: flex;
    flex-direction: column;
    justify-content: flex-start; /* Aligns sidebar content to the top */
    height: 100%; /* Makes the sidebar take full height */
    border-radius: 15px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
}

.user-info {
    text-align: center;
}

.user-info img {
    border-radius: 50%;
    width: 80px;
    margin-bottom: 15px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.menu {
    margin-top: 40px; /* Move menu down */
    flex-grow: 1; /* Fills remaining space in the sidebar */
}

.menu ul {
    list-style-type: none;
    padding: 0;
}

.menu ul li {
    margin: 20px 0;
}

.menu ul li a {
    text-decoration: none;
    color: white;
    font-size: 18px;
    display: flex;
    align-items: center;
    transition: all 0.3s ease;
}

.menu ul li a:hover {
    transform: translateX(10px);
    color: #f39c12;
}

.menu ul li a i {
    margin-right: 12px;
}

/* Content styles */
.content {
    flex-grow: 1; /* Makes content container grow to fill the available space */
    padding: 40px;
    color: white;
    display: flex;
    flex-direction: column;
    height: auto;
    overflow-y: auto; /* Ensures content can scroll if it overflows */
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}

.header h1 {
    font-size: 28px;
    font-weight: 600;
}

.logout-btn {
    background: #e74c3c;
    color: white;
    border: none;
    padding: 12px 25px;
    border-radius: 10px;
    font-size: 14px;
    cursor: pointer;
    box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
    transition: all 0.3s ease;
}

.logout-btn:hover {
    background: #c0392b;
    box-shadow: 0 6px 20px rgba(192, 57, 43, 0.3);
}

/* Welcome message */
.welcome {
    font-size: 24px;
    margin-bottom: 20px;
}

/* Form section styles */
.form-section {
    margin-top: 20px;
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
    padding: 20px;
    border-radius: 15px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
}

.form-section h2 {
    margin-bottom: 20px;
    color: #f39c12;
}

/* Input field styles */
label {
    display: block;
    margin-bottom: 8px;
    color: #ffffff;
}

input[type="text"] {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ced4da;
    border-radius: 5px;
    transition: border-color 0.3s;
}

input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}

/* Button styles */
.button-container {
    display: flex;
    justify-content: space-between;
}

button {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 10px 15px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

button:hover {
    background-color: #0056b3;
}

/* Question section styles */
.question-section {
    margin-top: 30px;
}

.question-section h2 {
    margin-bottom: 20px;
    color: #f39c12;
}

#questionList {
    margin-bottom: 20px;
}

.question-block {
    margin-bottom: 15px;
    padding: 10px;
    border: 1px solid #ced4da;
    border-radius: 5px;
    background: rgba(255, 255, 255, 0.1);
}

.btn-container {
    margin-top: 10px;
}

.btn-container button {
    margin-right: 10px;
    background-color: #1254bf;
}

.btn-container button:hover {
    background-color: #218838;
}

.submit-btn {
    background-color: #28a745;
    width: 100%;
}

.submit-btn:hover {
    background-color: #218838;
}

/* Media queries for responsive design */
@media (max-width: 768px) {
    .sidebar {
        width: 200px;
    }

    .content {
        padding: 20px;
    }

    .dashboard-sections {
        flex-direction: column;
    }

    .dashboard-item {
        width: 100%;
        margin-bottom: 20px;
    }
}
        .question-input {
            margin-bottom: 20px;
            padding: 10px;
            
            border-radius: 5px;
        }
        .button-container {
            margin-top: 20px;
        }
        .question-block {
            margin-bottom: 15px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .options-container {
            margin-top: 10px;
        }
        .options-container label {
            display: block;
            margin: 5px 0;
        }
    </style>
</head>
<body>
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
                <h1>Create Feedback Questions</h1>
                <button class="logout-btn" onclick="window.location.href='logout.html';">Logout</button>
            </div>

            <div class="form-section">
                <h2>Add Questions</h2>
                <form action="AddQuestionServlet" method="post" id="questionForm">
                    <div id="questionContainer">
                        <div class="question-input">
                            <label for="question">Enter Question:</label>
                            <input type="text" name="question" required>
                         
                        </div>
                    </div>
                    <button type="button" onclick="addQuestionField()">Add Another Question</button>
                    <div class="button-container">
                        <button type="submit">Submit Questions</button>
                    </div>
                </form>
            </div>

            <div class="question-section">
                
                <div id="questionList">
                    <%
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/feedback_question", "username", "password");
                            stmt = conn.createStatement();
                            String sql = "SELECT * FROM questions";
                            rs = stmt.executeQuery(sql);
                            while (rs.next()) {
                                out.println("<div class='question-block'>");
                                out.println("<strong>" + rs.getString("question_text") + "</strong><br>");

                                // Split options by comma and render as radio buttons
                                String[] options = rs.getString("options").split(",");
                                out.println("<div class='options-container'>");
                                for (String option : options) {
                                    out.println("<label><input type='radio' name='question_" + rs.getInt("id") + "' value='" + option.trim() + "'> " + option.trim() + "</label>");
                                }
                                out.println("</div>");
                                out.println("</div>");
                            }
                        } catch (SQLException se) {
                            se.printStackTrace();
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            } catch (SQLException se) {
                                se.printStackTrace();
                            }
                        }
                    %>
                </div>
            </div>
        </div>
    </div>

    <script>
        function addQuestionField() {
            const container = document.getElementById("questionContainer");
            const newQuestionInput = document.createElement("div");
            newQuestionInput.className = "question-input";
            newQuestionInput.innerHTML = `
                <label for="question">Enter Question:</label>
                <input type="text" name="question" required>
              
            `;
            container.appendChild(newQuestionInput);
        }
    </script>
</body>
</html>
