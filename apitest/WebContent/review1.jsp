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
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable-dynamic-subset.min.css" /> 
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">

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
	
	li {
		list-style: none;
		font-size: 17px;
		width: 298px;
		box-shadow: 0px 0px 1px 1px gray;
		border-radius: 10px;
		margin: 0 0 5px 3px;
		padding: 6px 0 8px 6px;
	}
	
	.scroll {
		overflow: auto; /* 컨텐츠가 넘칠 경우 스크롤 표시 */
		height: 380px;
		padding-top: 5px
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
    		+'&nbsp;&nbsp;후기</span>  (<%= name.size() %>)<hr>'
			+'<div class="scroll">'
			
			<%for (int i = 0; i < name.size(); i++) {%>
    		html += '<li><strong>' + '<%=name.get(i)%>' + '</strong>&nbsp;&nbsp;<span style="color:gray; font-size:13px;">' + '<%=phone.get(i)%>' + '</span>'
        		+ '&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size:13px;">★★★★☆</span><br>'
        		+ '<span style="font-size:14px;">' + '<%=addr.get(i)%>' + '</span></li>'<%}%>
			
			+'<li><strong>라인하르트&nbsp;&nbsp;</strong><span style="color:gray; font-size:14px;">23-12-28</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size:14px;">★★★★☆</span><br>'
			+'<span style="font-size:16px;">방패가 맛있고 돌진이 친절해요</span></li>'
			
			+'<li><strong>오리사&nbsp;&nbsp;</strong><span style="color:gray; font-size:14px;">23-12-28</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size:14px;">★★★★☆</span><br>'
			+'<span style="font-size:16px;">창돌리기가 너무 맛있어요</span></li>'
			
			+'<li><strong>메르시&nbsp;&nbsp;</strong><span style="color:gray; font-size:14px;">23-12-27</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size:14px;">★★★★☆</span><br>'
			+'<span style="font-size:16px;">부활이 딱 제 입맛이에요</span></li>'
			
			+'<li><strong>루시우&nbsp;&nbsp;</strong><span style="color:gray; font-size:14px;">23-12-26</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size:14px;">★★★★☆</span><br>'
			+'<span style="font-size:16px;">비트주세요</span></li>'
			
			+'<li><strong>겐지&nbsp;&nbsp;</strong><span style="color:gray; font-size:14px;">23-12-25</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size:14px;">★★★★☆</span><br>'
			+'<span style="font-size:16px;">미오 스테테모.. 미오리와 스테즈...</span></li>'
			
			+'<li><strong>둠피스트&nbsp;&nbsp;</strong><span style="color:gray; font-size:14px;">23-12-25</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size:14px;">★★★★☆</span><br>'
			+'<span style="font-size:16px;">코코볼 맛집</span></li>'
			
			+'<li><strong>솔져&nbsp;&nbsp;</strong><span style="color:gray; font-size:14px;">23-12-25</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size:14px;">★★★★☆</span><br>'
			+'<span style="font-size:16px;">병장 진급했습니다</span></li>'

			+'<li><strong>맥크리&nbsp;&nbsp;</strong><span style="color:gray; font-size:14px;">23-12-24</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size:14px;">★★★★☆</span><br>'
			+'<span style="font-size:16px;">캐서디</span></li>'
			
			+'<li><strong>디바&nbsp;&nbsp;</strong><span style="font-size:14px; color:red">★</span><span style="font-size:14px;">4.5</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:gray; font-size:14px;">23-12-24</span><br>'
			+'<span style="font-size:16px;">하이용</span></li>'
			
			+'<li><strong>윈스턴&nbsp;&nbsp;</strong><span style="font-size:14px; color:red">★</span><span style="font-size:14px;">4.5</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:gray; font-size:14px;">23-12-23</span><br>'
			+'<span style="font-size:16px;">고릴라 아닙니다</span></li>'
			
			+'<li><strong>위도우 메이커&nbsp;&nbsp;</strong><span style="font-size:14px; color:red">★</span><span style="font-size:14px;">4.5</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:gray; font-size:14px;">23-12-22</span><br>'
			+'<span style="font-size:16px;">아무도 내게서 숨지 못해</span></li>'
			
			+'<li><strong>파라&nbsp;&nbsp;</strong><span style="font-size:14px; color:red">★</span><span style="font-size:14px;">4.5</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:gray; font-size:14px;">23-12-21</span><br>'
			+'<span style="font-size:16px;">하늘에서 정의가 빗발친다</span></li>'
			
			+'<li><strong>정크랫&nbsp;&nbsp;</strong><span style="font-size:14px; color:red">★</span><span style="font-size:14px;">4.5</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:gray; font-size:14px;">23-12-20</span><br>'
			+'<span style="font-size:16px;">죽이는 타이어 준비 완료</span></li>'
			
			+'<li><strong>젠야타&nbsp;&nbsp;</strong><span style="font-size:14px; color:red">★</span><span style="font-size:14px;">4.5</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:gray; font-size:14px;">23-12-19</span><br>'
			+'<span style="font-size:16px;">초월이 너무 맛있어요</span></li>'
			
			+'<li><strong>아나&nbsp;&nbsp;</strong><span style="font-size:14px; color:red">★</span><span style="font-size:14px;">4.5</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:gray; font-size:14px;">23-12-19</span><br>'
			+'<span style="font-size:16px;">넌 강해졌다, 돌격해!</span></li>'
			
			+'<li><strong>리퍼&nbsp;&nbsp;</strong><span style="font-size:14px; color:red">★</span><span style="font-size:14px;">4.5</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:gray; font-size:14px;">23-12-18</span><br>'
			+'<span style="font-size:16px;">주거,,,, 주거,,,,, 주거,,,,,</span></li>'
			
			+'<li><strong>바스티온&nbsp;&nbsp;</strong><span style="font-size:14px; color:red">★</span><span style="font-size:14px;">4.5</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:gray; font-size:14px;">23-12-16</span><br>'
			+'<span style="font-size:16px;">쀼쀼ㅃㅣ쀼ㅣ쀼ㅣㅃㅃ빕</span></li>'
			
			+'<li><strong>한조&nbsp;&nbsp;</strong><span style="font-size:14px; color:red">★</span><span style="font-size:14px;">4.5</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:gray; font-size:14px;">23-12-16</span><br>'
			+'<span style="font-size:16px;">대기중</span></li>'
			
			+'<li><strong>솜브라&nbsp;&nbsp;</strong><span style="font-size:14px; color:red">★</span><span style="font-size:14px;">4.5</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:gray; font-size:14px;">23-12-13</span><br>'
			+'<span style="font-size:16px;">뿝</span></li>'
			
			+'<li><strong>토르비욘&nbsp;&nbsp;</strong><span style="font-size:14px; color:red">★</span><span style="font-size:14px;">4.5</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:gray; font-size:14px;">23-12-11</span><br>'
			+'<span style="font-size:16px;">열이 머리 끝까지 솟는구먼~!</span></li>'
			
			+'<li><strong>트레이서&nbsp;&nbsp;</strong><span style="font-size:14px; color:red">★</span><span style="font-size:14px;">4.5</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:gray; font-size:14px;">23-12-11</span><br>'
			+'<span style="font-size:16px;">안녕친구들ㅎ 해결사가 왔어</span></li>'
			
			+'<li><strong>자리야&nbsp;&nbsp;</strong><span style="font-size:14px; color:red">★</span><span style="font-size:14px;">4.5</span>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:gray; font-size:14px;">23-12-8</span><br>'
			+'<span style="font-size:16px;">아돈 빠가돈...</span></li>'

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