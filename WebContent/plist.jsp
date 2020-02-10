<%@page import="com.hhs.xgn.hhsoj.essential.common.Problem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="com.hhs.xgn.hhsoj.essential.tomcat.util.TomcatHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="head/markdown.jsp"></jsp:include>
<jsp:include page="head/basic.jsp"></jsp:include>
<title>Problemlist - HHSOJ</title>
</head>
<body>
	<jsp:include page="topbar.jsp"></jsp:include>
	<div class="container">
		<h1>Problem list of <%=request.getParameter("id")%></h1>
		<a href="pset.jsp">Back</a>
		<hr/>
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
	</div>
</body>
</html>