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
<jsp:include page="head/markdown.jsp"></jsp:include>
<jsp:include page="head/mathjax.jsp"></jsp:include>
<jsp:include page="head/basic.jsp"></jsp:include>
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
	<jsp:include page="head.jsp"></jsp:include>
	<div class="container">
		<h1>Submission #<%=id %></h1>
		<hr/>
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
		
		<div class="card">
	      <div class="card-header">
	        <a class="card-link" data-toggle="collapse" href="#cc">
	        Code
	        </a>
	      </div>
	      <div id="cc" class="collapse">
	        <div class="card-body">
	          <pre><%=s.code.replace("<", "&lt;").replace(">","&gt;") %></pre>
	        </div>
	      </div>
	    </div>
		
		<div class="card">
	      <div class="card-header">
	        <a class="card-link" data-toggle="collapse" href="#cr">
	        Compiler Information
	        </a>
	      </div>
	      <div id="cr" class="collapse">
	        <div class="card-body">
	          <pre><%=s.compilerInfo.replace("<", "&lt;").replace(">","&gt;") %></pre>
	        </div>
	      </div>
	    </div>
	    
		<h2>Testcase Detail</h2>
		<div id="superfa">
		<%
			for(Entry<String,TestsetResult> e:s.res.entrySet()){
			%>
				<div class="card">
					<div class="card-header">
						<a class="card-link" data-toggle="collapse" href="#set<%=e.getKey() %>">
							Subtask: <%=e.getKey() %> Verdict:<%=e.getValue().getVerdict()%> Score:<%=e.getValue().getScore(p.tests.get(e.getKey()).scheme) %>
						</a>
					</div>
					<div id="set<%=e.getKey() %>" class="collapse" data-parent="#superfa">
						<div class="card-body">
			<%
				int cnt=0;
				for(TestResult tr:e.getValue().res){
					cnt++;
			%>
							<div class="card">
								<div class="card-header">
									<a class="card-link" data-toggle="collapse" href="#tr<%=e.getKey()+"w"+cnt%>">
										<div class="row">
											<div class="col-sm-2"><b>Test <%=e.getKey()%>.<%=cnt %></b></div>
											<div class="col-sm-2">Verdict:<%=tr.verdict%> </div> 
											<div class="col-sm-2">Score:<%=tr.score %></div>
											<div class="col-sm-2">Time:<%=tr.time %>ms</div>
											<div class="col-sm-2">Memory:<%=tr.memory %>KB</div>
										</div>
									</a>
								</div>
								<div id="tr<%=e.getKey()+"w"+cnt%>" class="collapse" data-parent="#set<%=e.getKey() %>">
									<div class="card-body">
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
									</div>
								</div>
							</div>
			<%
				}
			%>
						</div>
					</div>
				</div>
				<br/>
			<%
			}
		%>
		
		</div>
	</div>
</body>
</html>