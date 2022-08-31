<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp"%>
<%@ page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@ page import="com.tech.blog.entities.Category"%>
<%@ page import="com.tech.blog.dao.PostDao"%>
<%@ page import="com.tech.blog.dao.LikeDao"%>
<%@ page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="java.util.ArrayList"%>
<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("login_page.jsp");
}
%>
<%
int postId = Integer.parseInt(request.getParameter("post_id"));
PostDao pdao = new PostDao(ConnectionProvider.getConnection());
Post p = pdao.getPostByPostId(postId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=p.getpTitle()%> || TechBlog</title>
<!-- Bootstrap CSS only -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx"
	crossorigin="anonymous">

<link href="css/mystyle.css" rel="stylesheet" type="text/css">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
.banner-background {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 94%, 70% 100%, 40% 95%, 0 100%, 0 0
		);
}

.post-title {
	font-weight: 100;
	fonr-size: 30px;
}

.post-content {
	font-weight: 150;
	fonr-size: 50px;
}

.post-user-info {
	font-size: 15px;
}

.post-date {
	font-style: italic;
	font-weight: bold;
	font-size: 15px;
}

.row-user {
	border: 1px solid #e2e2e2;
	padding-top: 15px;
}

body {
	background: url(img/blue-abstract-gradient-wave-wallpaper.jpg);
	background-size: cover;
	background-attachment: fixed;
}
</style>
</head>
<body>
	<!-- nav bar begins -->
	<nav class="navbar navbar-expand-lg navbar-dark primary-brackground">
		<div class="container-fluid">
			<a class="navbar-brand" href="index.jsp"><span
				class="fa fa-asterisk"></span> Tech Blog</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="profile.jsp"><span
							class="fa fa-book"></span> Learn</a></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
							<span class="fa fa-bars"></span> Categories
					</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="#">Programming
									Language</a></li>
							<li><a class="dropdown-item" href="#">Project
									Implementation</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">Data Structure</a></li>
						</ul></li>
					<li class="nav-item"><a class="nav-link" href="#"><span
							class="fa fa-address-book"></span> Contact</a></li>
					<li class="nav-item"><a class="nav-link" href="#!"
						data-bs-toggle="modal" data-bs-target="#add-post-modal"><span
							class="fa fa-pencil-square-o"></span> Do Post</a></li>
				</ul>

				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="#!"
						data-bs-toggle="modal" data-bs-target="#profile-modal"><span
							class="fa fa-user-circle"></span> <%=user.getName()%></a></li>
					<li class="nav-item"><a class="nav-link" href="LogoutServlet"><span
							class="fa fa-sign-out"></span> Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!--  Nav bar ends -->
	<!-- Main content of body -->
	<div class="container">
		<div class="row my-4">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-header primary-brackground text-white">
						<h4 class="post-title"><%=p.getpTitle()%></h4>
					</div>

					<div class="card-body">
						<img class="card-img-top my-2" src="posts_pics/<%=p.getpPic()%>"
							alt="...">
						<div class="row my-3 row-user">
							<div class="col-md-7">
								<%
								UserDao userdao = new UserDao(ConnectionProvider.getConnection());
								%>
								<p class="post-user-info">
									<a href="#!"><%=userdao.getUserByUserId(p.getUserId()).getName()%></a>
									has posted
								</p>
							</div>
							<div class="col-md-5">
								<p class="post-date"><%=DateFormat.getDateTimeInstance().format(p.getpDate())%></p>
							</div>
						</div>
						<p class="post-content"><%=p.getpContent()%></p>
						<br>
						<div class="post-code">
							<pre><%=p.getpCode()%></pre>
						</div>
					</div>
					<div class="card-footer primary-brackground">
					<%
					LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
					%>
						<a href="#!" onclick="doLike(<%=p.getpId() %>,<%=user.getId()%>)" class="btn btn-outline-light btn-sm"><i
							class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%= ldao.countLikeOnPost(p.getpId()) %></span></a> <a href="#!"
							class="btn btn-outline-light btn-sm"><i
							class="fa fa-commenting-o"></i> <span>10</span></a>
					</div>
				</div>
			</div>

		</div>

	</div>

	<!-- End of main content of body -->

	<!-- Profile Modal -->
	<div class="modal fade" id="profile-modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header primary-brackground text-white">
					<h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="container text-center rounded-circle">
						<img src="pics/<%=user.getProfile()%>" class="img-fluid"
							style="height: 120px; width: 120px; border-radius: 50%;"
							alt="User Profile Pic"><br>
						<h5 class="modal-title" id="exampleModalLabel"><%=user.getName()%></h5>
						<!-- Display user details in table -->
						<div id="profile-details">
							<table class="table">
								<tbody>
									<tr>
										<th scope="row">ID :</th>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><%=user.getEmail()%></td>
									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td colspan="2"><%=user.getGender()%></td>
									</tr>
									<tr>
										<th scope="row">Status :</th>
										<td colspan="2"><%=user.getAbout()%></td>
									</tr>
									<tr>
										<th scope="row">Registered On :</th>
										<td colspan="2"><%=user.getDateTime().toString()%></td>
									</tr>
								</tbody>
							</table>
						</div>
						<!-- profile edit -->
						<div id="profile-edit" style="display: none;">
							<h3 class="mt-2">Please Edit carefully</h3>
							<form action="EditServlet" method="post"
								enctype="multipart/form-data">
								<table class="table">
									<tbody>
										<tr>
											<th scope="row">ID :</th>
											<td><%=user.getId()%></td>
										</tr>
										<tr>
											<th scope="row">Email :</th>
											<td><input name="user_email" type="email"
												class="form-control" id="exampleInputEmail1"
												value="<%=user.getEmail()%>"></td>
										</tr>
										<tr>
											<th scope="row">Name :</th>
											<td><input name="user_name" type="text"
												class="form-control" id="exampleInputName"
												value="<%=user.getName()%>"></td>
										</tr>
										<tr>
											<th scope="row">Password :</th>
											<td><input name="user_password" type="password"
												class="form-control" id="exampleInputPassword"
												value="<%=user.getPassword()%>"></td>
										</tr>
										<tr>
											<th scope="row">Gender :</th>
											<td><%=user.getGender().toUpperCase()%></td>
										</tr>
										<tr>
											<th scope="row">Status :</th>
											<td><textarea rows="3" name="about" class="form-control"
													id=""><%=user.getAbout()%></textarea></td>
										</tr>
										<tr>
											<th scope="row">New profile picture :</th>
											<td><input name="image" type="file" class="form-control"
												id="image"></td>
										</tr>
									</tbody>
								</table>
								<div class="container">
									<button type="submit" class="btn btn-outline-primary">Save</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button id="edit-profile-button" type="button"
						class="btn btn-primary">EDIT</button>
				</div>
			</div>
		</div>
	</div>


	<!-- End of profile Modal -->
	<!-- Add post modal -->

	<!-- Modal -->
	<div class="modal fade" id="add-post-modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header primary-brackground text-white">
					<h5 class="modal-title" id="exampleModalLabel">Provide the
						post details</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="add-post-form" action="AddPostServlet" method="POST">
						<div class="form-group">
							<select name="cId" class="form-select"
								aria-label="Default select example">
								<option selected disabled>---Select Category---</option>
								<%
								PostDao postdao = new PostDao(ConnectionProvider.getConnection());
								ArrayList<Category> clist = postdao.getAllCategories();
								for (Category c : clist) {
								%>
								<option value="<%=c.getCategoriesId()%>"><%=c.getName()%></option>
								<%
								}
								%>

							</select>
						</div>
						<div class="form-group mt-2">
							<input name="pTitle" type="text" placeholder="Enter Post Title"
								class="form-control">
						</div>

						<div class="form-group mt-2">
							<textarea name="pContent" class="form-control"
								style="height: 150px;" placeholder="Enter your content"></textarea>
						</div>

						<div class="form-group mt-2">
							<textarea name="pCode" class="form-control"
								style="height: 150px;" placeholder="Enter your Code(if any)"></textarea>
						</div>

						<div class="form-group mt-2 form-control">
							<label>Select picture for your post :</label><br> <input
								name="pPic" type="file" id="pPic">
						</div>
						<div class="container text-center text-white mt-2">
							<button type="submit" class="btn btn-primary">Post</button>
						</div>
					</form>


				</div>
			</div>
		</div>
	</div>


	<!--  End of Post modal -->
	<!-- JavaScript Bundle with Popper -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
	<script src="js/myjs.js" type="text/javascript">
		
	</script>

	<script>
		$(document).ready(function() {

			let editStatus = false;

			$('#edit-profile-button').click(function() {
				if (editStatus == false) {
					$('#profile-details').hide()

					$('#profile-edit').show();

					editStatus = true;
					$(this).text("Back")
				} else {
					$('#profile-details').show()

					$('#profile-edit').hide();

					editStatus = false;
					$(this).text("EDIT")
				}
			})
		});
	</script>

	<!-- Now add post JS -->
	<script>
		$(document)
				.ready(
						function(e) {
							$("#add-post-form")
									.on(
											"submit",
											function(event) {
												//this code is called when form is submitted
												event.preventDefault(); //prevent synchronus form submit
												console
														.log("you have clicked on submit..")
												let form = new FormData(this);
												//now requesting to server
												$
														.ajax({
															url : "AddPostServlet",
															type : 'POST',
															data : form,
															success : function(
																	data,
																	textStatus,
																	jqXHR) {
																//success
																console
																		.log(data)
																if (data.trim() == 'done') {
																	swal(
																			"Good job!",
																			"You clicked the button!",
																			"success");
																} else {
																	swal(
																			"ERROR!",
																			"Something went wrong try again..",
																			"error");
																}
															},
															error : function(
																	jqXHR,
																	textStatus,
																	errorThrown) {
																//error
																swal(
																		"ERROR!",
																		"Something went wrong try again..",
																		"error");
															},
															processData : false,
															contentType : false
														})
											})
						})
	</script>
	<!-- End of add post JS -->

	<script>
		function getPosts(catId, temp) {
			$("#loader").show();
			$("#post-container").hide()
			$(".c-link").removeClass('active')

			$.ajax({
				url : "load_posts.jsp",
				data : {
					categoriesId : catId
				},
				success : function(data, textStatus, jqXHR) {
					console.log(data);
					$("#loader").hide();
					$("#post-container").show();
					$("#post-container").html(data)
					$(temp).addClass('active')
				}
			})
		}
	</script>
</body>
</html>