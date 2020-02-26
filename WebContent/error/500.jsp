<%@ page isErrorPage="true"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.StringWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>500 Internal Server Error - HHSOJ</title>
<style>
body {
	background: #f8f8f8;
	padding-top: 50px;
}

.main {
	width: 80%;
	margin: 0px auto;
}

h1 {
	font-size:50px;
	font-weight: bold;
	font-family: "Consolas", "Courier New", Courier, monospace;
}

i {
	color: #777777;
	font-family: "Consolas", "Courier New", Courier, monospace;
}

a {
	font-family: "Consolas", "Courier New", Courier, monospace;
}

span{
	color: #777777;
}

code, kbd, pre, samp {
	padding:5px;
	border-radius: 3px;
	background-color: #f0f0f0;
}
</style>
</head>
<body>
	<div class="main">
		<h1>500 Internal Server Error</h1>
		<i>I guess my IQ was </i><span>&#9320;</span><i> when I was coding this :(</i><br/>
		<i style="padding-left:360px;">---Zzzyt</i><br/>
		<br/>
		<a href="javascript:history.back(0);">Back to where I came from</a><br/>
		<br/>
		<br/>
		<pre><%
StringWriter sw = new StringWriter();
exception.printStackTrace(new PrintWriter(sw));
out.println(sw.toString().replace("<","&lt;").replace(">","&gt;"));
%></pre>
	</div>
</body>
</html>