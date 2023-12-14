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
               paage.add(rs.getString("event"));
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
<script type="text/javascript"
    src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ni1wxk8wwv"></script>
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
        z-index: 10;
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
		z-index: 300;
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

        function initMap() {
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
                                <h3><%= name.get(i) %></h3>
                                <p><%= addr.get(i) %><br>
                                    <%= phone.get(i) %></p>
                            </div>
                        </a>`;

                    var infowindow<%= i %> = new naver.maps.InfoWindow({
                        content: contentString<%= i %>
                    });

                    naver.maps.Event.addListener(marker<%= i %>, "click", function (e) {
                        if (infowindow<%= i %>.getMap()) {
                            infowindow<%= i %>.close();
                        } else {
                            infowindow<%= i %>.open(map, marker<%= i %>);
                        }
                    });

                    markers.push(marker<%= i %>);
                <% } %>
            });
        }
	
        naver.maps.onJSContentLoaded = initMap;

        function centerToCurrentLocation() {
            navigator.geolocation.getCurrentPosition(function (position) {
                var mylat = position.coords.latitude;
                var mylng = position.coords.longitude;

                map.setCenter(new naver.maps.LatLng(mylat, mylng));
                map.setZoom(17);
            });
        }

        function showMarketInfo() {
            var marketInfo = document.getElementById('markethome');
            marketInfo.style.display = 'block';
        }
        
        
        function hideMarketInfo() {
            var marketInfo = document.getElementById('markethome');
            marketInfo.style.display = 'none';
        }

        document.body.addEventListener('click', function (e) {
            // Check if the click is outside of the marketinfo div
            var marketInfo = document.getElementById('markethome');
            if (e.target !== marketInfo && !marketInfo.contains(e.target)) {
                hideMarketInfo();
            }
        });
		
        
        //드래그했을 때
        var isDragging = false; // 드래그 중인지 여부를 나타내는 플래그
        var startPosition = { x: 0, y: 0 }; // 시작 위치

        // 터치 및 마우스 이벤트에 대한 공통된 이벤트 핸들러
        function startDrag(event) {
            // 터치 이벤트와 마우스 이벤트 구분
            var point = event.touches ? event.touches[0] : event;

            // 시작 위치 저장
            startPosition = {
                x: point.clientX,
                y: point.clientY
            };

            // 드래그 시작
            isDragging = true;

            // 이벤트 리스너 등록
            document.addEventListener('mousemove', drag);
            document.addEventListener('touchmove', drag);
        }

        // 드래그 중인 동안 호출되는 이벤트 핸들러
        function drag(event) {
            if (isDragging) {
                // 터치 이벤트와 마우스 이벤트 구분
                var point = event.touches ? event.touches[0] : event;

                // 현재 위치와 시작 위치의 차이 계산
                var deltaX = point.clientX - startPosition.x;
                var deltaY = point.clientY - startPosition.y;

                // 여기에서 드래그 중의 동작을 수행하면 됩니다.
                
                // 이동한 위치를 다시 시작 위치로 업데이트
                startPosition = {
                    x: point.clientX,
                    y: point.clientY
                };

                // 드래그 중에도 마켓 정보를 숨기도록 호출
                hideMarketInfo();
            }
        }

        // 드래그 종료 시 호출되는 이벤트 핸들러
        function endDrag() {
            // 드래그 종료
            isDragging = false;

            // 이벤트 리스너 제거
            document.removeEventListener('mousemove', drag);
            document.removeEventListener('touchmove', drag);
        }

        // 마우스 다운 및 터치 스타트 이벤트에 대한 이벤트 리스너 등록
        document.addEventListener('mousedown', startDrag);
        document.addEventListener('touchstart', startDrag);

        // 마우스 업 및 터치 엔드 이벤트에 대한 이벤트 리스너 등록
        document.addEventListener('mouseup', endDrag);
        document.addEventListener('touchend', endDrag);

        // 마켓 정보를 숨기는 함수
        function hideMarketInfo() {
            var marketInfo = document.getElementById('markethome');
            marketInfo.style.display = 'none';
        }
        //
        
        
    </script>

    <div id="map" style="width: 393px; height: 852px; margin: 100 0 0 100;">
		<div class="header">
	  		<div class="background1"></div>
			<a href="#"><div class="menu"><img src="./img/menu.png" style="width: 31px; height: 30px;"></div></a>
			<a href="#"><div class="title"><img src="./img/title.png" style="width: 82px; height: 29px;"></div></a>
			<a href="#"><div class="me"><img src="./img/me.png" style="width: 57px; height: 57px;"></div></a>
		</div>
        <div id="markethome"><p>here!!</p></div>
        <div id="filter">
		    <button id="toggleButton">필터</button>
			    <li class="hidden"><a href="#">주변식당</a></li>
			    <li class="hidden"><a href="#">파티보기</a></li>
			    <li class="hidden"><a href="#">이벤트별</a></li>
		</div>
        <img src="./img/my.png" id="centerButton" onclick="centerToCurrentLocation()">
	        <div class="footer">
				<div class="background2"></div>
				<a href="#"><div class="map"><img src="./img/map.png" style="width: 30px; height: 46px;"></div></a>
				<a href="#"><div class="location"><img src="./img/location.png" style="width: 37px; height: 51px;"></div></a>
				<a href="#"><div class="home"><img src="./img/home.png" style="width: 81px; height: 81px;"></div></a>
				<a href="#"><div class="party"><img src="./img/party.png" style="width: 29px; height: 50px;"></div></a>
				<a href="#"><div class="pay"><img src="./img/pay.png" style="width: 39px; height: 44px;"></div></a>
			</div>
    </div>
	
<script>
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
</html>