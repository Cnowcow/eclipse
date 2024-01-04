<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
        .menu {
            cursor: pointer;
        }

        .me {
            cursor: pointer;
        }
        /* 새로 추가한 부분: 왼쪽에서 나오는 메뉴 스타일 */
        .sidebar {
            height: 859px;
            width: 0px;
            position: fixed;
            z-index: 260;
            top: 0;
            left: 0;
            background-color: #fff;
            overflow-x: hidden;
            transition: 0.5s;
            padding-top: 60px;
            box-shadow: 2px 0px 8px lightgray;

         }

      #mysidebarframe{
         height: 770px;
         overflow: auto;
         -ms-overflow-style: none;   /* 스크롤 없애기 */
      }
      #mysidebarframe::-webkit-scrollbar{
         display: none;
      }

        .sidebar a {
            padding: 8px 8px 8px 32px;
            text-decoration: none;
            font-size: 18px;
            color: black;
            display: block;
            transition: 0.3s;
        }

        .sidebar .closebtn {
            position: absolute;
            font-size: 36px;
			top: 0px;
			right: 0px;      
        }
        
        /* 새로 추가한 부분: 검정 투명 배경 레이어 */
      .overlay {
          height: 100%;
          width: 100%;
          position: fixed;
          background-color: rgba(0, 0, 0, 0.7); /* 투명도를 조절한 부분 */
          z-index: 259; /* 메뉴바 뒤에 오도록 설정 */
          display: none;
      }

        @media screen and (max-height: 450px) {
            .sidebar {padding-top: 15px;}
            .sidebar>a {font-size: 18px;}
        }
    </style>
   <script>
       function showMenu() {
           document.getElementById("mySidebar").style.width = "300px";
           document.getElementById("overlay").style.display = "block";
       }
   
       function closeMenu() {
           document.getElementById("mySidebar").style.width = "0";
           document.getElementById("overlay").style.display = "none";
       }
   </script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
<link href="./css/headerfooter1.css" rel="stylesheet">
</head>
<body>
   <div class="header">
      <div class="headergroup">
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
      </div>
          <!-- 새로 추가한 부분: 검정 투명 배경 레이어 -->
    <div id="overlay" class="overlay"></div>
          <!-- 새로 추가한 부분: 왼쪽에서 나오는 메뉴 -->
    <div id="mySidebar" class="sidebar">

        <div>
	        <span style="position:absolute; top: 18px; left: 114px; font-size: 25px;">전체메뉴</span>
	        <a href="javascript:void(0)" class="closebtn" onclick="closeMenu()">×</a>
        </div>
        
        <div id="mysidebarframe">
           <div style="border-bottom: 2px solid gray; height: 50px;  margin-left: 30px;">
           <div style="width: 10px; height: 24px; display: inline-block; background:#0098FF;"></div>
           <h2 style="display: inline-block; color:gray; font-size: 24px;">&nbsp;이벤트</h2>
         </div>
           <a href="#">진행중인 이벤트 ></a>
           <a href="#">내 중심 주변이벤트 ></a>
           <a href="#">지난 이벤트 ></a>
           <a href="#">당첨자 확인 ></a>
         <br>
           <div style="border-bottom: 2px solid gray; height: 50px;  margin-left: 30px;">
           <div style="width: 10px; height: 24px; display: inline-block; background:#0098FF;"></div>
           <h2 style="display: inline-block; color:gray; font-size: 24px;">&nbsp;현재위치에서찾기</h2>
         </div>
           <a href="#">지역별 식당/파티 찾기 ></a>
           <a href="#">역주변 식당/파티 찾기 ></a>
           <a href="#">지도에서 식당/파티 찾기 ></a>
         <br>
           <div style="border-bottom: 2px solid gray; height: 50px;  margin-left: 30px;">
           <div style="width: 10px; height: 24px; display: inline-block; background:#0098FF;"></div>
           <h2 style="display: inline-block; color:gray; font-size: 24px;">&nbsp;파티</h2>
         </div>
         <a href="#">친구목록 ></a>
           <a href="#">파티목록 > </a>
           <a href="#">내파티 ></a>
           <a href="#">파티 채팅방 ></a>
         <br>
           <div style="border-bottom: 2px solid gray; height: 50px;  margin-left: 30px;">
           <div style="width: 10px; height: 24px; display: inline-block; background:#0098FF;"></div>
           <h2 style="display: inline-block; color:gray; font-size: 24px;">&nbsp;결제</h2>
         </div>
         <a href="#">결제페이지 ></a>
           <a href="#">충전하기 ></a>
           <a href="#">사용내역 ></a>
           <br>
           <div style="border-bottom: 2px solid gray; height: 50px;  margin-left: 30px;">
           <div style="width: 10px; height: 24px; display: inline-block; background:#0098FF;"></div>
           <h2 style="display: inline-block; color:gray; font-size: 24px;">&nbsp;마이페이지</h2>
         </div>
         <a href="#">마이페이지 ></a>
           <a href="#">공지사항 ></a>
           <a href="#">나의 팟 ></a>
      </div>
    </div>
</body>
</html>