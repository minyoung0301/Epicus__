<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="notification.Notifications" %>
<%@ page import="notification.NotificationDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>
<%-- <jsp:useBean id ="notification" class="notification.Notifications" scope="page"/>
<jsp:setProperty name="Notifications" property="followingID"/>
<jsp:setProperty name="Notifications" property="message"/> --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href ="./css/mypage.css">
<script src="menu.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
<style>

ul{list-style:none;}
.btn{
	text-decoration : none;
	font-weight : bold;
	color : green;
	
}
.btn1{
	text-decoration:none;
	font-weight:bold; 
	color:black;
	font-size : 25px;
		
 }


.tab_menu .list{overflow:hidden;
	bottom: 7px;
    right: 30px;
    position: relative;}
.tab_menu .list li{float:left; margin-right:14px;}
.tab_menu .list li.is_on .btn{font-weight:bold; color:green;}
.tab_menu .list .btn{font-size:25px;}
.cont{display: none;}
</style>
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
	String followerID = userID;
    // 로그인한 사용자 ID 가져오기

    String followingID = request.getParameter("followingID");

  /*   if (userID != null && followingID != null) {
        UserDAO userDAO = new UserDAO();

        // 팔로우 정보를 데이터베이스에 저장
        int result = userDAO.followUser(userID, followingID);
		
        if (result == 1) {
            // 팔로우 성공
            String message = userID + "님이 팔로우 하였습니다.";
    NotificationDAO notificationDAO = new NotificationDAO();
    notificationDAO.addNotification(followingID, message); // 반환값 무시

    //Notifications notification = new Notifications(); // 또는 적절한 생성자 사용

    out.println("팔로우가 완료되었습니다.");

            // 알림 생성
            
        } else {
            // 팔로우 실패
          
        }
    } else {
       
    } */
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
    <%-- <%
        for (Notifications notification : notifications) {
    %>
    <tr>
        <td><%= notification.getMessage() %></td>
    </tr>
    <%
        }
    %> --%>
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

	
	
	</header>

	<nav class="mypagenav">
	  <div class="tab_menu"  style="display:block;">
<!--    <ul class="list">
      <li class="is_on">
        <a href="#tab1" class="btn">친구추가</a>
      </li>
      <li>
        <a href="#tab2" class="btn">친구 목록</a>
      </li>
      
    </ul> -->
       <ul class="list">
      <li class="is_on">
        <a href="mypage_friend.jsp" class="btn">친구추가</a>
      </li>
      <li>
        <a href="mypage_friendlist.jsp" class="btn1">친구 목록</a>
      </li>
      
    </ul>
  </div>
	<span class="searchtab">
		<input type="text" class="ftext" placeholder="닉네임을 입력하세요">
		<input type="submit" class="fsearch" value="검색">
	</span>
	
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
		<!-- <i class="fa-solid fa-circle-user fa-xl" style="color: #324b4c;"></i> -->
		<img class="profileimg" src="profile.png">
			
		</div>
	<div class="d">
	
	</div>

	<div class="mypagediv">
	
		<%	
		UserDAO userDAO = new UserDAO();
	    String targetUserID = request.getParameter("userID");
	    String myuserID = request.getParameter("userID");
		User user = userDAO.getUserByID(targetUserID);
			//UserDAO UserDAO = new UserDAO();
	
			ArrayList<User> userList = userDAO.getAllUsers(); 
			
			for ( int i= 0; i<userList.size(); i++)
			{
		%>
		<form action="follow.jsp?followerID=<%=userID%>&followingID=<%=userList.get(i).getUserID()%>" method="post">
		<div id ="tab1" class="userdiv">
				<div class="userimage">
					<img class="profileimg1" src="character.png">
				</div>
			<div class="userID">
			 <input type="hidden" name="followerID" value="<%= userID %>"><%=userList.get(i).getUserID() %>
			</div>
			<div class="userName">
		
			<%=userList.get(i).getUserName() %>
			</div>
			<input type="submit" class="followbtn" value="팔로우">
			<a class="author" href="author.jsp?userID=<%=userList.get(i).getUserID() %>">> 작가페이지로 가기</a>
		
		</div>
			<hr class="userhr">
			</form>
		
		<%} %>
	


	</div>
	
	</section>

	<footer class="mypagefooter">
		
	</footer>
	
</body>
</html>