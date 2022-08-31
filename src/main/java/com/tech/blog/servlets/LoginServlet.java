package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;

/**
 * Servlet implementation class LoginServlet
 */
@MultipartConfig
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {

			// login
			// fetch useremail and passwowrd from request
			String userEmail = request.getParameter("user_email");
			String userPassword = request.getParameter("user_password");

			UserDao dao = new UserDao(ConnectionProvider.getConnection());

			User u = dao.getUserByEmailAndPassword(userEmail, userPassword);

			if (u == null) {
				// login....
				// error
				// out.println("Invalid details..try again");
				Message msg = new Message("Invalid details..try again", "error", "alert-danger");
				HttpSession s = request.getSession();
				s.setAttribute("msg", msg);
				response.sendRedirect("login_page.jsp");
			} else {
				// ....
				// login success
				HttpSession s = request.getSession();
				s.setAttribute("currentUser", u);

				// redirect to user profile page
				response.sendRedirect("profile.jsp");
			}
		}
	}

}
