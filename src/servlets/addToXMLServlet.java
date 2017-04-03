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
import data.Event;
import data.Movie;
import data.StringConstants;
import data.User;

@WebServlet("/addToXMLServlet")
public class addToXMLServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public addToXMLServlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get filename
		String title = request.getParameter("title");
		String action = request.getParameter("action");
		String username = request.getParameter("username");
		String rating = request.getParameter("rating");
				
		HttpSession session = request.getSession();
		DataStorage ds = (DataStorage) session.getAttribute("data");
		Movie movieTemp = ds.getMovie(title);
		if(!rating.equals("")){
			try{ 
				//Need to also write the updated Rating Total and Rating Count
				System.out.println("TESTING newRating");
				double newRating = Double.parseDouble(rating);
				movieTemp.addRatingTotal(newRating);
				movieTemp.incrementRatingCount();
			} catch(NumberFormatException e){
				System.out.println("Rating is not an double!");
				System.out.println(e.getMessage());
			}
		} //END OF IF
		
		Event newEvent = new Event();
		Movie temp = ds.getMovie(title);
		newEvent.setAction(action);
		newEvent.setImage(action);
		newEvent.setMovie(temp);
		
		User loggedInUser = ds.getLoggedInUser();
		loggedInUser.addEvent(newEvent);
		ds.addFeedToXML(action, title, rating);
		response.getWriter().write(movieTemp.calculateRating());
		
//		try{
//			DataStorage ds = new DataStorage(file);
//			request.getSession().setAttribute(StringConstants.DATA, ds);
//			//response.sendRedirect(StringConstants.JSP_EXT+StringConstants.LOGIN_JSP);
//		}
//		catch(CinemateException e){
//			//request.setAttribute(StringConstants.ERROR, e.getMessage());
//			response.getWriter().write(e.getMessage());
//			request.getRequestDispatcher(StringConstants.JSP_EXT+StringConstants.FILE_CHOOSER_JSP).forward(request, response);
//		}
	}

}