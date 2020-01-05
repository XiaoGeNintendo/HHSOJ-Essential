<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<hr/>
<%
	if(session.getAttribute("username")==null){
		out.print("<a href=\"login.jsp\">Login</a>");
	}else{
		out.print(session.getAttribute("username")+"|<a href=\"logoutS\">Logout</a>");
	}
%>
<hr/>
<a href="index.jsp">Index</a>
<a href="pset.jsp">Problemsets</a> 
<hr/>