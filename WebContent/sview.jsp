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
		String id;
		Submission s;
		Problem p;
		try{
			id = request.getParameter("id");
			if (id == null) {
				response.sendRedirect("status.jsp");
				return;
			}
	
			s = TomcatHelper.getSubmission(id);
			p = TomcatHelper.getProblem(s.problemSet, s.problemId);
			if (s == null || p == null) {
				response.sendRedirect("status.jsp");
				return;
			}
		}catch(Exception e){
			out.println("Go to <a href=\"https://en.touhouwiki.net/wiki/Gensokyo\">Gensokyo</a> for fulfilling your desire!");
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
		
		<a href="rejudge.jsp?id=<%=id %>" class="btn btn-primary">Rejudge</a>
		
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
							boolean flag=true;
							for(Entry<String,TestsetResult> e:s.res.entrySet()){
							%>
								<div class="card card-collapse">
									<div class="card-header">
										<a class="card-link" data-toggle="collapse" href="#set<%=e.getKey() %>" aria-expanded="<%=flag%>" aria-controls="set<%=e.getKey()%>">
											<div class="row">
												<div class="col-sm-2"><b>Subtask: <%=e.getKey() %></b></div>
												<div class="col-sm-2">Score:<%=e.getValue().getScore(p.tests.get(e.getKey()).scheme) %></div>
												<div class="col-sm-4"><%=TomcatHelper.styledVerdict(e.getValue().getVerdict())%></div> 
											</div>
										</a>
									</div>
									<div id="set<%=e.getKey()%>" class="vcard-collapse collapse<%=flag?" show":""%>" data-parent="#superfa">
										<div style="height:20px;clear:both;"></div>
										<div>
										<%
											int cnt=0;
																			for(TestResult tr:e.getValue().res){
																				cnt++;
										%>
											<div class="vcard vcard-<%=TomcatHelper.shortVerdict(tr.verdict).toLowerCase()%>" data-toggle="collapse" data-target="#tr<%=e.getKey()+"w"+cnt%>" role="button" aria-controls="#tr<%=e.getKey()+"w"+cnt%>" aria-expanded="false">
												<span class="vcard-test">#<%=cnt%></span>
											<%
												if(Math.abs(tr.score)>0){
											%>
												<span class="vcard-score vcard-hide"><%=TomcatHelper.shortScore(tr.score)%></span>
												<span class="vcard-verdict vcard-show"><%=TomcatHelper.shortVerdict(tr.verdict)%></span>
											<%
												} else {
											%>
												<span class="vcard-verdict"><%=TomcatHelper.shortVerdict(tr.verdict)%></span>
											<% } %>
												<span class="vcard-tm"><%=tr.time %>ms</span>
												<span class="vcard-tm"><%=tr.memory %>KB</span>
											</div>
											<div class="collapse vcard-detail" id="tr<%=e.getKey()+"w"+cnt%>" data-parent="#set<%=e.getKey() %>">
												<div class="card card-body">
													<h3><a data-toggle="collapse" href="#tr<%=e.getKey()+"w"+cnt%>">#<%=cnt %></a></h3>
													<h5>Input</h5>
													<pre><%=tr.input.replace("<", "&lt;").replace(">","&gt;") %></pre>
													<h5>Output</h5>
													<pre><%=tr.output.replace("<", "&lt;").replace(">","&gt;") %></pre>
													<h5>Answer</h5>
													<pre><%=tr.answer.replace("<", "&lt;").replace(">","&gt;") %></pre>
													<h5>Checker Information</h5>
													<pre><%=tr.info.replace("<", "&lt;").replace(">","&gt;") %></pre>
												</div>
											</div>
										<%
											}
										%>
										</div>
										<div style="height:20px;clear:both;"></div>
									</div>
								</div>
							<%
							flag=false;
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
	<script>	
	function getlast1(x,half,lastk){
		var group=Math.floor(x/lastk);
		var index=x%lastk;
		return lastk*group*2+index;
	}
	
	function getlast2(x,half,lastk){
		var group=Math.floor(x/lastk);
		var index=x%lastk;
		var tot=Math.ceil(half/lastk);
		if(group==tot-1&&half%lastk!=0){
			return lastk*group*2+half%lastk+index;
		} 
		else{
			return lastk*group*2+lastk+index;
		}
	}
	
	function getk(){
		var k=4;
		if(window.innerWidth>=1200){
			k=9;
		}
		else if(window.innerWidth>=992){
			k=7;
		}
		else if(window.innerWidth>=768){
			k=5;
		}
		return k;
	}
	
	var lk=1;
	function arrange(name){
		var k=getk();
		if(k==lk){
			return;
		}
		var a=$('#'+name+">div:nth-child(2)").children();
		var half=a.length;
		half=Math.floor(half/2);
		if(half==0)return;
		var s='';
		for(var i=0;;i++){
			if(i*k>=half)break;
			for(var j=i*k;j<i*k+k&&j<half;j++){
				s+=a[getlast1(j,half,lk)].outerHTML;
			}
			for(var j=i*k;j<i*k+k&&j<half;j++){
				s+=a[getlast2(j,half,lk)].outerHTML;
			}
		}
		$('#'+name+">div:nth-child(2)").html(s);
	}
	
	function arrangeAll(){
		for(var i=1;i<allset.length;i+=2){
			arrange(allset[i].id);
		}
		lk=getk();
	}
	
	
	if (window.addEventListener) {
		window.addEventListener("resize", resizeThrottler, false);
	} else if (x.attachEvent) {
		window.attachEvent("resize", resizeThrottler);
	}
	
	var time=0;
	var allset=$('#superfa').children(0).children();
	for(var i=1;i<allset.length;i+=2){
		time=Math.max(time,allset[i].children.length);
	}
	time=Math.min(time/10,500);
	if(time<=15)time=0;
	
	var resizeTimeout;
	function resizeThrottler() {
		if ( !resizeTimeout && getk()!=lk) {
			resizeTimeout = setTimeout(function() {
				resizeTimeout = null;
				arrangeAll();
		   }, time);
		}
	}
	
	arrangeAll();
	</script>
</body>
</html>