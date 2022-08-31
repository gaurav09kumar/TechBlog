<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Page</title>
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
	<main class="primary-brackground p-5 banner-background">

		<div class="container">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-header primary-brackground text-white text-center">
						<span class="fa fa-3x fa-user-circle"></span><br>Register
						Here
					</div>
					<div class="card-body">
						<form id="register-form" action="RegisterServlet" method="POST">
							<div class="mb-3">
								<label for="user_name" class="form-label">User Name</label> <input
									name="user_name" type="text" class="form-control"
									id="user_name" aria-describedby="emailHelp"
									placeHolder="Enter name">
							</div>
							<div class="mb-3">
								<label for="exampleInputEmail1" class="form-label">Email
									address</label> <input name="user_email" type="email"
									class="form-control" id="exampleInputEmail1"
									aria-describedby="emailHelp" placeHolder="Enter Email Id">
								<div id="emailHelp" class="form-text">We'll never share
									your email with anyone else.</div>
							</div>
							<div class="mb-3">
								<label for="exampleInputPassword1" class="form-label">Password</label>
								<input name="user_password" type="password" class="form-control"
									id="exampleInputPassword1" placeHolder="Enter Password">
							</div>
							<div class="mb-3">
								<label for="gender" class="form-label">Select Gender</label><br>
								<input type="radio" id="gender" name="gender" value="male">Male
								<input type="radio" id="gender" name="gender" value="female">Female
							</div>
							<div class="mb-3">
								<textarea name="about" class="form-control" id="" rows="4"
									placeholder="Enter something about yourself"></textarea>
							</div>
							<div class="mb-3 form-check">
								<input name="check" type="checkbox" class="form-check-input"
									id="exampleCheck1"> <label class="form-check-label"
									for="exampleCheck1">Agree - Terms & Conditions</label>
							</div>
							<div class="container text-center" id="loader"
								style="display: none">
								<span class="fa fa-refresh fa-spin"></span>
								<h4>Please wait...</h4>
							</div>
							<button id="submit_btn" type="submit" class="btn btn-primary">Submit</button>
						</form>
					</div>
				</div>
			</div>
		</div>

	</main>
	<!-- JavaScript Bundle with Popper -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa"
		crossorigin="anonymous"></script>

	<script src="js/myjs.js" type="text/javascript"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
	<script>
		$(document).ready(function() {
			console.log("loaded...........")

			$('#register-form').on('submit', function(event) {
				//dont redirect to RegisterServlet page
				event.preventDefault();

				//
				let form = new FormData(this);

				$('#submit_btn').hide();
				$('#loader').show();
				//send register servlet:
				$.ajax({
					url : "RegisterServlet",
					type : 'POST',
					data : form,
					success : function(data, textStatus, jqXHR) {
						console.log(data)
						$('#submit_btn').show();
						$('#loader').hide();
						
						if(data.trim()=='done'){
						swal("Registered successfully..we are going to  redirect to login page")
						.then((value) => {
							window.location="login_page.jsp"
						});}
						else{
							swal(data);
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						$('#submit_btn').show();
						$('#loader').hide();
						swal("Something went wrong..try again");
					},
					processData : false,
					contentType : false

				});
			})
		})
	</script>
</body>
</html>