<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="data.DataStorage" %>
<%@ page import="data.User" %>
<%@ page import="data.StringConstants" %>
<%@ page import="data.Event" %>
<%@ page import="java.util.List" %>
<html>
<!-- get the data storage object and user info -->
<%  DataStorage ds = (DataStorage) session.getAttribute(StringConstants.DATA);
	String parseUsername = (String)request.getParameter("username");
	System.out.println("username reached");
	User user = ds.getUser(parseUsername);
	String userImage = user.getImage();
	String name = user.getFName() +" "+user.getLName();
	String un = "@"+user.getUsername();


	User loggedInUser = ds.getLoggedInUser();
	System.out.println("loggedInreached?");
	String loggedInUserImage = loggedInUser.getImage();

	//BUTTON DISPLAY CONTROL
	int buttonDisplay;
	//If loggedInUser is equal to User, don't show button
	if(user.equals(loggedInUser)){
		buttonDisplay=0;
	}
	//If loggedInUser does not follow the person, show FOLLOW button
	else if(!loggedInUser.checkFollowing(user.getUsername())){
		buttonDisplay=1;
	}
	else{ //If loggedInUser does follow the person, show UNFOLLOW button
		buttonDisplay=2;
	}
%>
<head>
	<title>User Profile</title>
	<link rel="stylesheet" href="../css/main.css">
	<link rel="stylesheet" href="../css/profile.css">
	<link href="https://fonts.googleapis.com/css?family=Lato:700i" rel="stylesheet">
	<script src="../js/nav.js"></script>
	<script>

		function showButton(number){
			if(<%=buttonDisplay%>==0){

			}
			else if(<%=buttonDisplay%>==1){
				document.getElementById("follow").style.display="block";
			}
			else if(<%=buttonDisplay%>==2){
				document.getElementById("unfollow").style.display="block";
			}
		}

		function addFollow(id){
			var xhttp = new XMLHttpRequest();
			var url = "${pageContext.request.contextPath}/addToXMLServletFollow";
			var params = "?";
			var username = "username=";
			var usernameInput = "<%=user.getUsername()%>";
			var action = "&action=";
			var actionInput = id
			var finalURL = url + params + username + usernameInput+action+actionInput;
			xhttp.open("GET", finalURL, false);
			xhttp.send();

			var buttonDisplay = xhttp.responseText;
			console.log("button" + buttonDisplay);
			document.getElementById("follow").style.display="none";
			document.getElementById("unfollow").style.display="block";
			addFollowToContainer();
		}

		function addFollowToContainer(){
			console.log("here");
			var container = document.getElementById("follow_change");
			console.log(container.id);
			var followWrapper = document.createElement('h2');
			var followLink = document.createElement('a');
			followLink.setAttribute("href", "profile.jsp?username=<%=loggedInUser.getUsername()%>");
			followLink.innerHTML="<%=loggedInUser.getUsername()%>";
			followWrapper.appendChild(followLink);
			container.appendChild(followWrapper);
		}

		function addUnfollow(id){
			var xhttp = new XMLHttpRequest();
			var url = "${pageContext.request.contextPath}/addToXMLServletFollow";
			var params = "?";
			var username = "username=";
			var usernameInput = "<%=user.getUsername()%>";
			var action = "&action=";
			var actionInput = id
			var finalURL = url + params + username + usernameInput+action+actionInput;
			xhttp.open("GET", finalURL, false);
			xhttp.send();

			var buttonDisplay = xhttp.responseText;
			showButton(buttonDisplay);
			document.getElementById("unfollow").style.display="none";
			document.getElementById("follow").style.display="block";
			removeUnfollowFromContainer();
		}

		function removeUnfollowFromContainer(){
			var container = document.getElementById("follow_change");
			var childrenH2 = container.getElementsByTagName("H2");
			for(var i=0; i<childrenH2.length; i++){
				var childrenA = childrenH2[i].getElementsByTagName("a");
					for(var j=0; j<childrenA.length; j++){
						if(childrenA[j].text=="<%=loggedInUser.getUsername()%>"){
							container.removeChild(childrenH2[i]);
						}
					}
			}
		}

	</script>

</head>
<body onload="showButton();">
	<div class="nav">
		<div class="feed"><img src="../img/resources/feed_icon.png" onclick="getUsernameForFeedRedirect();" id="feedUser" alt="<%=loggedInUser.getUsername() %>"></div>
		<div class="profilepic"><img src="<%=loggedInUserImage %>" onclick = "getUsernameForProfileRedirect();" id="profileUser" alt="<%=loggedInUser.getUsername() %>" ></div>
		<div class="search">
			<form>
				<div class="wrapper">
					<input type="text" id="searchInput">
					<div id="button-wrapper">
						<img src="../img/resources/clapperboard_icon.png" onclick="swapImage();" id="toggleSearch">
					</div>
				</div>
			</form>
		</div>
		<div id="searchIcon">
			<button id="submit" onclick="search();"></button>
		</div>
		<div class="logout">
			<button onclick="redirectLogout();"></button>
		</div>
		<div class="exit">
			<button onclick="redirectExit();"></button>
		</div>

	</div>

	<div id = "title_container">
		Cinemate
	</div>

	<div id = "user_container_outer">
		<div id = "user_container_inner">
			<img src = <%=user.getImage()%> alt = "Profile Image Not Found">
			<h1><%=name %></h1>
			<h3 id="un"><%=un %></h3>
		</div>
		<button id="follow" onclick="addFollow(this.id);">Follow</button>
		<button id="unfollow" onclick="addUnfollow(this.id);">Unfollow</button>
	</div>
<!-- display followers and following if there are any -->

<div class="main_container">
	<div class = "follow_container" id="follow_change">
		<h1>Followers</h1>
		<% for (String username : user.getFollowers()) { %>
			<h2><a href ="profile.jsp?username=<%=username%>"><%=username %></a></h2>
		<% } %>
	</div>

	<div class= "section">
		<% List<Event> temp = user.getFeed();
			for(int i=0; i<temp.size(); i++){
				Event event = temp.get(i);
				String actionImage = event.getImage();
				String action = event.getAction() + " ";
				String movie = event.getMovie().getTitle();%>
				<div class="box">
					<div class="box2"><img src=<%=actionImage %>></div>
					<div class="box3"><p><%=action %></p></div>
					<div class="box4"><a href="movie.jsp?title=<%=movie%>"><%=movie %></a></div>
				</div>
		<% } %>
	</div>
	<div class = "follow_container">
		<h1>Following</h1>

		<% for (String username : user.getFollowing()) { %>
			<h2><a href ="profile.jsp?username=<%=username%>"><%=username %></a></h2>
		<% } %>
	</div>
</div>

</body>
</html>
