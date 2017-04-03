		
		var movieSearch = true;
	
		function redirectLogout(){
			location.href="login.jsp";
		}
		
		function redirectExit(){
			location.href="file_chooser.jsp";
		}
		
		function getUsernameForFeedRedirect(){
			var temp = document.getElementById("feedUser");
			var username = temp.alt;
			redirectFeed(username);
		}
		
		function getUsernameForProfileRedirect(){
			var temp = document.getElementById("profileUser");
			var username = temp.alt;
			redirectProfile(username);
		}
		
		function redirectFeed(username){
			location.href="feed.jsp?username=" + username;
		}
		
		function redirectProfile(username){
			location.href="profile.jsp?username=" + username;
		}
		
		function swapImage(){			
			console.log("what");
			var img = document.getElementById("toggleSearch");
			console.log(img.src);
			if(img.src=="http://localhost:8080/Assignment_2/img/resources/clapperboard_icon.png"){
				img.src="http://localhost:8080/Assignment_2/img/resources/user_icon.png";
				movieSearch = false;
			} else if(img.src="http://localhost:8080/Assignment_2/img/resources/user_icon.png") {
				img.src="http://localhost:8080/Assignment_2/img/resources/clapperboard_icon.png";
				movieSearch = true;
			}
			
			
		}
		
		function search(){
			
			if(movieSearch===true){
				var url = "${pageContext.request.contextPath}<%= StringConstants.SEARCH_SERVLET%>";
				var otherURL = "search.jsp";
				var formInput = document.getElementById("searchInput").value;
				var parameters = formInput.split(":");
				var params = "?";
				var search = "search=";
				var searchInput = parameters[0];
				var and = "&";
				var searchParam = "searchParam=";
				var searchParamInput = parameters[1];
				location.href= otherURL + params + search + searchInput + and + searchParam + searchParamInput;
			}
			else{
				var url = "${pageContext.request.contextPath}<%= StringConstants.SEARCH_SERVLET%>";
				var otherURL="search.jsp";
				var formInput = document.getElementById("searchInput").value;
				var params="?search=user&searchParam="+ formInput;
				location.href= otherURL + params;
			}
		}