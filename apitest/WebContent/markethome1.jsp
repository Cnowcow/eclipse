<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
       ArrayList<String> event = new ArrayList<>();
      
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
               event.add(rs.getString("event"));
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
}
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
</head>
<body>

<script type="text/javascript">

document.addEventListener('DOMContentLoaded', function () {
    var markethome = document.getElementById('home');

    <% for (int i = 0; i < name.size(); i++) { %>
        var data<%= i %> = {
            name: '<%= name.get(i) %>',
            addr: '<%= addr.get(i) %>',
            phone: '<%= phone.get(i) %>',
            event: '<%= event.get(i) %>'
            // Add other fields as needed
        };

        var element<%= i %> = document.createElement('home');
        element<%= i %>.innerHTML = generateContent(data<%= i %>);
        markethome.appendChild(element<%= i %>);
    <% } %>
});

function generateContent(data) {
    var html =
    		'<div id ="' +data.name+ '"><br>'	
    		+'<span style="font-size: 20px; font-weight: bold;">' + data.name + ' </span><span style="color: red">'
    		+'★</span>4.7&nbsp;<span style="color: skyblue"><a href="./review.jsp#'+data.name+'" target="_self">후기(421건)</a></span><br><br>'
    		+'<span>주 &nbsp;&nbsp;&nbsp;&nbsp; 소<span>&nbsp; :'+ data.addr+ '<br>'
    		+' <span>전화번호<span>&nbsp; : ' + data.phone + '<br>'
    		+' <span>영업시간<span>&nbsp; : '
    		+'<hr>'
	    	+'<span style="font-size: 17px; font-weight: bold;">사진</span><a href="#">(더보기)</a><br>'
    	    +'사진들어갈곳<br><br>'
    	    +'<hr>'
    	    +'<span style="font-size: 17px; font-weight: bold;">메뉴</span><a href="#">(더보기)</a><br>'
    	    +'메뉴들어갈곳<br><br><br>'
    	    +'<hr>'
    	    +'<span style="font-size: 17px; font-weight: bold;">파티목록(5)</span><a href="#">(더보기)</a><br>'
    	  	+'파티들어갈곳<br><br><br><br>'
			+'<hr>'
    	    +'<div><a href="./markethome1.jsp#'+data.name+'"><button style="width: 70px; border-radius: 20px; text-align: center; padding-bottom: 2px;">홈</button></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
    	    +'<a href="#"><button style="width: 70px; border-radius: 20px; text-align: center; padding-bottom: 2px;">메뉴</button></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
    	    +'<a href="#"><button style="width: 70px; border-radius: 20px; text-align: center; padding-bottom: 2px;">파티</button></a>'
			+'</div>'
			+'</div>'
			
    		;

    return html;
}
</script>



<div id="home" style="width: 330px; height: 600px">
	
	
</div>



</body>
</html>