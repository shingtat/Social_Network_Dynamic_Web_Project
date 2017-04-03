<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="data.DataStorage" %>
<%@ page import="data.User" %>
<%@ page import="data.StringConstants" %>
<%@ page import="data.Event" %>
<%@ page import="java.util.List" %>
<%@ page import="data.Movie" %>
<%@ page import="java.util.Vector" %>
<%@ page import="data.Actor" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%  DataStorage ds = (DataStorage) session.getAttribute(StringConstants.DATA); 	
	String title = (String)request.getParameter("title");
	Movie movie = ds.getMovie(title);
	Vector<Actor> actorObjects = movie.getActorObjects();
	//Construct Actor List String
	String actorsString = "";
	for(Actor actor: actorObjects){
		actorsString = actorsString + actor.getFirstName() + " " + actor.getLastName() + ", ";
	}
	String finalActorsString = actorsString.substring(0,actorsString.length()-2);
	
	String genre = movie.getGenre();
	int year = movie.getYear();
	String director = movie.getDirector();
	String description = movie.getDescription();
	String image = movie.getImage();
	String rating = Double.toString(movie.calculateRating());
	
	//Construct Writer List String
	List<String> writers = movie.getWriters();
	String writerString="";
	for(String writer: writers){
		writerString+=writer+", ";
	}
	String finalWritersString = writerString.substring(0,writerString.length()-2);
	
	User loggedInUser = ds.getLoggedInUser();
	String loggedInUserImage = loggedInUser.getImage();

%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Movie Page</title>
		<link rel="stylesheet" href="../css/movie.css">
		<script src = "../js/nav.js"></script>
		<script src = "../js/star.js"></script>
		<script defer>
		
		function addWatchedEvent(){
			
			alert("You have watched this movie!");
			var xhttp = new XMLHttpRequest();
			var url = "${pageContext.request.contextPath}/addToXMLServlet";
			var params = "?";
			var title = "title=";
			var titleInput = "<%=title%>";
			var action = "&action=";
			var actionInput = "Watched";
			var rating="&rating=";
			var ratingInput="";
			
			
			var finalURL = url + params + title + titleInput + action + actionInput+rating+ratingInput;
			xhttp.open("GET", finalURL, false);
			xhttp.send();

		}
		
		function addLikedEvent(){
			alert("You have liked this movie!");
			var xhttp = new XMLHttpRequest();
			var url="${pageContext.request.contextPath}/addToXMLServlet";
			var params ="?";
			var title="title=";
			var titleInput="<%=title%>";
			var action="&action=";
			var actionInput="Liked";
			var rating="&rating=";
			var ratingInput="";
			
			var finalURL = url + params + title + titleInput + action + actionInput+rating+ratingInput;
			xhttp.open("GET", finalURL, false);
			xhttp.send();
		}
		
		function addDislikedEvent(){
			alert("You have disliked this movie!");
			var xhttp = new XMLHttpRequest();
			var url="${pageContext.request.contextPath}/addToXMLServlet";
			var params ="?";
			var title="title=";
			var titleInput="<%=title%>";
			var action="&action=";
			var actionInput="Disliked";
			var rating="&rating=";
			var ratingInput="";
			
			var finalURL = url + params + title + titleInput + action + actionInput+rating+ratingInput;
			xhttp.open("GET", finalURL, false);
			xhttp.send();
		}
		
		function addRatingEvent(id){
			alert("You have rated this movie!");
			var xhttp = new XMLHttpRequest();			
			var url="${pageContext.request.contextPath}/addToXMLServlet";
			var params ="?";
			var title="title=";
			var titleInput="<%=title%>";
			var action="&action=";
			var actionInput="Rated";
			var rating="&rating=";
			var ratingInput="";
			if(id=="star10"){
				ratingInput=10;
			}
			else{
				var ratingInput=id[id.length-1];
			}

			var finalURL = url + params + title + titleInput + action + actionInput+rating+ratingInput;
			xhttp.open("GET", finalURL, false);
			xhttp.send();
			
			if(xhttp.responseText.trim().length>0){
				showStars(xhttp.responseText);
			}

		}
		
		function showStars(number){
			switch(number){
			case 1:
				changeStar1();
				break;
			case 2:
				changeStar2();
				break;
			case 3:
				changeStar3();
				break;
			case 4:
				changeStar4();
				break;
			case 5:
				changeStar5();
				break;
			case 6:
				changeStar6();
				break;
			case 7:
				changeStar7();
				break;
			case 8:
				changeStar8();
				break;
			case 9:
				changeStar9();
				break;
			case 10:
				changeStar10();
				break;
			}
			
		}
		
		
		</script>
	</head>
	<body onload = "showStars(<%=rating%>)">
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
		<div id="main_container">
			<div id="content_container">
				<div id="image_container">
					<img src="<%= image %>">
					<div id="action_container">
						<img src="../img/resources/watched.png" id="watched" onclick = "addWatchedEvent();">
						<img src="../img/resources/liked.png" id="liked" onclick="addLikedEvent();">
						<img src="../img/resources/disliked.png" id="disliked" onclick="addDislikedEvent();">
					</div>
				</div>
				<div id="information_container">
					<h1 style="color:white"><%=title+" "+"("+year+")"%></h1>
					<p>Genre: <%=genre %></p>
					<p>Director: <%=director %></p>
					<p>Actors: <%=finalActorsString %></p>
					<p>Writers: <%=writerString %></p>
					<div id="stars-container">
						<a href="" class="stars" id="star1" onmouseover="changeStar1();" onmouseout="changeStar1Back();" onclick="addRatingEvent(this.id);"></a>
						<a href="" class="stars" id="star2" onmouseover="changeStar2();" onmouseout="changeStar2Back();" onclick="addRatingEvent(this.id);"></a>
						<a href="" class="stars" id="star3" onmouseover="changeStar3();" onmouseout="changeStar3Back();" onclick="addRatingEvent(this.id);"></a>
						<a href="" class="stars" id="star4" onmouseover="changeStar4();" onmouseout="changeStar4Back();" onclick="addRatingEvent(this.id);"></a>
						<a href="" class="stars" id="star5" onmouseover="changeStar5();" onmouseout="changeStar5Back();" onclick="addRatingEvent(this.id);"></a>
						<a href="" class="stars" id="star6" onmouseover="changeStar6();" onmouseout="changeStar6Back();" onclick="addRatingEvent(this.id);"></a>
						<a href="" class="stars" id="star7" onmouseover="changeStar7();" onmouseout="changeStar7Back();" onclick="addRatingEvent(this.id);"></a>
						<a href="" class="stars" id="star8" onmouseover="changeStar8();" onmouseout="changeStar8Back();" onclick="addRatingEvent(this.id);"></a>
						<a href="" class="stars" id="star9" onmouseover="changeStar9();" onmouseout="changeStar9Back();" onclick="addRatingEvent(this.id);"></a>
						<a href="" class="stars" id="star10"onmouseover="changeStar10();" onmouseout="changeStar10Back();" onclick="addRatingEvent(this.id);"></a>
					</div>
					<p style="color:white"><%=description %></p>
				</div>	
			</div>
		</div>
		<div id="actor_container">
			<div id="actor_content_container">
				<div id="actor_images_container">
					<table>
						<%for(int i=0; i<actorObjects.size(); i++){ %>
							<tr>
								<td><img src="<%= actorObjects.get(i).getImage()%>"></td>
								<td><h2><%=actorObjects.get(i).getFirstName() + " " + actorObjects.get(i).getLastName() %></h2>
								
							</tr>
						<%}%>
					</table>						
				</div>
			</div>
		</div>
	</body>
</html>