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

@WebServlet("/NewUserServlet")
public class NewUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public NewUserServlet() {
        super();
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true);	 
		String file = (String) session.getAttribute("file");
		String fullName = request.getParameter("fullName");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String imageURL = request.getParameter("imageURL");
		DataStorage temp = (DataStorage) session.getAttribute("data");
		String toWrite="";
		
		if(fullName.equals("")){
			toWrite+="Please enter your name" + "\n";
		}
		
		if(temp.getUser(username)!=null){
			toWrite+="Please enter a valid username" + "\n";
		}
		
		if(username.equals("")){
			toWrite+="Please enter a username" + "\n";
		}
		
		if(password.equals("")){
			toWrite+="Please enter a valid password" + "\n";
		}
		
		if(imageURL.equals("")){
			toWrite+="Please enter a valid image URL" + "\n";
		}
		
		if(toWrite.length()>0){
			response.getWriter().write(toWrite);
		}
		
		else{
			try{
				String[] nameArray = fullName.split(" ");
				String firstName = nameArray[0];
				String lastName = "";
				if(nameArray.length>1){
					lastName = nameArray[1];
				}
				else{
					lastName = "";
				}
				temp.addUserToXML(username, password, firstName, lastName, imageURL);
				DataStorage ds = new DataStorage(file);
				ds.setLoggedInUser(username);
				request.getSession().setAttribute(StringConstants.DATA, ds);
				//response.sendRedirect(StringConstants.JSP_EXT+StringConstants.LOGIN_JSP);
			}
			catch(CinemateException e){
				//request.setAttribute(StringConstants.ERROR, e.getMessage());
				response.getWriter().write(e.getMessage());
				request.getRequestDispatcher(StringConstants.JSP_EXT+StringConstants.FILE_CHOOSER_JSP).forward(request, response);
			}
			
		} //END OF ELSE
		
	} //END OF SERVICE

} //END OF SERVLET
