<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp?message=SessionExpired");
        return;
    }
%>

<%
    // Prevent caching (force fresh requests)
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
    }
%>



<!DOCTYPE html>
<html>
<head>
    <script>
    // Detect if the user presses the back button and log them out
    window.addEventListener("pageshow", function(event) {
        if (event.persisted || window.performance && window.performance.navigation.type === 2) {
            window.location.href = "<%= request.getContextPath() %>/LogoutServlet?reason=backbutton";
        }
    });
    </script>
	<script>

    // Disable right-click
    document.addEventListener("contextmenu", function(event) {
        event.preventDefault();
    });

    // Disable keyboard shortcuts for DevTools and View Source
    document.addEventListener("keydown", function(event) {
        if (
            (event.ctrlKey && (event.key === "i" || event.key === "I" || event.key === "j" || event.key === "J" || event.key === "u" || event.key === "U" || event.key === "c" || event.key === "C")) || 
            event.key === "F12" ||
            (event.ctrlKey && event.shiftKey && (event.key === "I" || event.key === "C" || event.key === "J")) ||
            (event.metaKey && event.altKey && event.key === "I") // For MacOS
        ) {
            event.preventDefault();
        }
    });

    // Detect if DevTools is open
    (function() {
        var element = new Image();
        Object.defineProperty(element, 'id', {
            get: function() {
                window.location.href = "<%= request.getContextPath() %>/LogoutServlet"; // Redirect user if DevTools is open
            }
        });
        console.log('%c', element);
    })();

	    // Disable text selection
	    document.addEventListener("selectstart", function(event) {
	        event.preventDefault();
	    });

	    // Disable dragging images
	    document.addEventListener("dragstart", function(event) {
	        event.preventDefault();
	    });

	    // Disable copying content
	    document.addEventListener("copy", function(event) {
	        event.preventDefault();
	    });
	</script>
<script>
    var timeout;

    function resetTimer() {
        clearTimeout(timeout);
        timeout = setTimeout(function () {
            window.location.href = "<%= request.getContextPath() %>/LogoutServlet?reason=SessionExpired";
        }, 120000); // 120000ms = 2 minutes
    }

    // Reset the timer on user activity

    document.onkeypress = resetTimer;
    document.onscroll = resetTimer;
    document.onclick = resetTimer;

    // Start the timer initially
    resetTimer();
</script>

  <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
  <meta http-equiv="Pragma" content="no-cache" />
  <meta http-equiv="Expires" content="0" />
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Band Page</title>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f4f4f4;
    }
    nav {
      background-color: #000;
      padding: 10px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .nav-links {
      display: flex;
      gap: 15px;
    }
    .nav-links a {
      color: white;
      text-decoration: none;
      padding: 10px 15px;
      display: inline-block;
    }
    .logout-btn {
      background-color: red;
      color: white;
      padding: 8px 15px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      text-decoration: none;
    }
    .logout-btn:hover {
      background-color: darkred;
    }
    .slider {
      width: 100%;
      overflow: hidden;
    }
    .slider img {
      width: 100%;
      display: none;
    }
    .content {
      max-width: 600px;
      margin: auto;
      padding: 20px;
      text-align: center;
    }
    .band-members {
      display: flex;
      justify-content: center;
      gap: 20px;
      background-color: #ddd;
      padding: 20px;
    }
    .band-members div {
      text-align: center;
    }
    .band-members img {
      width: 100px;
      height: auto;
    }
    footer {
      background-color: black;
      color: white;
      text-align: center;
      padding: 20px;
    }
    footer a i {
    	font-size: 24px; /* Increase icon size */
    	color: white; /* Ensure icons are visible */
   		margin: 0 10px;
	}

	footer a:hover i {
    	color: #007bff; /* Change color on hover */
	}
	/* Prevent right-click on images */
  	img {
    	pointer-events: none;
    	-webkit-user-drag: none;
    	user-drag: none;
  	}

  	/* Prevent text selection (Copy-Paste) */
  	body {
    	-webkit-user-select: none;
    	-moz-user-select: none;
    	-ms-user-select: none;
    	user-select: none;
  	}
  </style>


</head>
<body>

<!-- Navigation -->
<nav>
  <div class="nav-links">
    <a href="#home">Home</a>
    <a href="#band">Band</a>
    <a href="#tour">Tour</a>
    <a href="#contact">Contact</a>
  </div>
  <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-btn">Logout</a>
</nav>

<!-- Slide Show -->
<section class="slider">
  <img class="mySlides" src="img/la.jpg" style="display: block;">
  <img class="mySlides" src="img/ny.jpg">
  <img class="mySlides" src="img/cago.jpg">
</section>

<!-- Band Description -->
<section class="content">
  <h2>THE BAND</h2>
  <p><i>We love music</i></p>
  <p>We have created a fictional band website. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
</section>


<!-- Footer -->
<footer>
  <p>Follow us on:</p>
  <a href="#"><i class="fab fa-facebook"></i></a>
  <a href="#"><i class="fab fa-pinterest"></i></a>
  <a href="#"><i class="fab fa-twitter"></i></a>
  <a href="#"><i class="fab fa-flickr"></i></a>
  <a href="#"><i class="fab fa-linkedin"></i></a>
  <p>project 2 done by - group 3 - 2025</p>
</footer>

<script>
// Automatic Slideshow - change image every 3 seconds
var myIndex = 0;
carousel();

function carousel() {
  var i;
  var x = document.getElementsByClassName("mySlides");
  for (i = 0; i < x.length; i++) {
     x[i].style.display = "none";
  }
  myIndex++;
  if (myIndex > x.length) {myIndex = 1}
  x[myIndex-1].style.display = "block";
  setTimeout(carousel, 3000);
}
</script>

</body>
</html>
