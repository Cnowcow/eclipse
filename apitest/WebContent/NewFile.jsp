<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ni1wxk8wwv"></script>
<script type="text/javascript">
var mapDiv = document.getElementById('map'); // 'map'으로 선언해도 동일

</script>
</head>
<body>

	<div id="map" style="width:400px;height:650px; margin: 100 0 0 100;"></div>
	
		<script>
			var mapOptions = {
	 		   center: new naver.maps.LatLng(37.4859368, 126.8971966),
	   		 zoom: 17
			};
	
			var map = new naver.maps.Map('map', mapOptions);
			
			var HOME_PATH = window.HOME_PATH || '.';

			
			var cityhall = new naver.maps.LatLng(37.4859368, 126.8971966),
			    map = new naver.maps.Map('map', {
			        center: cityhall.destinationPoint(0, 500),
			        zoom: 15
			    }),
			    marker = new naver.maps.Marker({
			        map: map,
			        position: cityhall
			    });

			var contentString = [
			        '<div class="iw_inner">',
			        '   <h3>서울특별시청</h3>',
			        '   <p>서울특별시 중구 태평로1가 31 <br />',
			        '       02-120 | 공공,사회기관 &gt; 특별,광역시청<br />',
			        '       <a href="http://www.seoul.go.kr" target="_blank">www.seoul.go.kr/</a>',
			        '   </p>',
			        '</div>'
			    ].join('');

			var infowindow = new naver.maps.InfoWindow({
			    content: contentString
			});

			naver.maps.Event.addListener(marker, "click", function(e) {
			    if (infowindow.getMap()) {
			        infowindow.close();
			    } else {
			        infowindow.open(map, marker);
			    }
			});

			infowindow.open(map, marker);
			
		</script>
		

</body>
</html>


