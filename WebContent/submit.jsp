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
<jsp:include page="head/markdown.jsp"></jsp:include>
<jsp:include page="head/basic.jsp"></jsp:include>
<title>Submit - HHSOJ</title>
</head>
<body>
	<jsp:include page="head.jsp"></jsp:include>
	<div class="container">
		<h1>Submit</h1>	
		<hr/>
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
	
	<div class="input-group" style="width:300px;">
		<div class="input-group-prepend">
     			<span class="input-group-text">Problem Set ID</span>
   		</div>
		<input id="set" value="<%=set %>" class="form-control">
	</div>
	
	<div class="input-group" style="width:300px;">
		<div class="input-group-prepend">
     			<span class="input-group-text">Problem ID</span>
   		</div>
		<input id="id" value="<%=id %>" class="form-control">
	</div>
	
	<div class="input-group" style="width:300px;">
		<div class="input-group-prepend">
     			<span class="input-group-text">Language</span>
   		</div>
		<select id="lang" class="form-control">
			<%
			HashMap<String,Language> arr=TomcatHelper.getLangs();
			
			for(Entry<String,Language> l:arr.entrySet()){
			%>
				<option value="<%=l.getKey() %>"><%=l.getValue().name %></option>
			<%
			}
			%>
		</select>
	</div>
	
	<textarea id="code" rows="20" cols="50"></textarea>
	<br/>
	
	<button id="submit" onclick="submit()" class="btn btn-primary">Submit!</button>
	
	</div>
	<script>
		function submit(){
			document.getElementById("submit").disabled=true;
			
			$.post("submitS",{
				"set":document.getElementById("set").value,
				"id":document.getElementById("id").value,
				"lang":document.getElementById("lang").value,
				"code":document.getElementById("code").value,
				
			},function(data,status){
				if(data=="OK"){
					window.location="status.jsp";
				}else{
					document.getElementById("submit").disabled=false;
					alert(data);
				}
			});
		}
	</script>
</body>
</html>