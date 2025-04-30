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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
        /* Slider Container - Adjust height dynamically */
/* Slider Container - Adjust height dynamically */
  /* Slider Container */
.slider-container {
  position: relative;
  width: 100%;
  max-height: 500px;
  overflow: hidden;
  border-radius: 10px;
  margin-top: 20px;
  margin-bottom: 20px;
}

/* Slider Wrapper */
.slider {
  display: flex;
  width: 400%; /* Ensures images are in a row */
  transition: transform 0.5s ease-in-out;
}

/* Individual Slides */
.slide {
  width: 100%;
  height: auto;
  max-height: 500px;
  object-fit: cover;
  cursor: pointer;
}

/* Navigation Arrows */
.prev, .next {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  background: rgba(0, 0, 0, 0.5);
  color: #fff;
  border: none;
  padding: 12px;
  cursor: pointer;
  border-radius: 50%;
  font-size: 20px;
  transition: 0.3s;
}

.prev {
  left: 10px;
}

.next {
  right: 10px;
}

.prev:hover, .next:hover {
  background: rgba(0, 0, 0, 0.8);
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
        <h3>HELLO <%= session.getAttribute("username") != null ? session.getAttribute("username") : "User" %></h3>
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
        <h1>Student Dashboard</h1>
        <button class="logout-btn" onclick="window.location.href='logoutstudent.html';">Logout</button>
      </div>

      <div class="welcome">
        <h2>Welcome, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "User" %></h2>
        
      </div>
        <div class="slider-container">
        <div class="slider">
          <img src="faculty.jpg" alt="Slide 1" class="slide">
          <img src="account.jpeg" alt="Slide 2" class="slide">
          <img src="faculty.jpg" alt="Slide 3" class="slide">
          <img src="account.jpeg" alt="Slide 4" class="slide">
        </div>
        <!-- Navigation Arrows -->
        <button class="prev" onclick="prevSlide()">&#10094;</button>
        <button class="next" onclick="nextSlide()">&#10095;</button>
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
      let currentIndex = 0;
const slider = document.querySelector(".slider");
const slides = document.querySelectorAll(".slide");
const totalSlides = slides.length;

// Function to Show Next Slide
function nextSlide() {
  if (currentIndex < totalSlides - 1) {
    currentIndex++; // Move to next image
  } else {
    currentIndex = 0; // Restart from first image
  }
  updateSlider();
}

// Function to Show Previous Slide
function prevSlide() {
  if (currentIndex > 0) {
    currentIndex--; // Move to previous image
  } else {
    currentIndex = totalSlides - 1; // Go to last image
  }
  updateSlider();
}

// Function to Update Slider Position
function updateSlider() {
  const translateX = -currentIndex * 100; // Move by full width
  slider.style.transform = `translateX(${translateX}%)`;
}

// Auto Slide Every 3 Seconds
setInterval(nextSlide, 3000);
    function logout() {
        // Show custom message
        alert("Thank you for using the Faculty Management System. Have a great day!");
        
        // Close the current tab
        window.close();
        
        // If window.close() is blocked, redirect to home page
        window.location.href = "index.html";
    }
  </script>

</body>
</html>
