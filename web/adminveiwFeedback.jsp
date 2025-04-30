<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.DriverManager, java.sql.SQLException" %>
<%@ page import="java.util.Map, java.util.HashMap, java.util.LinkedHashMap" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Map.Entry" %>

<%
    // Database Connection Variables
    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    // Faculty-wise feedback summary (Average Score per Question)
    Map<String, Map<String, Double>> facultyFeedback = new HashMap<>();
    // Overall Question-wise average feedback scores
    Map<String, Double> questionAverages = new LinkedHashMap<>();

    try {
        // Load MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/feedback_question", "root", "9920201752aA@");

        // Faculty-wise average feedback per question
        String facultyAvgQuery = "SELECT faculty_name, question_id, AVG(response_value) AS avg_score " +
                                 "FROM feedback_responses GROUP BY faculty_name, question_id";
        pst = con.prepareStatement(facultyAvgQuery);
        rs = pst.executeQuery();

        while (rs.next()) {
            String facultyName = rs.getString("faculty_name");
            String questionId = "Q" + rs.getInt("question_id");
            double avgScore = rs.getDouble("avg_score");

            facultyFeedback.putIfAbsent(facultyName, new HashMap<>());
            facultyFeedback.get(facultyName).put(questionId, avgScore);
        }
        rs.close();
        pst.close();

        // Overall question-wise average feedback
        String avgFeedbackQuery = "SELECT question_id, AVG(response_value) AS avg_score FROM feedback_responses GROUP BY question_id";
        pst = con.prepareStatement(avgFeedbackQuery);
        rs = pst.executeQuery();

        while (rs.next()) {
            String questionId = "Q" + rs.getInt("question_id");
            double avgScore = rs.getDouble("avg_score");

            questionAverages.put(questionId, avgScore);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pst != null) try { pst.close(); } catch (SQLException ignored) {}
        if (con != null) try { con.close(); } catch (SQLException ignored) {}
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Faculty Feedback Report</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="viewfeedbacks.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                <h1>View Feedbacks</h1>
                <button class="logout-btn" onclick="window.location.href='logout.html';">Logout</button>
            </div>
            
</head>
<body>
    <h1>Faculty Feedback Report</h1>

    <div class="charts-container">
        <% for (Map.Entry<String, Map<String, Double>> facultyEntry : facultyFeedback.entrySet()) { %>
            <div class="chart-wrapper">
                <h2><%= facultyEntry.getKey() %> - Average Feedback</h2>
                <canvas id="chart_<%= facultyEntry.getKey().replaceAll("\\s+", "_") %>"></canvas>
            </div>
        <% } %>

        <div class="chart-wrapper">
            <h2>Overall Average Feedback Per Question</h2>
            <canvas id="feedbackChart"></canvas>
        </div>
    </div>

    <script>
        // Function to generate random colors
function getRandomColor(index) {
    const colors = [
        'rgba(255, 99, 132, 0.8)',  // Red
        'rgba(54, 162, 235, 0.8)',  // Blue
        'rgba(255, 206, 86, 0.8)',  // Yellow
        'rgba(75, 192, 192, 0.8)',  // Teal
        'rgba(153, 102, 255, 0.8)', // Purple
        'rgba(255, 159, 64, 0.8)'   // Orange
    ];
    return colors[index % colors.length];
}

// Function to create a gradient effect
function createGradient(ctx, color) {
    const gradient = ctx.createLinearGradient(0, 0, 0, 400);
    gradient.addColorStop(0, color.replace("0.8", "1"));
    gradient.addColorStop(1, color.replace("0.8", "0.2"));
    return gradient;
}

<% for (Map.Entry<String, Map<String, Double>> facultyEntry : facultyFeedback.entrySet()) { %>
    const ctx_<%= facultyEntry.getKey().replaceAll("\\s+", "_") %> = document.getElementById('chart_<%= facultyEntry.getKey().replaceAll("\\s+", "_") %>').getContext('2d');

    const labels_<%= facultyEntry.getKey().replaceAll("\\s+", "_") %> = [<% for (String question : facultyEntry.getValue().keySet()) { %>"<%= question %>", <% } %>];
    const data_<%= facultyEntry.getKey().replaceAll("\\s+", "_") %> = [<% for (double avg : facultyEntry.getValue().values()) { %><%= avg %>, <% } %>];

    const colors_<%= facultyEntry.getKey().replaceAll("\\s+", "_") %> = labels_<%= facultyEntry.getKey().replaceAll("\\s+", "_") %>.map((_, i) => getRandomColor(i));

    new Chart(ctx_<%= facultyEntry.getKey().replaceAll("\\s+", "_") %>, {
        type: 'bar',
        data: {
            labels: labels_<%= facultyEntry.getKey().replaceAll("\\s+", "_") %>,
            datasets: [{
                label: 'Average Rating',
                data: data_<%= facultyEntry.getKey().replaceAll("\\s+", "_") %>,
                backgroundColor: colors_<%= facultyEntry.getKey().replaceAll("\\s+", "_") %>.map((color, i) => createGradient(ctx_<%= facultyEntry.getKey().replaceAll("\\s+", "_") %>, color)),
                borderColor: colors_<%= facultyEntry.getKey().replaceAll("\\s+", "_") %>,
                borderWidth: 2,
                borderRadius: 8
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    backgroundColor: "#000",
                    bodyColor: "#fff",
                    titleColor: "#fff",
                    titleFont: { size: 16, weight: 'bold' },
                    bodyFont: { size: 14 }
                }
            },
            scales: {
                x: {
                    grid: { display: false }
                },
                y: {
                    beginAtZero: true,
                    max: 5,
                    stepSize: 1,
                    grid: { color: "rgba(200, 200, 200, 0.2)" }
                }
            }
        }
    });
<% } %>

// Overall Average Feedback Chart
const ctx = document.getElementById('feedbackChart').getContext('2d');
const overallLabels = [<% for (String question : questionAverages.keySet()) { %>"<%= question %>", <% } %>];
const overallData = [<% for (double avg : questionAverages.values()) { %><%= avg %>, <% } %>];

const overallColors = overallLabels.map((_, i) => getRandomColor(i));

new Chart(ctx, {
    type: 'bar',
    data: {
        labels: overallLabels,
        datasets: [{
            label: 'Overall Average Score',
            data: overallData,
            backgroundColor: overallColors.map((color, i) => createGradient(ctx, color)),
            borderColor: overallColors,
            borderWidth: 2,
            borderRadius: 8
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: {
                display: false
            },
            tooltip: {
                backgroundColor: "#000",
                bodyColor: "#fff",
                titleColor: "#fff",
                titleFont: { size: 16, weight: 'bold' },
                bodyFont: { size: 14 }
            }
        },
        scales: {
            x: {
                grid: { display: false }
            },
            y: {
                beginAtZero: true,
                max: 5,
                stepSize: 1,
                grid: { color: "rgba(200, 200, 200, 0.2)" }
            }
        }
    }
});

    </script>
</body>
</html>
