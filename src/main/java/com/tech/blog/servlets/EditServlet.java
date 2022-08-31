package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.FileHelper;

/**
 * Servlet implementation class EditServlet
 */
@MultipartConfig
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditServlet() {
		super();
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
			// fetch all data from edit profile form
			String name = request.getParameter("user_name");
			String email = request.getParameter("user_email");
			String password = request.getParameter("user_password");
			String about = request.getParameter("about");

			Part part = request.getPart("image");
			String imageName = part.getSubmittedFileName();

			// get the user from the session
			HttpSession session = request.getSession();
			// get the current user details & store in user object
			User user = (User) session.getAttribute("currentUser");

			// replace with new details
			user.setName(name);
			user.setEmail(email);
			user.setPassword(password);
			user.setAbout(about);
			String oldFile = user.getProfile();
			user.setProfile(imageName);

			// update the user with new data in DB using userDao methods
			UserDao userdao = new UserDao(ConnectionProvider.getConnection());
			boolean result = userdao.updateUser(user);
			if (result) {

				String path = request.getServletContext().getRealPath("/") + "pics" + File.separator
						+ user.getProfile();
				// System.out.println(path);
				// delete code - take old profile pic path & delete it
				String oldFilepath = request.getServletContext().getRealPath("/") + "pics" + File.separator + oldFile;
				// delete old picture only if it is other than default.png
				if (!oldFilepath.equals("default.png")) {
					FileHelper.deleteFile(oldFilepath);
				}
				// save file code
				if (FileHelper.saveFile(part.getInputStream(), path)) {
					// out.println("Profile updated");
					Message msg = new Message("Profile details updated", "success", "alert-success");
					session.setAttribute("msg", msg);
				} else {
					// out.println("File not saved");
					Message msg = new Message("File not saved..!", "error", "alert-danger");
					session.setAttribute("msg", msg);
				}
			} else {
				// out.println("Profile not updated");
				Message msg = new Message("Something went wrong..!", "error", "alert-danger");
				session.setAttribute("msg", msg);
			}
			response.sendRedirect("profile.jsp");
		}
	}

}
