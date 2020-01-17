<%@page import="java.util.Date"%>
<%@page import="com.hhs.xgn.hhsoj.essential.common.Problemset"%>
<%@page import="com.hhs.xgn.hhsoj.essential.tomcat.util.TomcatHelper"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="head/markdown.jsp"></jsp:include>
<jsp:include page="head/basic.jsp"></jsp:include>
<title>Problemset - HHSOJ</title>
</head>
<body>
	<jsp:include page="head.jsp"></jsp:include>
	<div class="container">
		<h1>Problemsets</h1>
		<hr>
		<%
			ArrayList<Problemset> arr=TomcatHelper.getProblemsets();
			for(Problemset p:arr){
				
		%>
				<a href="plist.jsp?id=<%=p.id %>"><h1><%=p.name %></h1></a> opens at <b><%=new Date(p.stTime) %></b> freezes at <b><%=new Date(p.edTime) %></b>
		<%
			}
			
		%>
	</div>
</body>
</html>