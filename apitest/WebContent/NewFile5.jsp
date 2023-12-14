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
<script type="text/javascript"
    src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ni1wxk8wwv"></script>
<script type="text/javascript" src="./js/MarkerClustering.js"></script>
<style type="text/css">
    a {
        text-decoration: none;
    }

    #centerButton {
        position: absolute;
        bottom: 100px;
        left: 10px;
        z-index: 1000;
        background-image: url("./img/my.png");
        width: 44px;
        height: 44px;
    }

    #top {
        position: absolute;
        z-index: 1000;
        top: -25px;
    }

    #bottom {
        position: absolute;
        z-index: 1000;
        bottom: -8px;
    }

    #marketinfo {
        display: none;
        padding: 20px;
        background-color: #f0f0f0;
        position: absolute;
        bottom: 20px;
        left: 10px;
        width: 330px;
        height: 450px;
        z-index: 10000;
    }

    .info {
        cursor: pointer;
    }
</style>
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
                    zoom: 17,
                    mapDataControl: false,
                    mapTypeControl: false,
                    zoomControlOptions: {
                        position: naver.maps.Position.TOP_LEFT,
                        style: naver.maps.ZoomControlStyle.SMALL
                    }
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

        function showMarketInfo(name, addr, phone) {
            var marketInfo = document.getElementById('marketinfo');
            marketInfo.innerHTML = `
                <h3>${name}</h3>
                <p>${addr}<br>${phone}</p>
            `;
            marketInfo.style.display = 'block';
        }
    </script>

    <div id="map" style="width: 400px; height: 650px; margin: 100 0 0 100;">
        <div id="top"><img src="./img/top.png" width="400px"></div>
        <div id="marketinfover8"></div>
        <button id="centerButton" onclick="centerToCurrentLocation()"></button>
        <div id="bottom"><img src="./img/bottom.png" width="400px"></div>
    </div>
</html>