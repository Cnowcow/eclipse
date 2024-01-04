<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
      request.setCharacterEncoding("utf-8");
      
      String dbType = "com.mysql.jdbc.Driver";
      String url = "jdbc:mysql://localhost:3306/hungrydb";
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
       ArrayList<String> event = new ArrayList<>();
      
      try{
         con = DriverManager.getConnection(url, user, password);
           stmt = con.createStatement();
           rs = stmt.executeQuery("SELECT * FROM 파트너사");
         
           while (rs.next()) {
               name.add(rs.getString("파트너사상호"));
               addr.add(rs.getString("파트너사주소"));
               phone.add(rs.getString("파트너사전화번호"));
               lat.add(rs.getString("y"));
               lng.add(rs.getString("x"));
               event.add(rs.getString("파트너사상세주소"));
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
<html style="width: 393px; height: 852px;">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-3.6.1.min.js"
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ni1wxk8wwv"></script>
<script type="text/javascript" src="./js/MarkerClustering.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
	integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
	integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
<link rel="stylesheet" as="style" crossorigin
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable-dynamic-subset.min.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">

<style type="text/css">
	a {
		text-decoration: none;
	}
	
	#centerButton {
	    position: absolute;
	    bottom: 58px;
	    left: 14.5px;
	    width: 38px;
	    height: 38px;
	    z-index: 10;
	    cursor: pointer;
	    box-shadow: 0px 0px 6px 0px gray;
	    border-radius: 50px;
	}
	
	#markethome {
		display: none;
		background-color: #66b2fe;
		border: 1px solid rgba(0, 152, 255, 0.3);
		border-radius: 25px;
		position: absolute;
		width: 360px;
		height: 560px;
		z-index: 200;
		top: 192px;
		left: 16px;
		border: 1px solid rgba(0, 152, 255, 0.3);
	}
	
	iframe {
		border-radius: 25px;
		width: 350px;
		height: 526px;
		position: absolute;
		top: 27px;
		left: 4px;
	}
	#currentLocationButton {
	    position: absolute;
	    z-index: 300;
	    background-color: white;
	    color: #0098ff;
	    padding: 8px 12px 8px 10px;
	    border-radius: 30px;
	    font-size: 13px;
	    left: 134.685px;
	    top: 118px;
	    cursor: pointer;
	    box-shadow: 0px 0px 6px 0px gray;
	}
</style>
<script type="text/javascript">
	var map;
	var markers = [];

	function init_map() {
		navigator.geolocation.getCurrentPosition(function (position) {
			var mylat = position.coords.latitude;
			var mylng = position.coords.longitude;

			map = new naver.maps.Map('map', {
				center: new naver.maps.LatLng(mylat, mylng),
				zoom: 17,
				zoomControl: true,
		        zoomControlOptions: {
		            position: naver.maps.Position.RIGHT_BOTTOM,
		            style: naver.maps.ZoomControlStyle.SMALL
		        },
		        scaleControl: false,
	            logoControl: false,
	            mapDataControl: false,
	            mapTypeControl: false
			});

			<% for (int i = 0; i < name.size(); i++) { %>
				var marker<%= i %> = new naver.maps.Marker({
					position: new naver.maps.LatLng(<%= lat.get(i) %>, <%= lng.get(i) %>),
					map: map
				});

				var contentString<%= i %> = `
					<a href="./home1.jsp#<%= name.get(i) %>" target='here'>
						<div id="infoWindowContent<%= i %>" style="border:1px solid #0098ff; border-radius:20px; padding:10px; background-color:#0098ff" 
							onclick="showMarketInfo()">
								<span style="color:white"><strong><%=name.get(i)%></strong></span>
						</div>
					</a>`;

				var infowindow<%=i%> = new naver.maps.InfoWindow({
					content: contentString<%=i%>,
					disableAnchor: true,
					borderWidth: 0,
					backgroundColor: 'transparent',
					autoPanPadding:{x: 30, y:20},
					
				});

				naver.maps.Event.addListener(marker<%=i%>, "click", function (e) {
					if (infowindow<%=i%>.getMap()) {
						infowindow<%=i%>.close();
					} else {
						infowindow<%=i%>.open(map, marker<%=i%>);
					}
				});
				
				naver.maps.Event.addListener(map, 'click', function() {
				    // InfoWindow가 열려있는 상태에서 지도를 클릭하면 InfoWindow를 닫습니다.
				    infowindow<%=i%>.close();
				});
				
				markers.push(marker<%=i%>);
				showAllMarkers();
			<%}%>
		});
	}

	naver.maps.onJSContentLoaded = init_map;

	 function showAllMarkers() {
	        for (var i = 0; i < markers.length; i++) {
	            markers[i].setMap(map);
	        }
	    }

	    function showCurrentLocationMarkers() {
	        var bounds = map.getBounds();

	        for (var i = 0; i < markers.length; i++) {
	            var markerPosition = markers[i].getPosition();

	            // 마커가 현재 지도 보기 경계 내에 있는지 확인합니다.
	            if (bounds.hasLatLng(markerPosition)) {
	                markers[i].setMap(map);
	            } else {
	                markers[i].setMap(null); // 경계 바깥에 있는 마커를 숨깁니다.	
	            }
	        }
	    }
	
	
	
	//centerButton 클릭이벤트
	function center() {
		navigator.geolocation.getCurrentPosition(function (position) {
			var mylat = position.coords.latitude;
			var mylng = position.coords.longitude;

			map.setCenter(new naver.maps.LatLng(mylat, mylng));
			map.setZoom(17);
		});
	}

</script>
</head>
<body style="width: 393px; height: 852px;">
	<script>
    
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
    
    //x 누르면 사라지기
    function hideIframe() {
		var Iframe = document.getElementById('markethome');
        Iframe.style.display = 'none';
      }    
</script>

	<div id="back">
		<jsp:include page="/hf/header2.jsp" />



		<div id="map" style="width: 393px; height: 672px; top: 100px;">

			<img src="./img/my.png" id="centerButton" onclick="center()">

		</div>

		<div id="markethome" align="center">
			<i class="bi bi-x-lg"
				style="font-size: 20px; color:#494949; cursor: pointer;"
				onclick="hideIframe()"></i>
			<iframe name="here"></iframe>
		</div>
		
		<div><a id="currentLocationButton" onclick="showCurrentLocationMarkers()"><strong><i style="color: #0098ff; font-size: 13px;" class="bi bi-arrow-clockwise"></i> 현 지도에서 검색</strong></a></div>

		<jsp:include page="/hf/footer2.jsp" />

	</div>
</body>
</html>