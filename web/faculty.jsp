<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Faculty Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    html, body {
      font-family: 'Poppins', sans-serif;
      height: 100%;
      overflow-x: hidden;
      background: linear-gradient(135deg, #6a11cb, #2575fc);
    }

    .container {
      display: flex;
      height: 100vh;
    }

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

    @media (max-width: 768px) {
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
      margin-left: 250px;
      overflow-y: auto;
      height: 100vh; /* Full height */
    }

    @media (max-width: 768px) {
      .content {
        margin-left: 0;
      }
    }

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

    .hamburger {
      position: absolute;
      top: 15px;
      left: 15px;
      background: none;
      border: none;
      font-size: 24px;
      cursor: pointer;
      color: #fff;
      z-index: 1100;
    }

    @media (max-width: 768px) {
      .header h1 {
        margin-left: 25px;
      }
    }

    /* Dashboard Cards */
    .dashboard {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
      margin-top: 20px;
    }

    .card {
      flex: 1;
      min-width: 250px;
      background: white;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      text-align: center;
      cursor: pointer;
      transition: transform 0.3s ease;
    }

    .card:hover {
      transform: scale(1.05);
    }

    .card i {
      font-size: 40px;
      margin-bottom: 10px;
      color: #6a11cb;
    }
/* Sidebar */
    .sidebar {
      width: 250px;
      background: #1e1e2f;
      color: #fff;
      display: flex;
      flex-direction: column;
      align-items: center;
      padding: 20px 0;
      box-shadow: 2px 0 10px rgba(0, 0, 0, 0.3);
      transform: translateX(-100%);
      transition: transform 0.3s ease;
    }

    .sidebar.active {
      transform: translateX(0);
    }

    .sidebar img {
      border-radius: 50%;
      width: 100px;
      margin-bottom: 10px;
    }

    .sidebar h3 {
      font-size: 18px;
      margin-bottom: 20px;
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
      margin-right: 10px;
    }
/* Slider Container - Full Width */
.slider-container {
  position: relative;
  width: 100%;
  overflow: hidden;
  border-radius: 10px;
  height: 100vh;
  margin-top: 20px;
}

/* Slider - Images Move One by One */
.slider {
  display: flex;
  transition: transform 1s ease-in-out;
  margin-bottom: 50px;
}

/* Each Image */
.slide {
  width: 100%;
  flex-shrink: 0;
}

/* Navigation Buttons */
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

.prev:hover, .next:hover {
  background: rgba(0, 0, 0, 0.8);
}

.prev {
  left: 10px;
}

.next {
  right: 10px;
}
/* Sidebar visibility */
.sidebar {
  width: 250px;
  background: #1e1e2f;
  color: #fff;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 20px 0;
  box-shadow: 2px 0 10px rgba(0, 0, 0, 0.3);
  position: fixed;
  left: 0;
  top: 0;
  height: 100%;
  transition: transform 0.3s ease;
}

/* By default, hide sidebar on smaller screens */
@media (max-width: 768px) {
  .sidebar {
    transform: translateX(-100%);
  }

  .sidebar.active {
    transform: translateX(0);
  }
  .hamburger{
      margin-top: 25px;
      margin-left: 10px;
  }
}

/* Always show sidebar on large screens */
@media (min-width: 769px) {
  .sidebar {
    transform: translateX(0) !important;
  }
  
  .hamburger {
    display: none; /* Hide hamburger icon on larger screens */
    
  }
}

/* Slider Container - Adjust height dynamically */
.slider-container {
  position: relative;
  width: 100%;
  max-height: 500px; /* Set a reasonable max height */
  overflow: hidden;
  border-radius: 10px;
  margin-top: 20px;
}

/* Ensure images fit correctly */
.slide {
  width: 100%;
  height: auto;
  max-height: 500px; /* Keep images within the slider */
  object-fit: cover;
}

/* Adjust arrow positions */
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

/* Ensure arrows stay in place on all screen sizes */
@media (max-width: 768px) {
  .prev, .next {
    top: 50%;
  }
}

@media (min-width: 1024px) {
  .prev, .next {
    top: 45%; /* Adjust for larger screens */
  }
}
/* Alert Box */
.alert {
  position: fixed;
  top: 10px;
  left: 50%;
  transform: translateX(-50%);
  background: #ffcc00;
  color: #333;
  padding: 15px 20px;
  border-radius: 5px;
  display: flex;
  align-items: center;
  gap: 10px;
  font-weight: bold;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
  z-index: 9999;
}

.alert button {
  background: none;
  border: none;
  font-size: 18px;
  font-weight: bold;
  cursor: pointer;
  margin-left: auto;
}

.alert button:hover {
  color: red;
}

  </style>
</head>
<body>

  <div class="container">
    <!-- Sidebar -->
    <aside class="sidebar" id="sidebar">
        <div class="faculty-container">
    <img src="faculty.jpg" alt="Faculty Image" class="faculty-image">
  </div> 
      
      <h1>Welcome, <%= session.getAttribute("facultyName") != null ? session.getAttribute("facultyName") : "name" %>!</h1>
        
      <nav>
   <ul>
          <li><a href="faculty.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
          <li><a href="viewFeedback.jsp"><i class="fas fa-comments"></i> View Feedback</a></li>
          <li><a href="profile.html"><i class="fas fa-user-edit"></i> Edit Profile</a></li>
          <li><a href="updateFaculty.jsp"><i class="fas fa-key"></i> Update Password</a></li>
          <li><a href="logoutfaculty.html"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
      </nav>
    </aside>

    <!-- Main Content -->
    <div class="content">
      <div class="header">
        <button class="hamburger" onclick="toggleSidebar()">☰</button>
        <h1>Faculty Dashboard</h1>
        <button class="logout-btn" onclick="window.location.href='logoutfaculty.html';">Logout</button>
      </div>
        <h1>Welcome, <%= session.getAttribute("facultyName") != null ? session.getAttribute("facultyName") : "name" %>!</h1>
        
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
      <div class="dashboard">
        <div class="card" onclick="window.location.href='viewFeedback.jsp'">
          <i class="fas fa-comments"></i>
          <h3>View Feedback</h3>
          <p>See feedback provided by students for your courses.</p>
        </div>
        <div class="card" onclick="window.location.href='profile.html'">
          <i class="fas fa-user-edit"></i>
          <h3>Edit Profile</h3>
          <p>Keep your profile updated with the latest information.</p>
        </div>
        <div class="card" onclick="window.location.href='updatepass.html'">
          <i class="fas fa-key"></i>
          <h3>Update Password</h3>
          <p>Update your account password to stay secure.</p>
        </div>
      </div>
    </div>
  </div>
<div id="passwordAlert" style="
      display: none;
      position: fixed;
      top: 20px;
      left: 50%;
      transform: translateX(-50%);
      background: #ff4d4d;
      color: white;
      padding: 15px 20px;
      border-radius: 5px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
      font-size: 16px;
      font-weight: 500;
      z-index: 1000;
    ">
    Please update your password! <button onclick="hideAlert()">✖</button>
  </div>

  <script>
    function checkPasswordUpdate() {
        fetch('CheckPasswordUpdateServlet')
        .then(response => response.text())
        .then(data => {
            if (data === "update_required") {
                document.getElementById("passwordAlert").style.display = "block";
            } else {
                document.getElementById("passwordAlert").style.display = "none";
            }
        })
        .catch(error => console.error("Error:", error));
    }

    function hideAlert() {
        document.getElementById("passwordAlert").style.display = "none";
    }

    // ✅ Check every 5 seconds if the password is updated
    setInterval(checkPasswordUpdate, 5000);

    // ✅ Auto-hide the alert after 30 seconds
    setTimeout(hideAlert, 30000);
  
  
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
    function toggleSidebar() {
      const sidebar = document.getElementById("sidebar");
      sidebar.classList.toggle("active");
    }

    window.addEventListener("resize", function() {
      const sidebar = document.getElementById("sidebar");
      if (window.innerWidth > 768) {
        sidebar.classList.remove("active");
      }
    });
  </script>

</body>
</html>
