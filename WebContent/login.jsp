<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="head/markdown.jsp"></jsp:include>
<jsp:include page="head/basic.jsp"></jsp:include>
<title>Login - HHSOJ</title>
</head>
<body>
	<jsp:include page="head.jsp"></jsp:include>
	<div class="container">
		<center>
			Username:<input id="user"> <br /> Password:<input id="pass"
				type="password"> <br />
			<button onclick="submit()">Login</button>
			<button onclick="reg()">Register</button>
		</center>

		<script>
			function submit() {
				$.post("loginS", {
					"username" : document.getElementById("user").value,
					"password" : document.getElementById("pass").value,
				}, function(data, status) {
					if (data == "OK") {
						window.location = "index.jsp";
					} else {
						alert(data);
					}
				});
			}
			function reg() {
				$.post("regS", {
					"username" : document.getElementById("user").value,
					"password" : document.getElementById("pass").value,
				}, function(data, status) {
					alert(data);
				});
			}
		</script>
	</div>
</body>
</html>