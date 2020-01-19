<%@page import="java.util.Comparator"%>
<%@page import="com.hhs.xgn.hhsoj.essential.common.CommonUtil"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Date"%>
<%@page import="com.hhs.xgn.hhsoj.essential.common.Submission"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.hhs.xgn.hhsoj.essential.common.Language"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hhs.xgn.hhsoj.essential.tomcat.util.TomcatHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="head/basic.jsp"></jsp:include>
<title>Status - HHSOJ</title>
</head>
<body>
<jsp:include page="head.jsp"></jsp:include>
	<div class="container">
		<h1>Status</h1>
		<hr/>
		<table class="table table-bordered table-sm status-table">
			<tr>
				<th>#</th>
				<th>Time</th>
				<th>Author</th>
				<th>Problem</th>
				<th>Score</th>
				<th>Tests</th>
				<th>Lang</th>
				<th>Time</th>
				<th>Memory</th>
			</tr>
			<%
				ArrayList<Submission> arr=TomcatHelper.getAllSubmissions();
				arr.sort(new Comparator<Submission>(){
					public int compare(Submission a,Submission b){
						return -Long.compare(a.id, b.id);
					}
				});
				for(Submission s:arr){
			%>
				<tr bgcolor="<%=(s.author.equals(session.getAttribute("username"))?"#def":"white")%>">
					<td><a href="sview.jsp?id=<%=s.id %>"><%=s.id %></a></td>
					<td><%=new Date(s.submitTime) %></td>
					<td><%=s.author %></td>
					<td><a href="pview.jsp?set=<%=s.problemSet%>&id=<%=s.problemId %>"><%=s.problemSet+"."+s.problemId %></a></td>
					<td align="center"><b style="color:rgb<%=CommonUtil.colorize(s.score) %>"><%=String.format("%.0f", 100*s.score) %></b></td>
					<td><%=(s.isFinal?"Final":s.test) %></td>
					<td><%=s.lang %></td>
					<td><%=s.getRunTime() %></td>
					<td><%=s.getRunMem() %></td>
				</tr>
			<%
				}
			%>
		
		</table>
	</div>
</body>
</html>