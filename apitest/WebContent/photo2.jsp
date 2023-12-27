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
<style type="text/css">
body, html {
  overflow: hidden;
}
button {
	background-color: #0098ff;
	border-color: gray;
}
#ab{
	background-color: #0098ff;
}
li{
    position: relative;
    display: inline-block;
    width:30px; height:30px
}
img{
	width: 65px; /* 이미지의 너비를 조절하세요 */
    height: 65px;
    margin: 4px;
    display: inline-block;
            transition: transform 0.3s ease-in-out; /* 확대/축소 애니메이션 추가 */
}
.scroll {
            overflow: auto; /* 컨텐츠가 넘칠 경우 스크롤 표시 */
            height: 350px;
        }
        
        .enlarged-modal {
            display: none;
            position: fixed;
            top: 150px;
            left: 18px;
            width: 270px;
            height: 150px;
            background-color: white;
            border: 1px solid #ccc;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            overflow: hidden;
        }

        .enlarged-modal img {
            width: 100%;
            height: 100%;
        }
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
</head>
<body style="width:300px; height:500px">

<script type="text/javascript">

document.addEventListener('DOMContentLoaded', function () {
    var markethome = document.getElementById('photo');

    <% for (int i = 0; i < name.size(); i++) { %>
        var data<%= i %> = {
            name: '<%= name.get(i) %>',
            addr: '<%= addr.get(i) %>',
            phone: '<%= phone.get(i) %>'
            // Add other fields as needed
        };

        var element<%= i %> = document.createElement('photo');
        element<%= i %>.innerHTML = generateContent(data<%= i %>);
        markethome.appendChild(element<%= i %>);
    <% } %>
});

function generateContent(data) {
    var html =
    		'<div id ="' +data.name+ '" style="width:330px; height:600px"><br>'
    		+'<div style="width: 300px; height: 435px;">'
    		+'<a href="./home1.jsp#'+ data.name+'">'
    		+'<i style="color:#0098ff; font-size:20px;" class="bi bi-chevron-left"></i></a>'
    		+'<span style="font-size: 25px; font-weight: bold;">'
    		+'&nbsp;&nbsp;사진</span><br>'
			+'<br>'
			+data.name
			+'<div class="scroll">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_640.jpg" onclick="showEnlarged(this)">'
			+'</div>'
			+'</div>'
			+'<hr>'
    	    +'<div><a href="./home1.jsp#'+data.name+'"><button style="width: 70px; border-radius: 20px; text-align: center; padding-bottom: 2px;">홈</button></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
    	    +'<a href="./menu1.jsp#'+data.name+'"><button style="width: 70px; border-radius: 20px; text-align: center; padding-bottom: 2px;">메뉴</button></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
    	    +'<a href="./party1.jsp#'+data.name+'"><button style="width: 70px; border-radius: 20px; text-align: center; padding-bottom: 2px;">파티</button></a>'
			+'</div>'
			+'</div>'
    		;

    return html;
}
</script>



<div id="photo" style="width:330px; position: relative;">
	
	
</div>
    <div id="enlargedModal" class="enlarged-modal" onclick="hideEnlarged()">
        <span id="enlargedImage">x</span>
    </div>

    <script>
        function showEnlarged(img) {
            var enlargedModal = document.getElementById('enlargedModal');
            var enlargedImage = document.getElementById('enlargedImage');

            // 클릭한 이미지의 src를 가져와 모달 이미지에 설정
            enlargedImage.src = img.src;

            // 모달 표시
            enlargedModal.style.display = 'block';
        }

        function hideEnlarged() {
            var enlargedModal = document.getElementById('enlargedModal');

            // 모달 숨기기
            enlargedModal.style.display = 'none';
        }
    </script>

</body>
</html>