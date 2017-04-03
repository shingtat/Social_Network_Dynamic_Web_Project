<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="data.DataStorage" %>
<%@ page import="data.User" %>
<%@ page import="data.Event" %>
<%@ page import="data.StringConstants" %>
<html>
<head>
	<title>User Profile</title>
	<link rel="stylesheet" href= "../css/main.css">
	<link rel="stylesheet" href= "../css/feed.css">
	<link href="https://fonts.googleapis.com/css?family=Lato:700i" rel="stylesheet">
	<script src="../js/nav.js"></script>
	<script>
	
	function getTitle(){
		var titleImages = document.getElementsByClassName("title");
		var titleImagesCount = titleImages.length;
		for(var i=0; i<titleImagesCount; i++){
			titleImages[i].onclick = function(e){
				var title = this.alt;
				redirectMovie(title);
			};
		}
	}
	
	function getUsername(){
		var usernameImages = document.getElementsByClassName("username");
		var usernameImagesCount = usernameImages.length;
		for(var i=0; i<usernameImagesCount; i++){
			usernameImages[i].onclick = function(e){
				var username = this.alt;
				redirectProfile(username);
			};
		}
	}
	
	function redirectProfile(username){
		window.location.href = "profile.jsp?username=" + username;
	}
	
	function redirectMovie(title){
		window.location.href = "movie.jsp?title=" + title;
	}
	
	</script>
</head>
<body>
<!-- get the data storage object and logged in user info -->
<%  DataStorage ds = (DataStorage) session.getAttribute(StringConstants.DATA);
	String parseUsername = (String)request.getParameter("username");
	User user = ds.getUser(parseUsername);
	String name = user.getFName() +" "+user.getLName();
	String un = "@"+user.getUsername();
	
	User loggedInUser = ds.getLoggedInUser();
	String loggedInUserImage = loggedInUser.getImage();
%>
		<div class="nav">
		<div class="feed"><img src="../img/resources/feed_icon.png" onclick="getUsernameForFeedRedirect();" id="feedUser" alt="<%=loggedInUser.getUsername() %>"></div>
		<div class="profilepic"><img src="<%=loggedInUserImage %>" onclick = "getUsernameForProfileRedirect();" id="profileUser" alt="<%=loggedInUser.getUsername() %>" ></div>
			<div class="search">
				<form>
					<input type="text" id="searchInput">
					<img src="../img/resources/clapperboard_icon.png" onclick = "swapImage();" id="toggleSearch">
				</form>
			</div>
			<div id="searchIcon"><button id="submit" onclick="search();"></button></div>
			<div id="header"><h1>Cinemate</h1></div>
			<div class="logout"><button onclick="redirectLogout();"></button></div>
			<div class="exit"><button onclick="redirectExit();"></button></div>
		</div>
	<div id = "user_container_outer">
		<div id = "user_container_inner">
			<img src = <%= user.getImage()%> alt = "Profile Image Not Found">
			<h1><%= name %></h1>
			<h3><%= un %></h3>
		</div>
	</div>
	<br>
		<table id = "feed">
			<thead >
				<tr>
					<th>Username</th>
					<th>Action</th>
					<th>Movie</th>
				</tr>
			</thead>
			<tbody>
<!-- 			Get the users list of following and add their own username. Then iterate through this new set and get the user object
			and iterate through each of their feeds -->
				<%
				Set<String> following = new HashSet<>(user.getFollowing());
				following.add(user.getUsername());
				
				for (String username : following){
					
					User current = ds.getUser(username); %>
					<tr><% 
						for (Event event : current.getFeed()){
							String toShow = event.getUsername() +" " + event.getAction().toLowerCase() +" "+event.getMovie().getTitle(); 
							String profileImage = current.getImage();
							String actionImage = event.getImage();
							String movieImage = event.getMovie().getImage();%>
							<td><img style="width:150px; height: 150px" src="<%= profileImage %>" alt="<%= event.getUsername() %>" class="username" onclick="getUsername();"></td>
							<td><img src="<%= actionImage %>" %></td>
							<td><img style="width:200; height: 350px"src="<%= movieImage %>" alt="<%=event.getMovie().getTitle()%>" class="title" onclick = "getTitle();"></td>
							</tr>
					<% }
				} %>
			</tbody>
		</table>
</body>
</html>