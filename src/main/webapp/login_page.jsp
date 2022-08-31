<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.tech.blog.entities.Message"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
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
</style>
</head>
<body>
	<!-- navbar reference file-->
	<%@include file="normal_navbar.jsp"%>

	<main
		class="d-flex align-items-center primary-brackground banner-background"
		style="height: 80vh">
		<div class="container">
			<div class="row">
				<div class="col-md-4 offset-md-4">
					<div class="card">
						<div
							class="card-header primary-brackground text-white text-center">
							<span class="fa fa-user fa-3x"></span>
							<p>Login here</p>
						</div>

						<%
						Message m = (Message) session.getAttribute("msg");
						if (m != null) {
						%>

						<div class="alert <%=m.getCssClass()%>" role="alert">
							<%=m.getMessageContent()%>
						</div>
						<%
						session.removeAttribute("msg");
						}
						%>

						<div class="card-body">
							<form id="login-form" action="LoginServlet" method="POST">
								<div class="mb-3">
									<label for="exampleInputEmail1" class="form-label">Email
										address</label> <input name="user_email" required type="email"
										class="form-control" id="exampleInputEmail1"
										aria-describedby="emailHelp">
								</div>
								<div class="mb-3">
									<label for="exampleInputPassword1" class="form-label">Password</label>
									<input name="user_password" required type="password"
										class="form-control" id="exampleInputPassword1">
								</div>
								<div class="container text-center ">
									<button type="submit"
										class="btn btn-primary primary-brackground">Submit</button>
								</div>

							</form>
						</div>

					</div>
				</div>
			</div>
		</div>
	</main>
</body>
</html>