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
		<h1>Login/Register</h1>
		<i>@XGN can u make two seperate pages?? --Zzzyt</i>
		<hr/>
		<div class="card center-form"><div class="card-body">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="Username" id="user" maxlength="50" />
			</div>
			
			<div class="input-group">
				<input type="text" class="form-control" placeholder="Password" id="pass" type="password" maxlength="50" />
			</div>
			
			<div class="input-group">
				<button class="form-control btn btn-primary" onclick="submit()">Login</button>
				<button class="form-control btn btn-primary" onclick="reg()">Register</button>
			</div>
		</div></div>

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