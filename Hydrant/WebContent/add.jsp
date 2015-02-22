<%@ page language="java" import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.swing.JOptionPane"%>


<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">

<!-- -->
<nav class="navbar navbar-default">
<div class="container-fluid">
	<!-- Brand and toggle get grouped for better mobile display -->
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
			<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
			<span class="icon-bar"></span> <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="#">Hydrant</a>
	</div>

	<!-- Collect the nav links, forms, and other content for toggling -->
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li><a href="Home.jsp">Map</a></li>
			<li class="active"><a href="add.jsp">Add<span class="sr-only">(current)</span></a></li>
			<li><a href="#">About </a></li>
			<li><a href="#">Contacts</a></li>
			
			<form class="navbar-form navbar-left" role="search">
				<div class="form-group">
					<input type="text" class="form-control" placeholder="Search">
				</div>
				<button type="submit" class="btn btn-default">Submit</button>
			</form>
			<ul class="nav navbar-nav navbar-right">
			</ul>
	</div>
	<!-- /.navbar-collapse -->
</div>
<!-- /.container-fluid --> </nav>


<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HYDRANT</title>

<link href="css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
/*html, body, #map-canvas { height: 600px; width: 1000px;}*/
html, body, #map-canvas {
	height: 95%;
	width: 100%;
}
</style>
</head>
<body>

<body>
<%
  Enumeration names = request.getParameterNames();
  while (names.hasMoreElements()) {
      String name = (String) names.nextElement();
      StringBuffer sb = new StringBuffer(name);
      sb.deleteCharAt(0);
      hydrant.ListHydrant.add(sb.toString());
  }

%>
<br>

<!-- <div class="navigator"> -->
<!-- <a href="index.jsp">Add</a> -->
<!-- <a id="currenttab" href="add.jsp">Add</a> -->
<!-- </div> -->

<br> <br> <br>

<form action="add.jsp" method="post">
<table>
<tr>
<th>Latitude</th>
<th>Longitude</th>
</tr> 
<%

  List list = hydrant.ListHydrant.GetHydrants();
  double id1 =0;
  int id = 0;
  String box = null;

  Iterator<String> it = list.iterator();

  while (it.hasNext()) {
      id1 = Double.parseDouble(it.next());
      id = (int) id1;
      out.print("<tr>");
      for (int i = 0; i < 2; i++) {
          out.print("<td>");
          out.print(it.next());
          out.print("</td>");
  }
  out.print("<td>");
  box = "<input name=r" + id + " type='checkbox'>";
  out.print(box);
  out.print("</td>");
  out.print("</tr>");
 }
%>
 
</table>
 
<br>
<input type="submit" value="ADD">

</form>

</body>
</html>