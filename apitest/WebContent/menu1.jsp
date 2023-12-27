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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable-dynamic-subset.min.css" /> 
<style type="text/css">
	body, html {
		overflow: hidden;
		background-color: #fafcfe;
		margin: 9px 0 0 9px;
	}
	
	button {
		cursor: pointer;
		border-color: gray;
		background-color: rgba(0, 152, 255, 0.3);
	}
	
	li {
		border-bottom: 0.2px dotted gray;
		list-style: none;
	}
	.scroll {
		overflow: auto; /* 컨텐츠가 넘칠 경우 스크롤 표시 */
		height: 380px;
		padding-top: 5px;
		padding-right: 10px;
	}	
	#menu{
		display: flex;
        justify-content: space-between;
        border-bottom: 1px dotted gray;
	}
</style>
</head>
<body style="width:320px; height:500px">

<script type="text/javascript">

document.addEventListener('DOMContentLoaded', function () {
    var markethome = document.getElementById('review');

    <% for (int i = 0; i < name.size(); i++) { %>
        var data<%= i %> = {
            name: '<%= name.get(i) %>',
            addr: '<%= addr.get(i) %>',
            phone: '<%= phone.get(i) %>'
            // Add other fields as needed
        };

        var element<%= i %> = document.createElement('review');
        element<%= i %>.innerHTML = generateContent(data<%= i %>);
        markethome.appendChild(element<%= i %>);
    <% } %>
});

function generateContent(data) {
    var html =
    		'<div id ="' +data.name+ '" style="width:320px; height:600px">'
    		+'<div style="width: 320px; height: 435px;">'
    		+'<a href="./home1.jsp#'+ data.name+'">'
    		+'<i style="color:#0098ff; font-size:20px;" class="bi bi-chevron-left"></i></a>'
    		+'<span style="font-size: 25px; font-weight: bold;">'
    		+'&nbsp;&nbsp;메뉴</span><hr>'
			+'<div class="scroll">'
			+'<div id="menu"><span>짜장면</span><span style="align-items: flex-end">5000원</span></div>'
			+'<div id="menu"><span>군만두</span><span style="align-items: flex-end">4000원</span></div>'
			+'<div id="menu"><span>쨈뽕</span><span style="align-items: flex-end">6000원</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
			+'<div id="menu"><span>곱배기</span><span style="align-items: flex-end">1000원 추가</span></div>'
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
</script>



<div id="review" style="width:320px;">
	
	
</div>



</body>
</html>