<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sorry ! Something went wrong</title>
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
	<div class="container text-center">
		<img src="img/computer.png" class="img-fluid">
		<h3 class="display-3">Sorry! something went wrong...</h3>
		<%=exception%>
		<a href="index.jsp"
			class="btn primary-brackground btn-lg text-white mt-3">Home</a>
	</div>
</body>
</html>