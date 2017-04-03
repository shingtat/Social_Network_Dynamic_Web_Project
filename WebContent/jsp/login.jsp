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
		function redirectSignup(){
			location.href="signup.jsp";
		}
		
		function validate(){
			var xhttp = new XMLHttpRequest();
			xhttp.open("GET", "${pageContext.request.contextPath}/LoginServlet?username=" + document.myform.username.value + "&password="+ document.myform.password.value, false);
			xhttp.send();
			console.log(xhttp.responseText);
			
			if(xhttp.responseText.trim()!=document.myform.username.value){
				document.getElementById("error_message").innerHTML = xhttp.responseText; //what is response text?
				return false; //what does return false do?
			}
			else{
			window.location.href="profile.jsp?username="+document.myform.username.value;
			return false;
			}

		}
	</script>
</head>
<body>

	<div id = "title_container">
		Cinemate
	</div>

	<div id = "welcome_text">
		File parsed! Please log in.
	</div>

	<!-- <form action="demo_form.asp"> -->
	<div id = "outer_container">
		<div id = "inner_container">
			<div id = "login_container">
				<form method ="GET" name="myform">
					Username
					<br>
					<input type="text" id="username" name="<%= StringConstants.USERNAME%>">
					<br>
					Password
					<br>
					<input type="text" id="password"  name="<%= StringConstants.PASSWORD%>">
					<br><br>
					<input style = "margin-left: 5px;" type="submit" value="Log In" onclick = "return validate();">
					<input style = "margin-left: 5px;" type="button" value="Sign Up" onclick="redirectSignup();"></button>
				</form> 
			</div>
		 	<div id="error_message">
			</div>
		</div>
	</div>
</body>
</html>