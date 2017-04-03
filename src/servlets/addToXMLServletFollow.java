package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.CinemateException;
import data.DataStorage;
import data.StringConstants;
import data.User;

@WebServlet("/addToXMLServletFollow")
public class addToXMLServletFollow extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public addToXMLServletFollow() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get filename
		System.out.println("in service");
		String usernameToFollowUnfollow = request.getParameter("username");
		String action = request.getParameter("action");
		HttpSession session = request.getSession();
		DataStorage ds = (DataStorage) session.getAttribute("data");
		User loggedInUser = ds.getLoggedInUser();
		User user = ds.getUser(usernameToFollowUnfollow);

		if(action.equals("follow")){
			loggedInUser.addFollowing(usernameToFollowUnfollow);
			user.addFollower(loggedInUser.getUsername());
		}
		
		else if(action.equals("unfollow")){
			loggedInUser.removeFollowing(usernameToFollowUnfollow);
			user.removeFollower(loggedInUser.getUsername());
		}

		
		//Changing file for loggedInUser first
		ds.writeFollowToXML(usernameToFollowUnfollow,action);
		int buttonDisplay=0;
		if(!loggedInUser.checkFollowing(usernameToFollowUnfollow)){
			buttonDisplay=1;
		}
		else{
			buttonDisplay=2;
		}
		
		response.getWriter().write(buttonDisplay);

	}

}