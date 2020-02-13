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
<jsp:include page="head/basic.jsp"></jsp:include>
<jsp:include page="head/mathjax.jsp"></jsp:include>
<jsp:include page="head/markdown.jsp"></jsp:include>
<title>Submission Viewing - HHSOJ</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		if (id == null) {
			response.sendRedirect("status.jsp");
			return;
		}

		Submission s = TomcatHelper.getSubmission(id);
		Problem p = TomcatHelper.getProblem(s.problemSet, s.problemId);
		if (s == null || p == null) {
			response.sendRedirect("status.jsp");
			return;
		}
	%>
	<jsp:include page="topbar.jsp"></jsp:include>
	<div class="container">
		<h1 style="display:inline;">#<%=id%> </h1>
		<i style="font-size:20px;"> by <%=s.author %></i>
		<span class="title-right">
			Submit Time: <%=new Date(s.submitTime) %><br/>
			Judger: <%=s.judger %> <br/>
		</span>
		<hr />
		<span><%=(s.isFinal?"Final":"Running on "+s.test) %> / <%=s.getRunTime() %>ms / <%=s.getRunMem() %>KB</span><br/>
		<span>Score: <%=String.format("%.1f", 100*s.score) %></span><br/>
		<span>Problem: <a href="pview.jsp?set=<%=s.problemSet%>&id=<%=s.problemId %>"><%=s.problemSet+"."+s.problemId %></a></span><br/>
		<span>Language: <%=s.lang %></span>
		<hr/>
		<div class="card">
			<div class="card-header">
				<ul class="nav nav-tabs card-header-tabs" role="tablist">
					<li class="nav-item"><a class="nav-link active"
						data-toggle="tab" href="#testcase" role="tab" aria-controls="testcase"
						aria-selected="true">Testcase Details</a>
					</li>
					<li class="nav-item"><a class="nav-link"
						data-toggle="tab" href="#code" role="tab" aria-controls="code"
						aria-selected="false">Code</a>
					</li>
					<li class="nav-item"><a class="nav-link"
						data-toggle="tab" href="#compiler" role="tab" aria-controls="compiler"
						aria-selected="false">Compiler Info</a>
					</li>
				</ul>
			</div>
			<div class="card-body">
				<div class="tab-content">
					<div class="tab-pane show active" id="testcase" role="tabpanel" aria-labelledby="testcase-tab">
						<div id="superfa">
						<%
							for(Entry<String,TestsetResult> e:s.res.entrySet()){
							%>
								<div class="card card-collapse">
									<div class="card-header">
										<a class="card-link" data-toggle="collapse" href="#set<%=e.getKey() %>">
											<div class="row">
												<div class="col-sm-2"><b>Subtask: <%=e.getKey() %></b></div>
												<div class="col-sm-2">Score:<%=e.getValue().getScore(p.tests.get(e.getKey()).scheme) %></div>
												<div class="col-sm-2"><%=e.getValue().getVerdict()%></div> 
											</div>
										</a>
									</div>
									<div id="set<%=e.getKey() %>" class="collapse" data-parent="#superfa">
										<div class="card-body">
							<%
								int cnt=0;
								for(TestResult tr:e.getValue().res){
									cnt++;
							%>
											<div class="card card-collapse">
												<div class="card-header">
													<a class="card-link" data-toggle="collapse" href="#tr<%=e.getKey()+"w"+cnt%>">
														<div class="row">
															<div class="col-sm-2"><b>Test <%=e.getKey()%>.<%=cnt %></b></div>
															<div class="col-sm-2">Score:<%=tr.score %></div>
															<div class="col-sm-4"><%=TomcatHelper.frontendRenderer(tr.verdict)%></div> 
															<div class="col-sm-3"><%=tr.time %>ms / <%=tr.memory %>KB</div>
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
							<%
							}
						%>
						</div>
					</div>
					<div class="tab-pane" id="code" role="tabpanel" aria-labelledby="code-tab">
						<pre><code class="<%=s.lang %> language-<%=s.lang %>"><%=s.code.replace("<", "&lt;").replace(">","&gt;")%></code></pre>
					</div>
					<div class="tab-pane" id="compiler" role="tabpanel" aria-labelledby="compiler-tab">
						<pre><%=s.compilerInfo.replace("<", "&lt;").replace(">","&gt;") %></pre>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>