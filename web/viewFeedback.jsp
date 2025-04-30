<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Feedback Report</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      margin: 0;
      padding: 0;
      background: linear-gradient(135deg, #6a11cb, #2575fc);
      color: #333;
    }

    .container {
      display: flex;
      min-height: 100vh;
    }

    /* Sidebar */
    .sidebar {
      width: 250px;
      background: #1e1e2f;
      color: #fff;
      display: flex;
      flex-direction: column;
      align-items: center;
      padding-top: 20px;
      box-shadow: 2px 0 10px rgba(0, 0, 0, 0.2);
      position: fixed;
      left: 0;
      top: 0;
      height: 100%;
      transition: left 0.3s ease-in-out;
      z-index: 1000;
    }

    .sidebar ul {
      list-style: none;
      padding: 0;
      width: 100%;
    }

    .sidebar ul li {
      margin: 10px 0;
    }

    .sidebar ul li a {
      color: #ddd;
      font-size: 16px;
      text-decoration: none;
      padding: 10px 20px;
      display: flex;
      align-items: center;
      transition: 0.3s;
    }

    .sidebar ul li a:hover {
      color: #ffd700;
      background: #333;
      border-radius: 5px;
    }

    .sidebar ul li a i {
      font-size: 20px;
      margin-right: 10px;
      transition: 0.3s;
    }

    /* Main Content */
    .content {
      flex: 1;
      padding: 20px;
      margin-left: 250px;
      width: calc(100% - 250px);
      transition: margin-left 0.3s ease-in-out;
    }

    /* Header */
    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background: #1e1e2f;
      padding: 15px 20px;
      color: white;
      border-radius: 8px;
    }

    .logout-btn {
      background-color: #ff4d4d;
      color: #fff;
      border: none;
      padding: 10px 15px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 14px;
      font-weight: 500;
      transition: background-color 0.3s;
    }

    .logout-btn:hover {
      background-color: #ff1a1a;
    }

    /* Charts Section */
    .charts {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  align-items: center; /* Align items properly */
  gap: 20px;
}

.chart-box {
  width: 48%; /* Keep both charts side by side */
  background: white;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
  text-align: center;
  margin-bottom: 20px;
}

.full-width {
  width: 100%;
}

/* Responsive Design */
@media (max-width: 768px) {
  .chart-box {
    width: 100%; /* Stack charts on smaller screens */
  }
}


    .full-width {
      width: 100%;
    }

    canvas {
      max-width: 100%;
      height: auto;
    }

    /* Responsive */
    @media (max-width: 768px) {
      .content {
        margin-left: 0;
        width: 100%;
      }

      .chart-box {
        width: 100%;
      }

      .sidebar {
        left: -250px;
      }

      .sidebar.active {
        left: 0;
      }
    }
    

    .content {
  flex: 1;
  padding: 20px;
  margin-left: 250px; /* Push content to the right */
  width: calc(100% - 250px); /* Adjust width dynamically */
  transition: margin-left 0.3s ease-in-out;
}

@media (max-width: 768px) {
  .content {
    margin-left: 0; /* Content takes full width when sidebar is hidden */
    width: 100%;
  }
}


    .header h1 {
      margin: 0;
      font-size: 28px;
      color: #fff;
    }

    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }

    .logout-btn {
      background-color: #ff4d4d;
      color: #fff;
      border: none;
      padding: 10px 15px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 14px;
      font-weight: 500;
      transition: background-color 0.3s;
    }

    .logout-btn:hover {
      background-color: #ff1a1a;
    }

    /* Hamburger Button */
    .hamburger {
  position: absolute;
  top: 15px;
  left: 15px; /* Adjust for better spacing */
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  color: #fff;
  z-index: 1100;
}

/* Sidebar heading adjustment */
.sidebar h3 {
  font-size: 22px; /* Default size */
  text-align: center;
  
  padding: 0 15px;
  transition: font-size 0.3s;
}

@media (max-width: 768px) {
  .hamburger {
    left: 10px; /* Adjust position */
  }

  .sidebar h3 {
    font-size: 16px; /* Make text smaller on small screens */

    margin-top: 70px; /* Increase space below hamburger */
  }
  .header h1{
    margin-left: 25px;
  }
}



