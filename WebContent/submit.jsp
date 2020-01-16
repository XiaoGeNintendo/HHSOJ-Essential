<%@page import="com.hhs.xgn.hhsoj.essential.tomcat.util.HeadGenerator"%>
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
<%=HeadGenerator.getMarkdown() %>
<%=HeadGenerator.getBasic() %>
<title>Submit - HHSOJ</title>
</head>
<body>
	<jsp:include page="head.jsp"></jsp:include>
	<div class="container">
		<h1>Submit</h1>	
	
	<%
		if(session.getAttribute("username")==null){
			out.println("Login To Submit");
			return;
		}
	
		String set=request.getParameter("set");
		if(set==null){
			set="";
		}
		String id=request.getParameter("id");
		if(id==null){
			id="";
		}
	%>
	<center>
		Problem Set Id:<input id="set" value="<%=set %>"> <br/>
		Problem Id:<input id="id" value="<%=id %>"> <br/> 
		Language:<select id="lang">
			<%
			HashMap<String,Language> arr=TomcatHelper.getLangs();
			
			for(Entry<String,Language> l:arr.entrySet()){
			%>
				<option value="<%=l.getKey() %>"><%=l.getValue().name %></option>
			<%
			}
			%>
		</select> <br/>
		Code:<textarea id="code" rows="20" cols="50"></textarea> <br/>
		<button id="me" onclick="submit()">Submit</button>
	</center>
	</div>
	<script>
		function submit(){
			document.getElementById("me").disabled=true;
			
			$.post("submitS",{
				"set":document.getElementById("set").value,
				"id":document.getElementById("id").value,
				"lang":document.getElementById("lang").value,
				"code":document.getElementById("code").value,
				
			},function(data,status){
				if(data=="OK"){
					window.location="status.jsp";
				}else{
					document.getElementById("me").disabled=false;
					alert(data);
				}
			});
		}
	</script>
</body>
</html>