<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="data.StringConstants" %>
<html>
<head>
	<title>Login</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
	<link href="https://fonts.googleapis.com/css?family=Lato:700i" rel="stylesheet">
	<script type = "text/javascript">
		function validate(){
			document.getElementById("error_message").innerHTML="";
			var xhttp = new XMLHttpRequest();
			var url = "${pageContext.request.contextPath}/NewUserServlet";
			var params = "?";
			
			var fullName = "fullName=";
			var fullNameValue = document.getElementById("fullName").value;
			
			var username = "&username=";
			var usernameValue = document.getElementById("username").value;
			
			var password = "&password=";
			var passwordValue = document.getElementById("password").value;
			
			var imageURL = "&imageURL=";
			var imageValue = document.getElementById("imageURL").value;
			
			var finalURL = url+params+fullName+fullNameValue+username+usernameValue+password+passwordValue+imageURL+imageValue;
			
			xhttp.open("GET", finalURL, false);
			xhttp.send();
			if(xhttp.responseText.trim().length>0){
				document.getElementById("error_message").innerHTML += xhttp.responseText +"</br>";
				return false;
			}
			
			else{
				window.location.href="profile.jsp?username=" + usernameValue;
			}

		}
	</script>
</head>
<body>

	<div id = "title_container">
		Cinemate
	</div>

	<div id = "welcome_text">
		File parsed! Please sign up.
	</div>

	<!-- <form action="demo_form.asp"> -->
	<div id = "outer_container">
		<div id = "inner_container">
			<div id = "login_container">
				<form method="GET">
					<input type="text" name="fullName" placeholder="Full Name" id="fullName">
					<input type="text" name="username" placeholder="Username" id="username">
					<input type="text" name="password" placeholder="Password" id="password">
					<input type="text" name="imageURL" placeholder="Image URL" id="imageURL">
					<input style = "margin-left: 5px;" type="button" value="Sign Up" onclick="return validate();">
				</form> 
			</div>
		 	<div id=error_message>
		 	<!-- if there is an error display it, else display the empty string -->
				<% String error = (String)request.getAttribute(StringConstants.ERROR);
				if (error == null) error = "";%>
				<%= error %>
			</div>
		</div>
	</div>
</body>
</html>