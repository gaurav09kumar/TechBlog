<%@page import="java.util.List"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.entities.User"%>
<!-- java scriplet -->
<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("login_page.jsp");
}
%>
<div class="row">
	<%
	Thread.sleep(1000);
	PostDao postdao = new PostDao(ConnectionProvider.getConnection());

	//if catId = 0 then fetch all posts, if catId > 0 fetch all posts of catId
	int cId = Integer.parseInt(request.getParameter("categoriesId"));
	List<Post> posts = null;
	if (cId == 0) {
		posts = postdao.getAllPosts();
	} else {
		posts = postdao.getPostByCategoryId(cId);
	}

	if (posts.size() == 0) {
		out.println("<h3 class='display-4 text-center'>No posts for this category....</h3>");
		return;
	}

	for (Post p : posts) {
	%>

	<div class="col-md-6 mt-2">
		<div class="card">
			<img class="card-img-top" src="posts_pics/<%=p.getpPic()%>" alt="...">
			<div class="card-body">
				<b><%=p.getpTitle()%></b>
				<p><%=p.getpContent()%></p>

			</div>
			<div class="card-footer primary-brackground text-center">
			<% 
                    LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                %>

                <a href="#!" onclick="doLike(<%= p.getpId()%>,<%= user.getId()%>,this)" class="btn btn-outline-light btn-sm"> <i class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%= ld.countLikeOnPost(p.getpId())%></span>  </a>
 <a
					href="show_blog_page.jsp?post_id=<%=p.getpId()%>"
					class="btn btn-outline-light btn-sm">Read More</a> <a href="#!"
					class="btn btn-outline-light btn-sm"><i
					class="fa fa-commenting-o"></i> <span>10</span></a>
			</div>
		</div>
	</div>

</div>

<%
}
%>