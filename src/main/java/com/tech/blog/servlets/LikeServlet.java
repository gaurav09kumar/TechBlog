package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.LikeDao;
import com.tech.blog.helper.ConnectionProvider;

/**
 * Servlet implementation class LikeServlet
 */
public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			/* TODO output your page here. You may use following sample code. */
			String operation = request.getParameter("operation");
			int userId = Integer.parseInt(request.getParameter("userId"));
			int pid = Integer.parseInt(request.getParameter("pid"));

//			out.println("data from server");
//			out.println(operation);
//			out.println(userId);
//			out.println(pid);
			  LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
	            if (operation.equals("like")) {
	                boolean f=ldao.insertLike(pid, userId);
	                out.println(f);
	            }
		}
	}

}
