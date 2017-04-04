# Social Network Dynamic Web Project
Dynamic social network web project using the MVC model with JSP and Servlets.
Front end created with HTML5, CSS3, Javascript.
Back end written in Java.

To execute:
1) Go to jsp folder in WebContent and launch file_chooser.jsp.
2) Place absolute path of test_file.xml when prompted.
3) From then, choose to either login or signup.

Data is first read from a XML file that contains information on users,
movies and feed for every user.

Features:
User authentication is accomplished by sending an AJAX request to the backend
which then dynamically displays an error message if there is one.

Upon successful login, user is directed to their profile page where he/she can see
their followers as well as who they are following. The middle column is a mini feed that shows the action of each friend
that the user is following.

Followers, following and movie links are all clickable and redirects to another dynamic page.
User also has the ability to search for movies or users at the search bar at the top.

In a movies page, the current user can click on the "Watched", "Like", or "Dislike" button
for the movie, in which case, will get reflected on the feeds of those who are following the
current user. In addition, these changes will get reflected on the XML file.

Users also have the ability to rate a movie. Upon hovering a star, an AJAX request is sent to the
backend where the new average rating of the movie is computed. The new average rating is then sent back
to the front end to get dynamically updated. This change is also reflected in the XML file.


![Alt text](profile_example.png?raw=true "Profile")
![Alt text](feed_example.png?raw=true "Feed")
![Alt text](movie_example.png?raw=true "Movie")
