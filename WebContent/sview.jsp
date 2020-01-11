<%@page import="com.hhs.xgn.hhsoj.essential.common.TestResult"%>
<%@page import="com.hhs.xgn.hhsoj.essential.common.TestsetResult"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="com.hhs.xgn.hhsoj.essential.common.Submission"%>
<%@page import="com.hhs.xgn.hhsoj.essential.common.Problem"%>
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

<title>Submission Viewing - HHSOJ</title>
</head>
<body>
	<%
		
		String id=request.getParameter("id");
		if(id==null){
			response.sendRedirect("status.jsp");
			return;
		}
		
		Submission s=TomcatHelper.getSubmission(id); 
		Problem p=TomcatHelper.getProblem(s.problemSet, s.problemId);
		if(s==null || p==null){
			response.sendRedirect("status.jsp");
			return;
		}
	%>
	
	<center>
		<h1>Submission #<%=id %></h1>
		<jsp:include page="head.jsp"></jsp:include>
	</center>
	
	<h2>Basic Information</h2>
	Id:<%=s.id %><br/>
	Submit Time:<%=new Date(s.submitTime) %><br/>
	Author:<%=s.author %><br/>
	Problem:<a href="pview.jsp?set=<%=s.problemSet%>&id=<%=s.problemId %>"><%=s.problemSet+"."+s.problemId %></a><br/>
	Score:<%=String.format("%.1f", 100*s.score) %><br/>
	Test:<%=(s.isFinal?"Final":s.test) %><br/>
	Language:<%=s.lang %><br/>
	Time:<%=s.getRunTime() %><br/>
	Memory:<%=s.getRunMem() %><br/>
	Judger:<%=s.judger %> <br/>
	
	<h2>Code</h2>
	<pre><%=s.code.replace("<", "&lt;").replace(">","&gt;") %>
	</pre>
	<h2>Compiler Information</h2>
	<pre><%=s.compilerInfo.replace("<", "&lt;").replace(">","&gt;") %>
	</pre>
	<h2>Testcase Detail</h2>
	<%
		for(Entry<String,TestsetResult> e:s.res.entrySet()){
		%>
			<table border="2">
				<tr>
					<th align="left">Subtask: <%=e.getKey() %> [<%=e.getValue().getVerdict()%>;<%=e.getValue().getScore(p.tests.get(e.getKey()).scheme) %>]</th>
				</tr>
				<tr><td>
		<%
			int cnt=0;
			for(TestResult tr:e.getValue().res){
				cnt++;
		%>
				<table border="1">
					<tr>
						<th align="left">Test <%=e.getKey()%>.<%=cnt %> [<%=tr.verdict%>;<%=tr.score %>] (<%=tr.time %> ms;<%=tr.memory %> KB)</th>
					</tr>
					<tr><td>
						<h5>Input</h5>
						<pre><%=tr.input.replace("<", "&lt;").replace(">","&gt;") %>
						</pre>
						<h5>Output</h5>
						<pre><%=tr.output.replace("<", "&lt;").replace(">","&gt;") %>
						</pre>
						<h5>Answer</h5>
						<pre><%=tr.answer.replace("<", "&lt;").replace(">","&gt;") %>
						</pre>
						<h5>Checker Information</h5>
						<pre><%=tr.info.replace("<", "&lt;").replace(">","&gt;") %>
						</pre>
					</td></tr>
				</table> <br/>
		<%
			}
		%>
			</td></tr>
			</table> <br/>
		<%
		}
	%>
</body>
</html>