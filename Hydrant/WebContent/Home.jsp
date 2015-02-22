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
			<li class="active"><a href="Home.jsp">Map<span class="sr-only">(current)</span></a></li>
			<li><a href="add.jsp">Add</a></li>
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

<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDVhc4dOxXlnpAcxPpw3SDlY6gDNUpwOqc">
    </script>

<script type="text/javascript">

      ////////////get location

     /* var x = document.getElementById("demo");
      function getLocation() {
          if (navigator.geolocation) {
              navigator.geolocation.getCurrentPosition(showPosition);
          } else {
              x.innerHTML = "Geolocation is not supported by this browser.";
          }
      }
      function showPosition(position) {
          x.innerHTML = "Latitude: " + position.coords.latitude + 
          "<br>Longitude: " + position.coords.longitude; 
      }*/
      
      mLatitude = 0;
      mLongitude = 0;
      mMap = null;

      window.onload = function() {
        var startPos;
        navigator.geolocation.getCurrentPosition(function(position){
          startPos = position;

          mLatitude = startPos.coords.latitude;
          mLongitude = startPos.coords.longitude;

          initialize();
        });
      };
      ///////////////Google Maps

      function addCoordinate(map, lat, lon)
      {

        var myLatlng = new google.maps.LatLng(lat, lon);
		var image = 'hydrant.png'
        var marker = new google.maps.Marker({
          position: myLatlng,
          map: map,
          title: 'Hydrant!',
          icon: image
        });
      }

      function initialize() {
        var mapOptions = {
          center: { lat: mLatitude, lng: mLongitude},
          zoom: 18
        };
        var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  
        //addCoordinate(map, 40.525062, -74.460763);
        //addCoordinate(map, 40.526, -74.460763);
        //addCoordinate(map, 40.535, -74.460763);

      //  getLocation();

        <%
        List<Double> lati = new ArrayList<Double>();
  		List<Double> longi = new ArrayList<Double>();
    	try {
    		Class.forName("com.mysql.jdbc.Driver").newInstance(); 
    		java.sql.Connection con;
    		Statement stmt;
    		ResultSet rs;
    		
    		Context ctx = new InitialContext();
    		String connUrl = ("jdbc:mysql://localhost:3306/test"); 
    		
    		con = DriverManager.getConnection(connUrl, "root", "");
    		stmt = con.createStatement();
    		
    		rs = stmt.executeQuery("SELECT Latitude, Longitude FROM Location WHERE Approve<>0");
    		
    		int count = 0;

    		while (rs.next()) {
    			
    			count++;
    			String latitude = rs.getString(1);
    			double latDouble = Double.parseDouble(latitude);
    			lati.add(latDouble);
    			
    			String longitude = rs.getString(2);
    			double longDouble = Double.parseDouble(longitude);
    			longi.add(longDouble); 			
    		} 

    		rs.close();
    		stmt.close();
    		con.close();  		
    	} catch (Exception e) {
    		
    		out.println(e.getMessage());
    	}%>
    var latit = [];
    <%for(int i=0;i<lati.size();i++){%>
        latit.push("<%=lati.get(i)%>");
    <%}%>
    
    var longit = [];
    <%for(int i=0;i<longi.size();i++){%>
        longit.push("<%=longi.get(i)%>");
<%}%>
	for (i = 0; i < latit.length; i++) {
			addCoordinate(map, latit[i], longit[i]);

			//	alert("Element " + i + ": \nLatitude: " + latit[i] + "\nLongitude: " + longit[i]);
		}
		getLocation();
	}
     
	google.maps.event.addDomListener(window, 'load', initialize);

	function SubmitCoordinates() {

		var submission = confirm("Are you sure would like to submit these coordinates?"
				+ "\nLatitude: " + mLatitude + "\nLongitude: " + mLongitude);
		//alert(submission);
		if (submission == true) {
			//  alert("passed true");
			document.location.href = "Home.jsp?longitude=" + mLongitude
					+ "&latitude=" + mLatitude;
<%try {
	
	String latitude = request.getParameter("latitude");
	
	String longitude = request.getParameter("longitude");%>

alert("Your submission was recieved and is pending approval");
<%Class.forName("com.mysql.jdbc.Driver").newInstance(); 
	java.sql.Connection con;
	Statement stmt;
//	ResultSet rs;

	Context ctx = new InitialContext();
	String connUrl = ("jdbc:mysql://localhost:3306/test"); 

	con = DriverManager.getConnection(connUrl, "root", "");
	stmt = con.createStatement();
	
	try{
	stmt.executeUpdate("INSERT INTO test.Location (LocationID, Latitude, Longitude, Approve) VALUES (NULL," +latitude+","+longitude+" , '0')");
	} catch (Exception e) {
		out.println("duplicate");
	}

//	rs.close();
	stmt.close();
	con.close();%>
	document.location.href = "Home.jsp";
	<%} catch (Exception e) {
		out.println(e.getMessage());
	}%>
	
//	alert("Your submission was recieved and is pending approval");

		} else {
			alert("you canceled");
		}

		/*  alert("Latitude: " + mLatitude + "\nLongitude: " + mLongitude); */
	}
</script>
<script src="js/bootstrap.min.js"></script>
</head>
<body>
	<!--<button> <img id = "plus" src = "plus.png" height = 100 style = 'position:fixed;bottom:60px;right:0px;z-index:999;' type = "image" onclick="SubmitCoordinates()" /></button> -->
	<input type="image" src="plus.png" alt="submit"
		onclick="SubmitCoordinates()"
		style='position: fixed; bottom: 60px; right: 0px; z-index: 999;'>
	<div id="map-canvas"></div>
	<!--  <<div id="startLat">Loading Latitude...</div>
    <div id="startLon">Loading Longitude...</div> -->
</body>
</html>