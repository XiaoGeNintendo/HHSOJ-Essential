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
<script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/showdown/1.9.1/showdown.min.js"></script>
<script src="https://cdn.staticfile.org/showdown/1.9.1/showdown.min.js.map"></script>
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {inlineMath: [['$','$']], displayMath: [['$$$','$$$']]}
});
</script>
<script type="text/javascript" async src="https://cdn.staticfile.org/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML" >
</script>
<title>Problem Viewing - HHSOJ</title>
</head>
<body>
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
	<center>
		<h1><%=p.set+"."+p.id+" - "+p.name %></h1>
		<jsp:include page="head.jsp"></jsp:include>
		<h2><%=p.name %></h2>
		<h5>Time Limit Per Test:<%=p.tl %> MS</h5>
		<h5>Memory Limit Per Test:<%=p.ml %> KB</h5>
		<h5>Problem Difficulty:<%=p.diff %>x</h5>
		<h5>Problem Version:v<%=p.ver %></h5> 
		<hr/>
	</center>
	<div id="txt">Loading Statement...</div>
	<hr/>
	<center>
		<a href="submit.jsp?set=<%=p.set%>&id=<%=p.id%>">Submit</a>
	</center>
	
	<script>
		$.post("requireStatement",{
			"set":"<%=p.set%>",
			"id":"<%=p.id%>"
		},function(data,status){
			var converter = new showdown.Converter();
		    var text=data;
		    html=converter.makeHtml(text);
		    document.getElementById("txt").innerHTML=html;
		})
		
	</script>
</body>
</html>