<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Set, java.util.HashSet" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback Form</title>

    <!-- Google Font: Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <link rel="stylesheet" href="feedback.css">
    <!-- Google Font: Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <link rel="stylesheet" href="feedback.css">
</head>
  <style>
        /* Add styling for the hamburger */
        .hamburger {
            font-size: 24px;
            cursor: pointer;
            background: none;
            border: none;
            color: #333;
            position: absolute;
            top: 15px;
            left: 15px;
            display: none; /* Hidden by default for larger screens */
        }

        /* Show hamburger on smaller screens */
        @media (max-width: 768px) {
            .hamburger {
                display: block;
            }

            .sidebar {
                position: fixed;
                left: -250px;
                width: 250px;
                height: 100%;
                background-color: #2c3e50;
                transition: left 0.3s ease-in-out;
            }

            .sidebar.open {
                left: 0;
            }
        }
        /* Stylish Submit Button */
button[type="submit"] {
    background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
    color: white;
    padding: 14px 35px;
    font-size: 18px;
    font-weight: 600;
    text-align: center;
    border: none;
    border-radius: 10px;
    cursor: pointer;
    transition: all 0.3s ease-in-out;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
    letter-spacing: 1px;
    text-transform: uppercase;
    display: inline-block;
    text-align: center;
}

button[type="submit"]:hover {
    background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
    transform: scale(1.05);
    box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.3);
}

button[type="submit"]:active {
    transform: scale(0.98);
    box-shadow: 0px 3px 6px rgba(0, 0, 0, 0.2);
}
.form-submit-container {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}
/* Question Styling */
.question {
    background-color: #ffffff;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
    transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
    position: relative;
}

/* Numbering for Questions */
.question::before {
    content: attr(data-question-number) " ";
    font-weight: bold;
    font-size: 20px;
    color: #1e3c72;
    position: absolute;
    left: 15px;
    top: 15px;
}

/* General Page Styling */
body {
    font-family: 'Poppins', sans-serif;
    background-color: #f4f6f8;
}

/* Question Container */
/* Question Styling */
.question {
    background-color: #ffffff;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
    display: flex;
    flex-direction: column; /* Ensure questions are stacked vertically */
    transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}

/* Numbering for Questions */
.question-number {
    font-weight: bold;
    font-size: 20px;
    color: #1e3c72;
    margin-right: 15px; /* Space between number and text */
    display: inline-block; /* Ensure it stays on the same line as the text */
}

/* Question Text */
.question label {
    font-size: 18px;
    font-weight: 600;
    color: #34495e;
    display: inline-block; /* Keeps the label on the same line as the number */
    margin-bottom: 12px;
}



/* Horizontal Layout for Options */
.options {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    gap: 10px; /* Reduced gap for compact layout */
}

/* Align Radio Buttons & Labels Properly */
.options input[type="radio"] {
    display: none; /* Hide Default Radio */
}

/* Custom Radio Button */
.options label {
    font-size: 16px;
    color: #2c3e50;
    cursor: pointer;
    transition: all 0.3s ease-in-out;
    display: flex;
    align-items: center;
    gap: 8px; /* Adjusted spacing */
    padding: 8px 12px;
    border-radius: 8px;
    position: relative;
}

/* Custom Radio Button Circle */
.options label::before {
    content: "";
    width: 18px;
    height: 18px;
    border-radius: 50%;
    border: 2px solid #1e3c72;
    display: inline-block;
    transition: all 0.3s ease-in-out;
}

/* Checked Effect */
.options input[type="radio"]:checked + label {
    background-color: #f4f6f8;
    color: #1e3c72;
    font-weight: bold;
    border-radius: 8px;
    padding: 8px 12px;
}

/* Fill Custom Radio When Selected */
.options input[type="radio"]:checked + label::before {
    background-color: #1e3c72;
    border: 5px solid white;
    box-shadow: inset 0 0 0 3px #1e3c72;
}

/* Centered Submit Button */
.form-submit-container {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}

button[type="submit"] {
    background-color: #1e3c72;
    color: white;
    padding: 12px 24px;
    font-size: 18px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.3s ease-in-out;
}

button[type="submit"]:hover {
    background-color: #162b5b;
}

/* 🌍 Responsive Fixes */
@media screen and (max-width: 768px) {
    .options {
        flex-direction: column; /* Stack options on smaller screens */
        gap: 6px;
    }

    .options label {
        padding: 10px;
        font-size: 16px;
    }

    .question-number {
        font-size: 18px;
    }

    .question label {
        font-size: 16px;
    }
}

.question label{
    margin-left: 15px;
}
    </style>

</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="user-info">
            <img src="account.png" alt="User Image" class="user-image">
            <h3>HELLO <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Username" %></h3>
        </div>
        <nav class="menu">
