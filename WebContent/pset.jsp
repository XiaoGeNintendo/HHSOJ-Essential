<%@page import="java.util.Date"%>
<%@page import="com.hhs.xgn.hhsoj.essential.common.Problemset"%>
<%@page import="com.hhs.xgn.hhsoj.essential.tomcat.util.TomcatHelper"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Problemset - HHSOJ</title>
</head>
<body>
	<center>
		<h1>Problemsets</h1>
		<jsp:include page="head.jsp"></jsp:include>
		
		<%
			ArrayList<Problemset> arr=TomcatHelper.getProblemsets();
			for(Problemset p:arr){
				
		%>
				<a href="problemList.jsp?id=<%=p.id %>"><h1><%=p.name %></h1></a> opens at <b><%=new Date(p.stTime) %></b> freezes at <b><%=new Date(p.edTime) %></b>
		<%
			}
			
		%>
	</center>
</body>
</html>