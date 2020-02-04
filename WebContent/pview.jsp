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
<jsp:include page="head/markdown.jsp"></jsp:include>
<jsp:include page="head/mathjax.jsp"></jsp:include>
<jsp:include page="head/basic.jsp"></jsp:include>
<title>Problem Viewing - HHSOJ</title>
</head>
<body>
	<jsp:include page="head.jsp"></jsp:include>
	<div class="container"> 
		<%
			String set=request.getParameter("set");
			String id=request.getParameter("id");
			if(set==null || id==null){
				response.sendRedirect("pset.jsp");
				return;
			}
			
			Problem p=TomcatHelper.getProblem(set,id);
			if(p==null){
				response.sendRedirect("pset.jsp");
				return;
			}
			
		%>
		<h1><%=p.set+"."+p.id+" - "+p.name %></h1>
		<hr/>
		<h2><%=p.name %></h2>
		<h5>Time Limit Per Test:<%=p.tl %> MS</h5>
		<h5>Memory Limit Per Test:<%=p.ml %> KB</h5>
		<h5>Problem Difficulty:<%=p.diff %>x</h5>
		<h5>Problem Version:v<%=p.ver %></h5> 
		<button onclick="reloadMathjax()">Render Mathjax Manually</button>
		<hr/>
		<div id="txt">Loading Statement...</div>
		<hr/>
		<a href="submit.jsp?set=<%=p.set%>&id=<%=p.id%>">Submit</a>
	</div>
	<script>
		$.post("requireStatement",{
			"set":"<%=p.set%>",
			"id":"<%=p.id%>"
		},function(data,status){
			var converter = new showdown.Converter();
		    var text=data;
		    html=converter.makeHtml(text);
		    document.getElementById("txt").innerHTML=html;
		    reloadMathjax();
		})
		
		function reloadMathjax(){
			MathJax.Hub.Queue(["Typeset",MathJax.Hub]);
		}
		
	</script>
</body>
</html>