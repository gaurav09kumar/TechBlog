package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.FileHelper;

import jakarta.servlet.http.Part;

/**
 * Servlet implementation class AddPostServlet
 */
@MultipartConfig
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddPostServlet() {
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
			int cid = Integer.parseInt(request.getParameter("cId"));
			String pTitle = request.getParameter("pTitle");
			String pContent = request.getParameter("pContent");
			String pCode = request.getParameter("pCode");
			Part part = request.getPart("pPic");
			String imageName = part.getSubmittedFileName();

			// get current User Id
			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("currentUser");
			int uId = user.getId();

			// Post p object has all the data now
			Post p = new Post(pTitle, pContent, pCode, imageName, null, cid, uId);
			// Provide connection to PostDao
			PostDao dao = new PostDao(ConnectionProvider.getConnection());
			// call the save post method
			if (dao.savePost(p)) {
				// if post is successful then save the post pic in below path
				String path = request.getServletContext().getRealPath("/") + "posts_pics" + File.separator + imageName;

				FileHelper.saveFile(part.getInputStream(), path);

				out.println("done");
			} else {
				out.println("error while adding a post");
			}
		}
	}

}
