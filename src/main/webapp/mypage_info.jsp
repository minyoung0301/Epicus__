<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.User" %>
    <%@ page import="user.UserDAO" %>
<%@ page import="notification.Notifications" %>
  <%@ page import="notification.NotificationDAO" %>
  <%@ page import="java.util.ArrayList, java.util.List" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href ="./css/mypage.css">
<link rel ="stylesheet" href ="./css/mypage_info.css">
<script src="menu.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
</head>
<body>
	<header class = "menubar">
<%
	//로그인이 된 사람들은 로그인정보를 담을 수 있도록한다.
	String userID = null;
	//만약에 현재 세션이 존재한다면
	if (session.getAttribute("userID") != null) {
		//그 아이디값을 받아서 userID인스턴스로 관리할 수 있도록 한다.
		userID = (String) session.getAttribute("userID");
	}
	 
    UserDAO userDAO = new UserDAO();
    User user = userDAO.getUserByID(userID);
    
    if (user == null) {
        out.println("사용자 정보를 가져오는 데 문제가 발생했습니다.");
    } else {
        String userName = user.getUserName();
        String userEmail = user.getUserEmail();
	%>
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
	<nav class="mypagenav">
	<h1 class="titleh1">정보수정</h1>
		</nav>
<section class="menubtn">
		
		<div class="mymenu">
			<ul class="myul">
				<li class="myli"><a href ="mypage_mycontent.jsp" >내 작품 목록</a></li>
				<li class="myli"><a href ="mypage_read.jsp" >최근 본 작품</a></li>
				<li class="myli"><a href ="mypage_bookmark.jsp" >즐겨찾기</a></li>
				<li class="myli"><a href ="mypage_friend.jsp" >친구 관리</a></li>
				<li class="myli"><a href ="mypage_info.jsp" >정보 수정</a></li>
				<li class="myli"><a href ="mypage_leave.jsp" >탈퇴하기</a></li>
			</ul>
		</div>
		<div class="profilecircle">
		
		<img class="profileimg" src="profile.png">	
		</div>
		<div class="d">
	
	</div>

	<div class="mypagediv">
	<form action="userUpdate.jsp" method="post">
		<div class="mypagediv2">
		
			<img class="userinfo" src ="profile.png">
			<input type="button" class="changeimg" value="이미지 변경">
		</div>
		
		<div class="infodiv">
			
	<div class="labeldiv">
	<ul class="labelul">
		<li class="labelli">닉네임</li>
		<li class="labelli">아이디</li>
		<li class="labelli">새 비밀번호</li>
		<li class="labelli">이메일</li>
		
	</ul>
	<ul class="textareaul">
		<li class="textli"><textarea id="name" name="name" cols=5 rows=1><%=userName %></textarea></li>
	   	<li class="textli"><%=userID%></li>
	   
	    <li class="textli"><textarea id="password" name="password" cols=10 rows=1></textarea></li>
    	<li class="textli"><textarea id="email" name="email" cols=30 rows=1><%=userEmail %></textarea></li>
	</ul>
	</div>
	<!-- <div class="textdiv">
    <ul class="textareaul">
    <li class="textli"></li>
   <li class="textli"></li>
   
    <li class="textli"></li>

    

    <li class="textli"></li>
    </ul>
    </div> -->
   
    <input type="submit" class="modify" value="수정하기">
     </div>
</form>

<%
    }
%>
		</div>
	</div>
	</section>
	<footer class="mypagefooter">
		
	</footer>
	
</body>
</html>