@media (max-width: 768px) {
    .hamburger {
        display: block;
        margin-top: 26px;
        margin-left: 10px;
    }

      
      .sidebar {
        position: fixed;
        left: -250px;
        top: 0;
        width: 250px;
        height: 100%;
      }

      .sidebar.active {
        left: 0;
      }

      .content {
        margin-left: 0;
      }

      .sidebar ul li a {
        font-size: 18px;
      }
    }

    .faculty-container {
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .faculty-image {
      max-width: 100%;
      height: auto;
      border-radius: 10px;
    }
    @media (max-width: 430px) {
  .logout-btn {
    display: none;
  }
}
@media (min-width: 769px) {
  .hamburger {
    display: none;
  }
}
.profile-info {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: 100%;

}

.profile-info img {
  border-radius: 50%;
  width: 100px;
  height: 100px;
  display: block;
}
.sidebar {
  position: fixed;
  left: -250px; /* Initially hidden */
  transition: left 0.3s ease-in-out;
}

.sidebar.active {
  left: 0; /* Sidebar opens */
}

@media (min-width: 769px) {
  .sidebar {
    left: 0 !important; /* Always visible on large screens */
  }
}
  </style>
</head>
<body>


<form action="FacultyFeedbackReport" method="get">
  <div class="container">
    <button class="hamburger" id="hamburger-menu">
      <i class="fas fa-bars"></i>
    </button>
    <aside class="sidebar" id="sidebar">
      <div class="profile-info">
        <img src="faculty.jpg" alt="Profile Image" class="profile-pic">
        <h3>HELLO SUMIT</h3>
      </div>
      <nav class="menu">
    <ul>
          <li><a href="faculty.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
          <li><a href="viewFeedback.jsp"><i class="fas fa-comments"></i> View Feedback</a></li>
          <li><a href="profile.html"><i class="fas fa-user-edit"></i> Edit Profile</a></li>
          <li><a href="updatepass.html"><i class="fas fa-key"></i> Update Password</a></li>
          <li><a href="logoutfaculty.html"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
      </nav>
    </aside>

<!-- Main Content -->
    <div class="content">
      <div class="header">
        <h1>Feedback Report</h1>
        <button class="logout-btn" onclick="window.location.href='logoutfaculty.jsp';">Logout</button>
      </div>

<%
    // ✅ 1. Retrieve faculty name from session
    String facultyName = (String) session.getAttribute("facultyName");

    if (facultyName == null) {
        response.sendRedirect("index.html"); // Redirect if not logged in
        return;
    }

    // ✅ 2. Initialize variables
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    List<String> questionLabels = new ArrayList<>();
    List<Double> responseScores = new ArrayList<>();

    try {
        // ✅ 3. Database Connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/feedback_question", "root", "9920201752aA@");

        // ✅ 4. SQL Query - Fetch Faculty-Specific Feedback
        String sql = "SELECT question_id, COALESCE(AVG(response_value), 0) AS avg_score FROM feedback_responses WHERE faculty_name = ? GROUP BY question_id";
        ps = conn.prepareStatement(sql);
        ps.setString(1, facultyName);
        rs = ps.executeQuery();

        // ✅ 5. Process Result Set
        while (rs.next()) {
            questionLabels.add("Q" + rs.getInt("question_id"));
            responseScores.add(rs.getDouble("avg_score"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }

    // ✅ 6. Convert Java Lists to JavaScript-friendly format
    String labelsJs = questionLabels.isEmpty() ? "[]" : "['" + String.join("','", questionLabels) + "']";
    String scoresJs = responseScores.toString();

    // ✅ 7. Debugging Output (Remove after checking)
    
%>

<h2>Welcome, <%= facultyName %>!</h2>
<h3>Your Feedback Report</h3>
<div class="chart-container">
    <canvas id="feedbackChart"></canvas>
</div>

<script>
    // ✅ 1. Convert JSP Data to JavaScript
var questions = <%= labelsJs %>;
var scores = JSON.parse('<%= scoresJs.replace("[", "[").replace("]", "]") %>');

console.log("📊 Questions:", questions);
console.log("📊 Scores:", scores);

// ✅ 2. Ensure Chart Renders Even if No Data
if (questions.length === 0 || scores.length === 0) {
    alert("No feedback data available!");
} else {
    var ctx = document.getElementById("feedbackChart").getContext("2d");

    // ✅ 3. Generate Different Colors for Each Bar
    var dynamicColors = questions.map(() => {
        return `rgba(${Math.floor(Math.random() * 255)}, ${Math.floor(Math.random() * 255)}, ${Math.floor(Math.random() * 255)}, 0.7)`;
    });

    // ✅ 4. Create Gradient for Background Effect
    var gradient = ctx.createLinearGradient(0, 0, 0, 400);
    gradient.addColorStop(0, "rgba(75, 192, 192, 0.9)");
    gradient.addColorStop(1, "rgba(153, 102, 255, 0.9)");

    // ✅ 5. Render Chart with Trendy UI
    new Chart(ctx, {
        type: "bar",
        data: {
            labels: questions,
            datasets: [{
                label: "Average Response Score",
                data: scores,
                backgroundColor: dynamicColors,
                borderColor: dynamicColors.map(color => color.replace("0.7", "1")), // Darker border
                borderWidth: 2,
                hoverBackgroundColor: gradient, // Gradient on hover
                hoverBorderWidth: 3
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: false // Hide legend for cleaner UI
                },
                tooltip: {
                    backgroundColor: "#fff",
                    titleColor: "#333",
                    bodyColor: "#555",
                    borderWidth: 1,
                    borderColor: "#ddd",
                    padding: 10
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    max: 5,
                    grid: {
                        color: "rgba(200, 200, 200, 0.3)"
                    }
                },
                x: {
                    grid: {
                        display: false
                    }
                }
            }
        }
    });
}

</script>

</body>
</html>
