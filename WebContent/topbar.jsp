<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand-md bg-dark navbar-dark fixed-top">
	<a class="navbar-brand" href="index.jsp"> 
		<img src="assets/hhsoj128x.png" alt="Logo" style="width: 40px;">
	</a>

	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#collapsibleNavbar">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="collapsibleNavbar">
		<ul class="navbar-nav ml-auto">
			<li class="nav-item topbar-item"><a class="nav-link" href="pset.jsp">Problemsets</a></li>
			<li class="nav-item topbar-item"><a class="nav-link" href="status.jsp">Status</a></li>
			<li class="nav-item topbar-item"><a class="nav-link" href="submit.jsp">Submit</a></li>
		</ul>

		<ul class="navbar-nav mr-auto">
			<%if (session.getAttribute("username") == null) {%>
			<li class="nav-item topbar-item"><a class="nav-link" href="login.jsp">Login</a></li>
			<%} else {%>
			<%-- TODO: "index.jsp" below should be replaced with user page URL --%>
			<li class="nav-item topbar-item"><a class="nav-link" href="index.jsp"><%=session.getAttribute("username") %></a></li>
			<li class="nav-item topbar-item"><a class="nav-link" href="logoutS">Logout</a></li>
			<%}%>
		</ul>
	</div>
</nav>

<div style="height:50px;"></div>