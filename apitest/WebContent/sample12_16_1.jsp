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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
<link href="./css/headerfooter2.css" rel="stylesheet"> 
<link href="./css/menu.css" rel="stylesheet"> 
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable-dynamic-subset.min.css" /> 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>

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
        bottom: 100px;
        left: 7%;
        width: 350px;
        height: 620px;
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
	
	.module{
            width : 393px;
            height: 852px;
            top: 18px;
            left: -100%;
            position: absolute;
            z-index: 300;
        }
	.body{
		top: 30px;
		left: 200px;
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

		

        
	//메뉴창
	function showMenu() {
	    var menuForNav = document.querySelector('.menu_for_nav');
	    menuForNav.style.transition = 'left 700ms';
	    menuForNav.style.left = '0%';
	}
	
	function hideMenu() {
		var menuForNav = document.querySelector('.menu_for_nav');
	    menuForNav.style.transition = 'left 700ms';
	    menuForNav.style.left = '-100%';
	}

	


</script>
<script>
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
</head>
<body>
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
    
	</script>


	<div id="map" style="width: 393px; height: 852px;">
		
		<div class="header">
			<div class="background1"></div>

			<div class="menu" onclick="showMenu()"><a href="#">
				<i class="bi bi-list"></i>
			</a></div>
			<div class="title"><a href="#">
				<span class="bi bi-title">배고팟</span>
			</a></div>
			<div class="me"><a href="#">
				<i class="bi bi-person-square"></i>
			</a></div>
		</div>
		
		<div id="markethome">
		
			
		</div>		
		<div id="filter">
			<button id="toggleButton">필터</button>
			<li class="hidden"><a href="#">주변식당</a></li>
			<li class="hidden"><a href="#">파티보기</a></li>
			<li class="hidden"><a href="#">이벤트별</a></li>
		</div>
		
		<img src="./img/my.png" id="centerButton" onclick="centerToCurrentLocation()">
				
		<div class="footer">
			<div class="background2"></div>
	 						
			<div class="map"><a href="#">
				<i class="bi bi-map"></i>
			</a></div>
			<div class="location"><a href="#">
				<i class="bi bi-geo-alt-fill"></i>
			</a></div>
			<div class="home"><a href="#">
				<i class="bi bi-house"></i>
			</a></div>
			<div class="party"><a href="#">
				<i class="bi bi-people-fill"></i>
			</a></div>
			<div class="pay"><a href="#">
				<i class="bi bi-qr-code"></i>
			</a></div>
		</div>
 		
	</div>
	


	
	<div class="module">
	        <!-- 전체메뉴 모달창 -->
	
	        <div class="menu_for_nav">
	            <header>
	                <div class="row">
	                    <div class="col-3 header_first">
	                    	<i class="bi bi-list" onclick="hideMenu()"></i>
	                    </div>
	                    <div class="col-6 header_second">
	                        <font>전체메뉴</font>
	                    </div>
	                    <div class="col-3 header_third">
	                    </div>
	                </div>
	            </header>
	            <main>
	                <section>
	                    <div class="front_menu_box"></div>
	                    <div class="nav_menu_name">가게등록</div>
	                    <div class="nav_menu_line"></div>
	                    <div class="container">
	                        <div class="row">
	                            <div class="nav_menu_detail">가게등록  ></div>
	                            <div></div>
	                        </div>
	                    </div>
	                </section>
	                <section>
	                    <div class="front_menu_box"></div>
	                    <div class="nav_menu_name">가게관리</div>
	                    <div class="nav_menu_line"></div>
	                    <div class="container">
	                        <div class="row">
	                            <div class="nav_menu_detail">가게정보관리  ></div>
	                            <div class="nav_menu_detail">메뉴관리  ></div>
	                        </div>
	                        <div class="row">
	                            <div class="nav_menu_detail">이벤트 관리  ></div>
	                            <div class="nav_menu_detail">리뷰관리  ></div>
	                        </div>
	                    </div>
	                </section>
	                <section>
	                    <div class="front_menu_box"></div>
	                    <div class="nav_menu_name">결제정보</div>
	                    <div class="nav_menu_line"></div>
	                    <div class="container">
	                        <div class="row">
	                            <div class="nav_menu_detail">팟 충전하기  ></div>
	                            <div class="nav_menu_detail">현재 팟 확인  ></div>
	                        </div>
	                        <div class="row">
	                            <div class="nav_menu_detail">결제수단 등록  ></div>
	                            <div class="nav_menu_detail">팟 사용 내역  ></div>
	                        </div>
	                        <div class="row">
	                            <div class="nav_menu_detail">결제 취소하기  ></div>
	                        </div>
	                    </div>
	                </section>
	                <section>
	                    <div class="front_menu_box"></div>
	                    <div class="nav_menu_name">문의</div>
	                    <div class="nav_menu_line"></div>
	                    <div class="container">
	                        <div class="row">
	                            <div class="nav_menu_detail col-6">자주 묻는 문의  ></div>
	                            <div class="nav_menu_detail col-6">1:1 문의하기  ></div>
	                        </div>
	                    </div>
	                </section>
	            </main>
	        </div>
	
	
	</div>


	
</body>
</html>