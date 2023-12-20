<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
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
       ArrayList<String> evnet = new ArrayList<>();
      
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
<script type="text/javascript" src="./js/MarkerClustering.js"></script>


<style type="text/css">
    a {
        text-decoration: none;
    }

    #centerButton {
        position: absolute;
        bottom: 120px;
        left: 20px;
        width: 44px;
        height: 44px;
        z-index: 1;
        cursor: pointer;
    }

    #markethome {
        display: none;
        padding: 20px;
        background-color: white;
        border: 1px solid black;	
        border-radius: 10px; 
        position: absolute;
        bottom: 10%;
        left: 4%;
        width: 330px;
        height: 450px;
        z-index: 15;
    }
	
	
	.hidden {
      display: none;
    }
	#filter{
		position:absolute;
		z-index: 10;
		top: 130px;
		right: 30px;
		border-radius: 
	}
	li {
		list-style: none;
		background-color: white;
	} 
	li:hover{
		background-color: blue;
		color: white;
	}
</style>
<link href="./css/headerfooter.css" rel="stylesheet"> 
</head>
<body>
<script type="text/javascript">
	var map;
	var markers = [];

	function init_map() {
		navigator.geolocation.getCurrentPosition(function (position) {
			var mylat = position.coords.latitude;
			var mylng = position.coords.longitude;

		map = new naver.maps.Map('map', {
		center: new naver.maps.LatLng(mylat, mylng),
		zoom: 17
	});

	// 마커와 인포윈도우 추가
	<% for (int i = 0; i < name.size(); i++) { %>
		var marker<%= i %> = new naver.maps.Marker({
		position: new naver.maps.LatLng(<%= lat.get(i) %>, <%= lng.get(i) %>),
		map: map
	});

	var contentString<%= i %> = `
		<a href="#">
			<div class="info" onclick="showMarketInfo('<%= name.get(i) %>', '<%= addr.get(i) %>', '<%= phone.get(i) %>')">
				<h3><%=name.get(i)%></h3>
				<p><%=addr.get(i)%><br>
				<%=phone.get(i)%></p>
			</div>
		</a>`;

	var infowindow<%=i%> = new naver.maps.InfoWindow({
		content: contentString<%=i%>
	});

	naver.maps.Event.addListener(marker<%=i%>, "click", function (e) {
		if (infowindow<%=i%>.getMap()) {
		infowindow<%=i%>.close();
	} else {
		infowindow<%=i%>.open(map, marker<%=i%>);
	}
	});
	
	markers.push(marker<%=i%>);
	<%}%>
		});
	}
	
	naver.maps.onJSContentLoaded = init_map;

	
	//위치기반 지도 띄우기
	
	function centerToCurrentLocation() {
		navigator.geolocation.getCurrentPosition(function (position) {
			var mylat = position.coords.latitude;
			var mylng = position.coords.longitude;

			map.setCenter(new naver.maps.LatLng(mylat, mylng));
			map.setZoom(17);
		});
	}

	//infowindow 띄우기
	function showMarketInfo() {
		var marketInfo = document.getElementById('markethome');
		marketInfo.style.display = 'block';
	}
        
    //infowindow 숨기기    
	function hideMarketInfo() {
		var marketInfo = document.getElementById('markethome');
		marketInfo.style.display = 'none';
	}

    //infowindow 영역 밖 click 이벤트
	document.body.addEventListener('click', function (e) {
            // Check if the click is outside of the marketinfo div
		var marketInfo = document.getElementById('markethome');
		if (e.target !== marketInfo && !marketInfo.contains(e.target)) {
			hideMarketInfo();
		}
	});
		
        
        //필터링 토글
    document.addEventListener('DOMContentLoaded', function () {
        var button = document.getElementById('toggleButton');
        var items = document.querySelectorAll('#filter li');

        button.addEventListener('click', function () {
            // 모든 li에 대해 hidden 클래스를 토글
            items.forEach(function (item) {
                item.classList.toggle('hidden');
            });
        });
    });

</script>

<%-- <script type="text/javascript">

    var server_data = {
    name : '<%= name.get(0) %>',
    addr : '<%= addr.get(0) %>',
    phone : '<%= phone.get(0) %>' 		
    };
    
	document.addEventListener('DOMContentLoaded', function () {
	    var markethome = document.getElementById('markethome');
	    markethome.innerHTML = generateContent(server_data);
	});        
	
	// HTML에 띄울 콘텐츠를 생성하는 함수
	function generateContent(data) {
    // 여기에서 원하는 콘텐츠 생성 로직을 추가
    var html = '<h2>' + data.name + data.addr + data.phone + '</h2>';
    return html;
}

    // generateContent 함수를 호출하여 콘텐츠 생성 후 contentBox에 추가
    
</script> --%>

	<div id="map" style="width: 393px; height: 852px; margin: 100 0 0 100;">
		<div class="header">
			<div class="background1"></div>
			<a href="#"><div class="menu">
					<img src="./img/menu.png" style="width: 31px; height: 30px;">
				</div></a> <a href="#"><div class="title">
					<img src="./img/title.png" style="width: 82px; height: 29px;">
				</div></a> <a href="#"><div class="me">
					<img src="./img/me.png" style="width: 57px; height: 57px;">
				</div></a>
		</div>
		
		<div id="markethome" style="width: 330px; height: 600px">
	<span style="font-size: 22px; font-weight: bold;">무한자금성 </span><span style="color: red">
	★</span>4.7&nbsp;<span style="color: skyblue"><a href="#">후기(421건)</a></span>
	<br><br>
	<span>주 &nbsp;&nbsp;&nbsp;&nbsp; 소<span>&nbsp; : 서울 구로구<br>
	<span>전화번호<span>&nbsp; : 서울 구로구<br>
	<span>영업시간<span>&nbsp; : 서울 구로구
	<hr>
	<span style="font-size: 20px; font-weight: bold;">사진</span><a href="#">(더보기)</a><br>
	사진들어갈곳<br><br><br><br><br>
	<hr>
	<span style="font-size: 20px; font-weight: bold;">메뉴</span><a href="#">(더보기)</a><br>
	메뉴들어갈곳<br><br><br><br><br>
	<hr>
	<span style="font-size: 20px; font-weight: bold;">파티목록(5)</span><a href="#">(더보기)</a><br>
	파티들어갈곳<br><br>
</div>		
		<div id="filter">
			<button id="toggleButton">필터</button>
			<li class="hidden"><a href="#">주변식당</a></li>
			<li class="hidden"><a href="#">파티보기</a></li>
			<li class="hidden"><a href="#">이벤트별</a></li>
		</div>
		<img src="./img/my.png" id="centerButton"
			onclick="centerToCurrentLocation()">
		<div class="footer">
			<div class="background2"></div>
			<a href="#"><div class="map">
					<img src="./img/map.png" style="width: 30px; height: 46px;">
				</div></a> <a href="#"><div class="location">
					<img src="./img/location.png" style="width: 37px; height: 51px;">
				</div></a> <a href="#"><div class="home">
					<img src="./img/home.png" style="width: 81px; height: 81px;">
				</div></a> <a href="#"><div class="party">
					<img src="./img/party.png" style="width: 29px; height: 50px;">
				</div></a> <a href="#"><div class="pay">
					<img src="./img/pay.png" style="width: 39px; height: 44px;">
				</div></a>
		</div>
	</div>
</body>
</html>