<ul>
                <li><a href="dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                <li><a href="feedback.jsp"><i class="fas fa-comment-dots"></i> Feedback</a></li>
                <li><a href="editprofile.jsp"><i class="fas fa-user-edit"></i> View/Edit Profile</a></li>
                <li><a href="studentupdatespass.jsp"><i class="fas fa-key"></i> Update Password</a></li>
                <li><a href="logoutstudent.html"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>
    </aside>

    <div class="content">
        <div class="header">
            <h1>Feedback Form</h1>
            <button class="logout-btn" onclick="logout()">Logout</button>
        </div>

        <div class="form-container">
            <form action="SubmitFeedbackServlet" method="post">
                <!-- Faculty Dropdown -->
                <!-- Faculty Dropdown -->
<div class="faculty-dropdown">
    <h3>Select Faculty</h3>
    <select name="faculty_email" required>
        <option value="">Select Faculty</option>
        <%
            String studentName = (String) session.getAttribute("username");
            if (studentName != null && !studentName.isEmpty()) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_management", "root", "9920201752aA@");

                    // Get student's course
                    String userQuery = "SELECT course FROM feedback_db.users WHERE username = ?";
                    PreparedStatement userPst = con.prepareStatement(userQuery);
                    userPst.setString(1, studentName);
                    ResultSet userRs = userPst.executeQuery();

                    String userCourse = null;
                    if (userRs.next()) {
                        userCourse = userRs.getString("course");
                    }

                    if (userCourse != null) {
                        // Fetch faculty list for the student's course
                        String facultyQuery = "SELECT email, name FROM faculty WHERE program = ?";
                        PreparedStatement facultyPst = con.prepareStatement(facultyQuery);
                        facultyPst.setString(1, userCourse);
                        ResultSet facultyRs = facultyPst.executeQuery();

                        // Fetch faculties the student has already given feedback to
                        String feedbackQuery = "SELECT faculty_email FROM feedback_question.feedback_responses WHERE student_name = ?";
                        PreparedStatement feedbackPst = con.prepareStatement(feedbackQuery);
                        feedbackPst.setString(1, studentName);
                        ResultSet feedbackRs = feedbackPst.executeQuery();

                        Set<String> givenFeedbackFaculties = new HashSet<>();
                        while (feedbackRs.next()) {
                            givenFeedbackFaculties.add(feedbackRs.getString("faculty_email"));
                        }

                        boolean hasFaculty = false;
                        while (facultyRs.next()) {
                            hasFaculty = true;
                            String facultyName = facultyRs.getString("name");
                            String facultyEmail = facultyRs.getString("email");
                            boolean alreadyGivenFeedback = givenFeedbackFaculties.contains(facultyEmail);
                        %>
                            <option value="<%= facultyEmail %>" <%= alreadyGivenFeedback ? "disabled style='text-decoration: line-through; color: grey;'" : "" %>>
                                <%= facultyName %> <%= alreadyGivenFeedback ? "(Feedback Given)" : "" %>
                            </option>
                        <%
                        }
                        if (!hasFaculty) {
                        %>
                            <option value="">No Faculty Found</option>
                        <%
                        }
                    } else {
                        out.println("<p style='color: red;'>Student course not found.</p>");
                    }
                    con.close();
                } catch (Exception e) {
                    out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
                }
            } else {
                out.println("<p style='color: red;'>Student name not found in session.</p>");
            }
        %>
    </select>
</div><br/>


                <!-- Feedback Form -->
                <div class="form-content">
                    <%
                        int questionNumber = 1;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/feedback_question", "root", "9920201752aA@");
                            String query = "SELECT * FROM questions";
                            PreparedStatement pst = con.prepareStatement(query);
                            ResultSet rs = pst.executeQuery();

                            while (rs.next()) {
                                int questionId = rs.getInt("id");
                                String questionText = rs.getString("question_text");
                    %>
                            <div class="question">
                                <span class="question-number"><%= questionNumber %>. <label> <%= questionText %></label></span>
                                <input type="hidden" name="questionId" value="<%= questionId %>">
                                <div class="options">
                                    <input type="radio" id="strongly_disagree_<%= questionId %>" name="response_<%= questionId %>" value="Strongly Disagree" required>
                                    <label for="strongly_disagree_<%= questionId %>">Strongly Disagree</label>
                                    
                                    <input type="radio" id="disagree_<%= questionId %>" name="response_<%= questionId %>" value="Disagree" required>
                                    <label for="disagree_<%= questionId %>">Disagree</label>
                                    
                                    <input type="radio" id="neutral_<%= questionId %>" name="response_<%= questionId %>" value="Neutral" required>
                                    <label for="neutral_<%= questionId %>">Neutral</label>
                                
                                    <input type="radio" id="agree_<%= questionId %>" name="response_<%= questionId %>" value="Agree" required>
                                    <label for="agree_<%= questionId %>">Agree</label>
                                    
                                    <input type="radio" id="strongly_agree_<%= questionId %>" name="response_<%= questionId %>" value="Strongly Agree" required>
                                    <label for="strongly_agree_<%= questionId %>">Strongly Agree</label>
                                </div>
                            </div>
                    <%
                                questionNumber++;
                            }
                            con.close();
                        } catch (Exception e) {
                            out.println("Error: " + e.getMessage());
                        }
                    %>

                    <!-- Submit Button -->
                    <div class="form-submit-container">
                        <button type="submit">Submit Feedback</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>