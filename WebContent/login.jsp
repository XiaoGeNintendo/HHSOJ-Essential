<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Login - HHSOJ</title>
	<script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js"></script>
</head>
<body>
	<center>
		Username:<input id="user"> <br/>
		Password:<input id="pass" type="password"> <br/>
		<button onclick="submit()">Login</button>
		<button onclick="reg()">Register</button>
	</center>
	
	<script>
		function submit(){
			$.post("loginS",{
				"username":document.getElementById("user").value,
				"password":document.getElementById("pass").value,
			},function(data,status){
				if(data=="OK"){
					document.write('<a href="index.jsp">Success</a>')
				}else{
					alert(data);
				}
			});
		}
		function reg(){
			$.post("regS",{
				"username":document.getElementById("user").value,
				"password":document.getElementById("pass").value,
			},function(data,status){
				alert(data);
			});
		}
	</script>
</body>
</html>