<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <link rel="stylesheet" href="dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    
    <style>
        /* Basic styling */
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            height: 100vh;
            background-color: #f5f5f5;
        }

        /* Container holding both sidebar and content */
        .container {
            display: flex;
            flex-grow: 1;
        }

        /* Sidebar styling */
        .sidebar {
            background-color: #2c3e50;
            color: white;
            width: 250px;
            height: 100%;
            position: fixed;
            left: -250px; /* Initially hidden */
            transition: left 0.3s ease-in-out;
            padding-top: 20px;
        }

        .sidebar.open {
            left: 0; /* Show the sidebar when 'open' class is added */
        }

        .user-info {
            text-align: center;
        }

        .user-info img {
            width: 70px;
            border-radius: 50%;
            margin-bottom: 10px;
        }

        .user-info h3 {
            font-size: 18px;
        }

        .menu ul {
            list-style: none;
            padding: 0;
            margin-top: 20px;
        }

        .menu ul li {
            margin: 15px 0;
        }

        .menu ul li a {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            padding: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .menu ul li a:hover {
            background-color: #34495e;
            transform: translateX(10px);
        }

        .content {
            margin-left: 0;
            padding: 20px;
            flex-grow: 1;
            transition: margin-left 0.3s ease;
        }

        .content.open {
            margin-left: 250px; /* Shift content when sidebar is open */
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            font-size: 24px;
        }

        .logout-btn {
            background-color: #e74c3c;
            border: none;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }

        .hamburger {
            font-size: 30px;
            background: none;
            border: none;
            color: #333;
            cursor: pointer;
            position: absolute;
            top: 20px;
            left: 20px;
            display: none; /* Hidden by default for larger screens */
        }

        /* Show hamburger on smaller screens */
        @media (max-width: 768px) {
            .hamburger {
                display: block;
            }
        }

    </style>
</head>

<body>

  <div class="container">
    
    <!-- Hamburger button -->
    <button class="hamburger" id="hamburger">
        <i class="fas fa-bars"></i>
    </button>

    <!-- Sidebar with Font Awesome icons -->
    <aside class="sidebar" id="sidebar">
      <div class="user-info">
        <img src="account.png" alt="User Image" class="user-image">
        <h3>HELLO <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Username" %></h3>
      </div>
      <nav class="menu">
            <ul>
                <li><a href="dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                <li><a href="feedback.jsp"><i class="fas fa-comment-dots"></i> Feedback</a></li>
                <li><a href="editprofile.jsp"><i class="fas fa-user-edit"></i> View/Edit Profile</a></li>
                <li><a href="adminupdatepass.jsp"><i class="fas fa-key"></i> Update Password</a></li>
            </ul>
      </nav>
    </aside>

    <!-- Main content -->
    <div class="content">
      <div class="header">
        <h1>Student Dashboard</h1>
        <button class="logout-btn" onclick="logout()">Logout</button>
      </div>

      <div class="welcome">
        <h2>Welcome, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "User" %></h2>
        <p>Here's a quick overview of your current status:</p>
      </div>

      <div class="dashboard-sections">
        <!-- Wider course section -->
        <div class="dashboard-item courses">
          <h3>Your Courses</h3>
          <ul>
            <li>Mathematics</li>
            <li>Physics</li>
            <li>Computer Science</li>
          </ul>
        </div>

        <div class="dashboard-item assignments">
          <h3>Upcoming Assignments</h3>
          <ul>
            <li>Mathematics - Due Oct 5</li>
            <li>Physics Lab Report - Due Oct 10</li>
            <li>CS Project - Due Oct 15</li>
          </ul>
        </div>

        <div class="dashboard-item announcements">
          <h3>Latest Announcements</h3>
          <ul>
            <li>Mid-term exams schedule released</li>
            <li>New CS lecture uploaded</li>
            <li>Physics lab session rescheduled</li>
          </ul>
        </div>
      </div>
    </div>
  </div>

  <script>
    // Hamburger toggle functionality
    document.getElementById("hamburger").addEventListener("click", function() {
        document.getElementById("sidebar").classList.toggle("open");
        document.querySelector(".content").classList.toggle("open"); // Adjust content
    });

    function logout() {
        // Show custom message
        alert("Thank you for using the Student Dashboard. Have a great day!");
        
        // Close the current tab
        window.close();
        
        // If window.close() is blocked, redirect to home page
        window.location.href = "index.html";
    }
  </script>

</body>
</html>
