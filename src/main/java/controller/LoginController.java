package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dao.UserDAO;

@Controller
public class LoginController {
	@Autowired
	UserDAO userDAO;
	
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView showMessage(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("login");
		String userName = request.getParameter("userName");
		String password = request.getParameter("password");
		
		try {
			if(userDAO.getUser(userName, password) != null) {
				 HttpSession session=request.getSession();
				 session.setAttribute("userName",userName);
				 RequestDispatcher dispatcher = request.getRequestDispatcher("product/product.html");
				dispatcher.forward(request, response);
			} 
			else {
				
			}
		} catch (ServletException | IOException  | EmptyResultDataAccessException e) {
			// TODO: handle exception
			e.printStackTrace();
			return new ModelAndView("login");
		}
		
		
		return new ModelAndView("login");
		
	}
}
