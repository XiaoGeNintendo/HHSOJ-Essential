<%@page import="com.hhs.xgn.hhsoj.essential.common.Problem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="com.hhs.xgn.hhsoj.essential.tomcat.util.TomcatHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Problemlist - HHSOJ</title>
</head>
<body>
	<center>
		<h1>Problem list of <%=request.getParameter("id")%></h1>
		<i>OJ by XGN from HHS</i>
		<jsp:include page="head.jsp"></jsp:include>
		<a href="pset.jsp">Back</a>
	</center>
	<%
		try{
			String res=request.getParameter("id");
			ArrayList<Problem> allP=TomcatHelper.getAllProblems(res);
			
			for(Problem p:allP){
	%>
				<a href="pview.jsp?set=<%=res %>&id=<%=p.id %>"><%=p.id+" - "+p.name %></a> <br/>				
	<%
			}
		}catch(Exception e){
			out.println("Nope");
		}
	%>
</body>
</html>