<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="java.io.PrintWriter"%>
<%@ page import="notification.Notifications" %>
  <%@ page import="notification.NotificationDAO" %>
  <%@ page import="java.util.ArrayList, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/menu.css">
<script src="menu.js"></script>
<link rel="stylesheet" href="./css/createcharacter.css">
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
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
			<table id="notificationsTable" border="1" style="display: none; position: fixed; top: 50px;">
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

		<script>
	$(document).ready(function() {
	    $("#uploadForm").submit(function(e) {
	        e.preventDefault();

	        var formData = new FormData(this);

	        $.ajax({
	            url: "magiccreatecharacterAction.jsp", // 이미지와 게시물을 처리할 서버 스크립트 페이지
	            type: "POST",
	            data: formData,
	            processData: false,
	            contentType: false,
	            success: function(response) {
	                // 업로드 성공 시 처리
	                alert("게시물이 성공적으로 업로드되었습니다.");
	                window.location.href = "characterlist.jsp";
	            },
	            error: function(xhr, status, error) {
	                // 업로드 실패 시 처리
	                alert("업로드 중 오류가 발생했습니다.");
	            }
	        });
	    });
	});
	</script>
	<form method="post" id="uploadForm" action="magiccreatecharacterAction.jsp" enctype="multipart/form-data">
	<section class="createsec">
		<div class="newcontent">
	<h1 class="createh1">인물 생성</h1>
	<hr class="createhr">
	</div>
	<div class="explanation">한줄설명</div>
		<textarea class="explanation" name="explanationInput" placeholder="한줄요약해주세요" cols="102" rows="1"></textarea>
	<div class="img">
		<div class="coverimg"></div>
		<input type="file" id="image" class="image" name="image" style="display: none;">
		<label for ="image" id ="image" class="filebtn" style="background-color : #324B4C; width:150px; height :30px;">이미지 불러오기</label>
	</div>	
	<div class="infodiv">
		<ul class="infoul">
			<li class="infoli">이름<textarea class="name" name="name" placeholder ="이름을입력하세요" cols ="102" rows="1"></textarea></li>
			<li class="infoli">나이<textarea class="age" name="ageInput" placeholder="나이입력해주세요" cols="102" rows="1"></textarea></li>
			<li class="infoli">성별<textarea class="gender" name="genderInput" placeholder="성별입력해주세요" cols="102" rows="1"></textarea></li>
			<li class="infoli">생일<textarea class="birthday" name="birthdayInput" placeholder="생일입력해주세요" cols="102" rows="1"></textarea></li>
		</ul>
		<ul class="infoul2">
			<li class="infoli2">출생지<textarea class="place" name="placeInput" placeholder="출생지입력해주세요" cols="102" rows="1"></textarea></li>
			<li class="infoli2">거주지<textarea class="residence" name="residenceInput" placeholder="거주지입력해주세요" cols="102" rows="1"></textarea></li>
			<li class="infoli3">직업 <textarea class="job" name="jobInput" placeholder="직업입력해주세요" cols="102" rows="1"></textarea></li>
			<li class="infoli3">별명 <textarea class="nickname" name="nicknameInput" placeholder="별명입력해주세요" cols="102" rows="1"></textarea></li>
		</ul>
		
	</div>
		<div class="personalitydiv">성격</div>
		<textarea class="personality" name="personalityInput" placeholder="성격입력해주세요" cols="102" rows="3"></textarea>
		<div class="appearancediv">외모</div>
		
		<textarea class="appearance" name="appearanceInput" placeholder="외모입력해주세요" cols="102" rows="3"></textarea>
		<hr class="infohr">
		<div class="talentdiv">장점</div>
		<textarea class="talent" name="talentInput" placeholder="장점입력해주세요" cols="102" rows="3"></textarea>
		<div class="advantagediv">단점</div>
		<textarea class="advantage" name="advantageInput" placeholder="단점입력해주세요" cols="102" rows="3"></textarea>
		<div class="role">역할</div>
		<textarea class="role" name="roleInput" placeholder="역할입력해주세요" cols="102" rows="3"></textarea>
		<div class="hobby">취미</div>
		<textarea class="hobby" name="hobbyInput" placeholder="취미입력해주세요" cols="102" rows="3"></textarea>
		<div class="etc">기타</div>
		<textarea class="etc" name="etcInput" placeholder="기타입력해주세요" cols="102" rows="3"></textarea>
		
	</section>

	<footer class="btnfooter">
	
		<input type="button" class="listbtn" value="목록으로" onclick="location.href='magiccontent.jsp'">
		<input type="submit" class="createbtn" value="생성">
		
	</footer>
	</form>
</body>
</html>