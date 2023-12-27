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
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
</head>
<body style="width:300px; height:500px">

<script type="text/javascript">

document.addEventListener('DOMContentLoaded', function () {
    var markethome = document.getElementById('menu');

    <% for (int i = 0; i < name.size(); i++) { %>
        var data<%= i %> = {
            name: '<%= name.get(i) %>',
            addr: '<%= addr.get(i) %>',
            phone: '<%= phone.get(i) %>'
            // Add other fields as needed
        };

        var element<%= i %> = document.createElement('menu');
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
    		+'&nbsp;&nbsp;메뉴</span><hr>'
			+'<br>'
			+data.name
			+'<div style="display: flex; flex-wrap: wrap;">'
			+'<span style="flex-basis: 50%;">짜장면</span><span style="flex-basis: 50%; text-align: right;">5000원</span>'
			+'<span style="flex-basis: 50%;">군만두</span><span style="flex-basis: 50%; text-align: right;">4000원</span>'
			+'<span style="flex-basis: 50%;">쨈뽕</span><span style="flex-basis: 50%; text-align: right;">6000원</span>'
			+'<span style="flex-basis: 50%;">곱배기</span><span style="flex-basis: 50%; text-align: right;">1000원 추가</span>'
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



<div id="menu" style="width:330px;">
	
	
</div>



</body>
</html>