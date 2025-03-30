<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Prevent caching of login page
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    
    // Handle different error messages
    String error = request.getParameter("error");
    String message = request.getParameter("message"); //logout reason
	if (message == null) {
	    message = ""; // Prevent null pointer issues
	}

    if ("SessionExpired".equals(message)) {
        message = "Your session has expired. Please log in again.";
    } else if ("InvalidCredentials".equals(message)) {
        message = "Invalid ID or password. Try again.";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
	<script>
	    window.onload = function() {
	        // Forcefully clear both fields
	        document.getElementById("username").value = "";
	        document.getElementById("password").value = "";
	    };
	    
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
	
    <title>Login Page</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">

    <style>
        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        body {
            background-color: #080710;
        }
        .background {
            width: 430px;
            height: 520px;
            position: absolute;
            transform: translate(-50%,-50%);
            left: 50%;
            top: 50%;
        }
        .background .shape {
            height: 200px;
            width: 200px;
            position: absolute;
            border-radius: 50%;
        }
        .shape:first-child {
            background: linear-gradient(#1845ad, #23a2f6);
            left: -80px;
            top: -80px;
        }
        .shape:last-child {
            background: linear-gradient(to right, #ff512f, #f09819);
            right: -30px;
            bottom: -80px;
        }
        form {
            height: 520px;
            width: 400px;
            background-color: rgba(255,255,255,0.13);
            position: absolute;
            transform: translate(-50%,-50%);
            top: 50%;
            left: 50%;
            border-radius: 10px;
            backdrop-filter: blur(10px);
            border: 2px solid rgba(255,255,255,0.1);
            box-shadow: 0 0 40px rgba(8,7,16,0.6);
            padding: 50px 35px;
        }
        form h3 {
            font-size: 32px;
            font-weight: 500;
            text-align: center;
            color: white;
        }
        label {
            display: block;
            margin-top: 30px;
            font-size: 16px;
            font-weight: 500;
            color: white;
        }
        input {
            display: block;
            height: 50px;
            width: 100%;
            background-color: rgba(255,255,255,0.07);
            border-radius: 3px;
            padding: 0 10px;
            margin-top: 8px;
            font-size: 14px;
            font-weight: 300;
            color: white;
        }
        ::placeholder {
            color: #e5e5e5;
        }
        button {
            margin-top: 50px;
            width: 100%;
            background-color: #ffffff;
            color: #080710;
            padding: 15px 0;
            font-size: 18px;
            font-weight: 600;
            border-radius: 5px;
            cursor: pointer;
            border: none;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="background">
        <div class="shape"></div>
        <div class="shape"></div>
    </div>
    
    <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
        <h3>Login Here</h3>

        <label for="id">Username</label>
        <input type="text" placeholder="Enter your username" id="id" name="id" autocomplete="off" required>

        <label for="password">Password</label>
        <input type="password" placeholder="Enter your password" id="password" name="password" autocomplete="off" required>

        <button type="submit">Log In</button>

        <!-- Display error message dynamically using JSP -->
		<div class="error-message">
		    <%
		
		        // Handle login errors
		        if ("notloggedin".equals(error)) { 
		            out.println("<p style='color: red;'>Please login to access the webpage!</p>"); 
		        } else if (error != null) { 
		            out.println("<p style='color: red;'>Invalid credentials! Please try again.</p>");
		        }
		
		        // Handle logout messages
		        if ("devtoolsLogout".equals(message)) { 
		            out.println("<p style='color: red;'>You tried to open DevTools. You have been logged out.</p>");
		        } else if ("backButtonLogout".equals(message)) { 
		            out.println("<p style='color: red;'>You were logged out because you pressed the back button.</p>");
		        } else if ("LoggedOut".equals(message)) { 
		            out.println("<p style='color: green;'>You have been logged out successfully.</p>");
		        } else if ("SessionExpired".equals(message)) {
        		    out.println("<p style='color: red;'>Your session has expired. Please log in again.</p>");
    			}
		    %>
		</div>
    </form>
</body>
</html>

