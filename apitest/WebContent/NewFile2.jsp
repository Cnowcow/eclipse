<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
	<%
		request.setCharacterEncoding("utf-8");
		
		String dbType = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/school";
		String user = "root";
		String password = "mysql";
		
		Connection con = null;
	    Statement stmt = null;
	    ResultSet rs = null;
	
	    ArrayList<String> name = new ArrayList<>();
	    ArrayList<String> addr = new ArrayList<>();
	    ArrayList<String> phone = new ArrayList<>();
	    ArrayList<String> lat = new ArrayList<>();
	    ArrayList<String> lng = new ArrayList<>();
	    ArrayList<String> paage = new ArrayList<>();
		
		try{
			con = DriverManager.getConnection(url, user, password);
	        stmt = con.createStatement();
	        rs = stmt.executeQuery("SELECT * FROM markettest");
			
	        while (rs.next()) {
	            name.add(rs.getString("mname"));
	            addr.add(rs.getString("address"));
	            phone.add(rs.getString("phone"));
	            lat.add(rs.getString("Lat"));
	            lng.add(rs.getString("Lng"));
	            paage.add(rs.getString("page"));
	        }
		
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				if (rs != null) rs.close();
	            if (stmt != null) stmt.close();
	            if (con != null) con.close();
			}catch (SQLException e){
	            e.printStackTrace();
		}
	}
		
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ni1wxk8wwv"></script>
<script type="text/javascript">
var mapDiv = document.getElementById('map'); // 'map'으로 선언해도 동일

</script>
<style type="text/css">
	a{
		text-decoration: none;
	}
</style>
</head>
<body>
    <div id="map" style="width:400px;height:650px; margin: 100 0 0 100;">
    	<iframe name="inner">
    
    	</iframe>
    </div>
	
    <script>
        var mapOptions = {
            center: new naver.maps.LatLng(37.4859368, 126.8971966),
            zoom: 17
        };

        var map = new naver.maps.Map('map', mapOptions);

        var markers = [];

        <% for (int i = 0; i < name.size(); i++) { %>
            var marker<%= i %> = new naver.maps.Marker({
                position: new naver.maps.LatLng(<%= lat.get(i)%>, <%=lng.get(i) %>),
                map: map
            });

            var contentString<%= i %> = `
                <a href="<%= paage.get(i) %>" target="inner">
	                <div class="info">
    	                <h3><%= name.get(i) %></h3>
        	            <p><%= addr.get(i) %><br>
            	           <%= phone.get(i) %></p>
                	</div>
				</a>`;

            var infowindow<%= i %> = new naver.maps.InfoWindow({
                content: contentString<%= i %>
            });
            
<%--             var infowindow<%= i %> = new naver.maps.InfoWindow({
                content: contentString<%= i %>,
                maxWidth: 140,
                backgroundColor: "#eee",
                borderColor: "#2db400",
                borderWidth: 5,
                anchorSize: new naver.maps.Size(30, 30),
                anchorSkew: true,
                anchorColor: "#eee",
                pixelOffset: new naver.maps.Point(20, -20)
            }); --%>
            
            naver.maps.Event.addListener(marker<%= i %>, "click", function (e) {
                if (infowindow<%= i %>.getMap()) {
                    infowindow<%= i %>.close();
                } else {
                    infowindow<%= i %>.open(map, marker<%= i %>);
                }
            });
            infowindow<%= i %>.open(map, marker<%= i %>);
            markers.push(marker<%= i %>);
        <% } %>
		
    </script>
    
</html>