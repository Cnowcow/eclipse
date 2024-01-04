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
		overflow: hidden;
		background-color: #fafcfe;
		margin: 9px 0 0 9px;
	}
	
	a {
		text-decoration: none;
	}
	
	button {
		cursor: pointer;
		border-color: gray;
		background-color: rgba(0, 152, 255, 0.3);
	}
	
	#ab {
		background-color: #0098ff;
	}
	
	li {
		position: relative;
		display: inline-block;
		width: 30px;
		height: 30px;
	}
	
	img {
		box-shadow: 0px 0px 2px 0px black;
		width: 67px; /* 이미지의 너비를 조절하세요 */
		height: 67px;
		margin: 5px;
		display: inline-block;
		transition: transform 0.3s ease-in-out; /* 확대/축소 애니메이션 추가 */
		border: 1px solid white;
		cursor: pointer;
	}
	
	.scroll {
		overflow: auto; /* 컨텐츠가 넘칠 경우 스크롤 표시 */
		height: 380px;
		padding-top: 5px
	}
	.modal {
		position: fixed;
	    top: 66px;
	    left: 23px;
	    width: 304px;
	    height: 390px;
	    background: rgba(0, 0, 0, 0.7);
	    display: flex;
	    justify-content: center;
	    align-items: center;
    }

    .modal img {
        width: 80%;
        height: 90%;
    }
</style>
</head>
<body style="width: 320px; height: 500px">

	<script type="text/javascript">

document.addEventListener('DOMContentLoaded', function () {
    var markethome = document.getElementById('photo');

    <% for (int i = 0; i < name.size(); i++) { %>
        var data<%= i %> = {
            name: '<%= name.get(i) %>',
            addr: '<%= addr.get(i) %>',
            phone: '<%= phone.get(i) %>',
            // Add other fields as needed
        };

        var element<%= i %> = document.createElement('photo');
        element<%= i %>.innerHTML = generateContent(data<%= i %>);
        markethome.appendChild(element<%= i %>);
       
        var images<%= i %> = element<%= i %>.querySelectorAll('img');
        for (var j = 0; j < images<%= i %>.length; j++) {
            images<%= i %>[j].addEventListener('click', function (event) {
                showLargeImage(event.target.src);
            });
        }
    <% } %>
});

function generateContent(data) {
    var html =
    		'<div id ="' +data.name+ '" style="width:320px; height:600px">'
    		+'<div style="width: 320px; height: 435px;">'
    		+'<a href="./home1.jsp#'+ data.name+'">'
    		+'<i style="color:#0098ff; font-size:20px;" class="bi bi-chevron-left"></i></a>'
    		+'<span style="font-size: 25px; font-weight: bold;">'
    		+'&nbsp;&nbsp;사진</span> (<%= name.size() %>)<hr>'
			+'<div class="scroll">'
			+'<img src="https://cdn.pixabay.com/photo/2016/02/05/15/34/pasta-1181189_1280.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/05/07/08/56/pancakes-2291908_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/03/23/19/57/asparagus-2169305_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/12/10/14/47/pizza-3010062_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg">'
			+data.name
			+'</div>'
			+'</div>'
			+'<hr>'
	        + '<div>'
	        +'<a href="./home1.jsp#' + data.name + '"><button style="width: 70px; border-radius: 20px; text-align: center; padding-bottom: 2px;">홈</button></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
	        + '<a href="./menu1.jsp#' + data.name + '"><button style="width: 70px; border-radius: 20px; text-align: center; padding-bottom: 2px;">메뉴</button></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
	        + '<a href="./party1.jsp#' + data.name + '"><button style="width: 70px; border-radius: 20px; text-align: center; padding-bottom: 2px;">파티</button></a>'
	        + '</div>'
	        + '</div><br>';

    return html;
}

function showLargeImage(src) {
    // 모달 창 생성
    var modal = document.createElement('div');
    modal.className = 'modal';
    
    // 이미지 생성
    var image = document.createElement('img');
    image.src = src;
    
    // 이미지를 모달에 추가
    modal.appendChild(image);
    
    // 모달을 body에 추가
    document.body.appendChild(modal);
    
    // 모달 창 닫기 이벤트 처리
    modal.addEventListener('click', function () {
        modal.remove();
    });
}
	
</script>



	<div id="photo" style="width: 320px;"></div>


</body>
</html>