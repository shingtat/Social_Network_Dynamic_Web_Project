<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="data.StringConstants" %>
<html>
<head>
<title>File Chooser</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<link href="https://fonts.googleapis.com/css?family=Lato:700i"
	rel="stylesheet">
<script src="../js/file_chooser.js"></script>
<script>
function validate(){
	var xhttp = new XMLHttpRequest();
	xhttp.open("GET","${pageContext.request.contextPath}/FileChooserServlet?infile=" + document.getElementById("file").value, false);
	xhttp.send();
	if(xhttp.responseText.trim().length>0){
		document.getElementById("error_message").innerHTML = xhttp.responseText; //what is response text?
		return false; 
	}
	else{
	window.location.href="login.jsp";
	return false;
	}
}


</script>
</head>
<body>
	<div id="title_container">Cinemate</div>

	<div id="welcome_text">
		Welcome to Cinemate, a Movie Social Media Medium.
		<br>
		Please input a file so that you may begin your experience.
	</div>
	<div id="outer_container">
		<div id="inner_container">
			<form method="GET">
				<input style = "width: 72%; margin-right: 5px;" type="text" name="<%= StringConstants.INFILE%>" id="file">
				<input style = "width: 20%;" type="submit" onclick="return validate();">
 				<div class=error_message>
 				<!-- if there is an error display it, else display the empty string -->
					<% String error  = (String) (request.getAttribute(StringConstants.ERROR)); 
						if (error == null) error = ""; %>
					<%= error %>
				</div>
			</form>
		</div>
	</div>
</body>
</html>