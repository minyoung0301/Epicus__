<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="notification.Notifications" %>
  <%@ page import="notification.NotificationDAO" %>
  <%@ page import="java.util.ArrayList, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공모전작성</title>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="Stylesheet"  href="./css/writecontest.css">
<script src="menu.js"></script>
<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="./smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var oEditors = [];
$(function(){
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: oEditors,
          elPlaceHolder: "detailtxt1", //textarea에서 지정한 id와 일치해야 합니다. 
          //SmartEditor2Skin.html 파일이 존재하는 경로
          sSkinURI: "./smarteditor/SmartEditor2Skin.html",  
          htParams : {
              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseToolbar : true,             
              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseVerticalResizer : true,     
              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
              bUseModeChanger : true,         
              fOnBeforeUnload : function(){
                   
              }
          }, 
          fOnAppLoad : function(){
              //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
              oEditors.getById["detailtxt1"].exec("PASTE_HTML", [""]);
          },
          fCreator: "createSEditor2"
      });
      
      //저장버튼 클릭시 form 전송
      $("#save").click(function(){
          oEditors.getById["detailtxt1"].exec("UPDATE_CONTENTS_FIELD", []);
          $("#frm").submit();
      });    
});
 
 
 
</script>
</head>
<body>
	<%
	//로그인이 된 사람들은 로그인정보를 담을 수 있도록한다.
	String userID = null;
	//만약에 현재 세션이 존재한다면
	if (session.getAttribute("userID") != null) {
		//그 아이디값을 받아서 userID인스턴스로 관리할 수 있도록 한다.
		userID = (String) session.getAttribute("userID");
	}

	%>
<header class = "menubar">
	<div class="main"><a href ="home.jsp">Epicus</a></div>
	<div class="menu">
		
		<ul class ="menuul">
		<li class= "menuli"><a href ="home.jsp" >홈</a></li>
		<li class= "menuli"><a href ="mycontent.jsp">내작품</a></li>
		<li class= "menuli"><a href ="board.jsp">게시판</a></li>
		<li class= "menuli"><a href ="contest.jsp">공모전</a></li>
		
		<%
				// 접속하기는 로그인이 되어있지 않은 경우만 나오게한다.
			if (userID == null) {
			%>
			<li class="menuli"><a href="login.jsp">로그인</a></li>
			<li class="menuli"><a href="join.jsp">회원가입</a></li>
	
	<%
				// 로그인이 되어있는 사람만 볼수 있는 화면
			} else {
			NotificationDAO notificationDAO = new NotificationDAO();
			        List<Notifications> notifications = notificationDAO.getNotifications(userID);
			%>
			<table id="notificationsTable" border="1" style="display: none; position: fixed; top: 50px; right: 10px;">
 <tr>
     <th>알림 내용</th>
 </tr>
 <%
     for (Notifications notification : notifications) {
 %>
 <tr>
     <td><%= notification.getMessage() %></td>
 </tr>
 <%
     }
 %>
</table>
			<li class="menuli"><button class="notify" onclick="toggleNotifications()"><i class="fa-regular fa-bell fa-lg" style="color: #324b4c;"></i></button></li>
			<li class="menuli"><button class="myprofile" onclick="dropdown()"><i class="fa-solid fa-circle-user fa-xl" style="color: #324b4c;"></i></button></li>
				
				</ul>
				<ul class="profileul" id="drop" style="display: none;">
				
				<li class="profileli" ><a href="mypage_mycontent.jsp">마이페이지</a></li>
				<li class="profileli" ><a href="logoutAction.jsp">로그아웃</a></li>
				
					<%} %>
				</ul>
				

	
	</div>
	
	</header>
	
	
	<div class="writecontest">
	공모전 등록
	</div>
	<form id = "frm" method="post" action="contestAction.jsp">
	<section class="contestsec">
		<hr class="contesthr">
		<div class="contestdiv">
			<ul class="contestul">
				<li class="contestli">제목</li>
				<li class="contestli">분야</li>
				<li class="contestli">응모대상</li>
				<li class="contestli">주최/주관</li>
				<li class="contestli">접수기간</li>
				<li class="contestli">홈페이지</li>
			</ul>
			
			<div class="text">
			<textarea class="t1" name="cTitle" cols="70px;" rows="1"></textarea>
			<textarea class="t2" name="field" cols="70px;" rows="1"></textarea>
			<textarea class="t3" name="object" cols="70px;" rows="1"></textarea>
			<textarea class="t4" name="host" cols="70px;" rows="1"></textarea>
			<textarea class="t5" name="period" cols="70px;" rows="1"></textarea>
			<textarea class="t6" name="link" cols="70px;" rows="1"></textarea>
			
			</div>
			
		</div>
		
		
	</section>
	<section class="contestsec2">
	
		<div class="detaildiv">
		<h1 class="detailh1">상세내용</h1>
		<h3 class="ex">※ 본 내용은 참고 자료입니다. 반드시 주최사 홈페이지의 일정 및 상세 내용을 확인하세요.</h3>
			<textarea id = "detailtxt1" class="detailtxt" name="detail" cols="142;" rows="40;"></textarea>
		</div>
	</section>
	<footer class="btnfooter">
		<input type="button" class="listbtn" value="목록으로" onclick="location.href='contest.jsp'">
		<input id ="save" type="submit" class="createbtn" value="생성"> 
	</footer>
	</form>
	
</body>
</html>