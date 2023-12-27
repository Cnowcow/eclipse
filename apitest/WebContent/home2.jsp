<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" as="style" crossorigin
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable-dynamic-subset.min.css" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">

<style type="text/css">
	body, html {
		background-color: #fafcfe;
		margin: 9px 0 0 9px;
		overflow: hidden;
	}
	
	a {
		text-decoration: none;
		color: rgba(0, 152, 255, 1);
	}
	
	button {
		cursor: pointer;
		border-color: gray;
		background-color: rgba(0, 152, 255, 0.3);
	}
	
	li {
		border-bottom: 0.2px dotted gray;
		margin: 0.5px 0px 1.1px 4px;
		box-shadow: 0px 0px 0.5px 0px rgba(128, 128, 128, 0.3);
		font-size: 15px;
		list-style: none;
		"
	}
	

	#interface {
		background: linear-gradient(to bottom, #66ff66, #0066ff);
		color: white;
		position: absolute;
		border-radius: 100px;
		text-align: center;
		font-size: 20px;
		font-weight: bolder;
		padding: 1px 4px 2px 3px;
		top: 50px;
		left: 210px;
	}
</style>
</head>
<body style="width: 320px; height: 500px">

	<script type="text/javascript">

document.addEventListener('DOMContentLoaded', function () {
    var markethome = document.getElementById('home');

    <%for (int i = 0; i < name.size(); i++) {%>
        var data<%=i%> = {
            name: '<%=name.get(i)%>',
            addr: '<%=addr.get(i)%>',
            phone: '<%=phone.get(i)%>',
            event: '<%=event.get(i)%>'
            // Add other fields as needed
        };

        var element<%=i%> = document.createElement('home');
        element<%=i%>.innerHTML = generateContent(data<%=i%>);
        markethome.appendChild(element<%=i%>);
    <%}%>
});

function generateContent(data) {
    var html =
        '<div id="' + data.name + '" style="width: 320px;">'	
        + '<div style="width: 320px; height: 435px;">'
        + '<span style="font-size: 23px; font-weight: bold;">' + data.name + '</span><br>'
        + '<div style="margin:6px 0px 6px 0px"><span style="color: red">★</span>4.7&nbsp;'
        + '<span style="font-size:14px; color: skyblue">&nbsp;&nbsp;&nbsp;'
        +'<a href="./review1.jsp#' + data.name + '" target="_self">후기 (<%=name.size()%>)</a></span></div>'
        + '&nbsp;<span style="font-size:14px;">주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소&nbsp; : ' + data.addr + '</span><br>'
        + '&nbsp;<span style="font-size:14px;">전화번호&nbsp; : ' + data.phone + '</span><br>'
        + '&nbsp;<span style="font-size:14px;">영업시간&nbsp; : 10:00 - 22:00 </span>'
        + '<hr>'
        + '<div style="display: flex; justify-content: space-between;">'
        + '<span style="font-size: 17px; font-weight: bold;">사진</span>'
        + '<span style="font-size:12px;"><a href="./photo1.jsp#' + data.name + '">(더보기)</a></span></div>'
        + generatePhotoGallery(data.name, 5) 
        + '<hr>'
        + '<div style="display: flex; justify-content: space-between; margin-bottom:3px">'
        + '<span style="font-size: 17px; font-weight: bold;">메뉴</span>'
        + '<span style="font-size:12px;"><a href="./menu1.jsp#' + data.name + '">(더보기)</a></span></div style=" margin-bottom:10px;">'
        +'<div style="display: flex; flex-wrap: wrap; font-size:14px;">'
		+'<span style="flex-basis: 50%;">&nbsp;짜장면</span><span style="flex-basis: 50%; text-align: right;">5000원</span>'
		+'<span style="flex-basis: 50%;">&nbsp;군만두</span><span style="flex-basis: 50%; text-align: right;">4000원</span>'
		+'<span style="flex-basis: 50%;">&nbsp;쨈뽕</span><span style="flex-basis: 50%; text-align: right;">6000원</span>'
		+'</div>'
        + '<hr>'
        + '<div style="display: flex; justify-content: space-between; margin-bottom:3px">'
        + '<span style="font-size: 17px; font-weight: bold;">파티목록 (<%=name.size()%>)</span>'
        + '<span style="font-size:12px;"><a href="./party1.jsp#' + data.name + '">(더보기)</a></span></div>'
        + '<div id="interface">'+data.event+'</div>'
        <%for (int i = 0; i < Math.min(3, name.size()); i++) {%>
	    html += '<li>' + '<%=name.get(i)%>' + '</li>'<%}%>
        + '</div><hr>'
        + '<div>'
        +'<a href="./home1.jsp#' + data.name + '"><button style="width: 70px; border-radius: 20px; text-align: center; padding-bottom: 2px;">홈</button></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
        + '<a href="./menu1.jsp#' + data.name + '"><button style="width: 70px; border-radius: 20px; text-align: center; padding-bottom: 2px;">메뉴</button></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
        + '<a href="./party1.jsp#' + data.name + '"><button style="width: 70px; border-radius: 20px; text-align: center; padding-bottom: 2px;">파티</button></a>'
        + '</div>'
        + '</div><br>';

    return html;
}

// partylist 배열을 받아서 출력하는 함수
function generatePartyList(partylist) {
    var partyHtml = '';
    for (var i = 0; i < Math.min(partylist.length, 4); i++) {
        partyHtml += '<li style="margin: 0px 0px 1.1px 4px; box-shadow: 0px 0px 0.5px 0px rgba(128, 128, 128, 0.3); font-size:15px; list-style:none;">' + partylist[i] + '</li>';
    }
    partyHtml += '';
    return partyHtml;
}

function generatePhotoGallery(name, count) {
    var galleryHtml = '<div>';
    for (var i = 0; i < count; i++) {
        galleryHtml += '<a href="#"><img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" style="box-shadow: 0px 0px 2px 0px black; width: 54px; height: 54px; margin: 4px 3px 0px 4px; border: 1px solid white;"></a>';
    }
    galleryHtml += '</div>';
    return galleryHtml;
}

</script>



	<div id="home" style="width: 320px; height: 600px"></div>



</body>
</html>