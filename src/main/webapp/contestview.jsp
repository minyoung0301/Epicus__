<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="contest.contestDAO" %>
<%@ page import="contest.contest2" %>
<%@ page import="notification.Notifications" %>
  <%@ page import="notification.NotificationDAO" %>
  <%@ page import="java.util.ArrayList, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<script src="menu.js"></script>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="Stylesheet"  href="./css/writecontest.css">
<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
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

	 int contestID = 1; 
	 //만약에 파라미터로 pageNumber가 넘어왔다면 해당 파라미터의 값을 넣어주도록 한다.
	if (request.getParameter("contestID") != null)
	{
		//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다.
	    contestID = Integer.parseInt(request.getParameter("contestID"));
	} 
	contest2 contest = new contestDAO().getcontest(contestID);
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

	
	
	<div class="writecontest">
	공모전 등록
	</div>
	
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
			<div class="t1"><%=contest.getcTitle() %></div>
			<div class="t2"><%=contest.getField() %></div>
			<div class="t3"><%=contest.getObject() %></div>
			<div class="t4"><%=contest.getHost() %></div>
			<div class="t5"><%=contest.getPeriod() %></div>
			<div class="t6"><%=contest.getLink() %></div>

			
			
			
			</div>
			
		</div>
		
		
	</section>
	<section class="contestsec2">
	
		<div class="detaildiv">
		<h1 class="detailh1">상세내용</h1>
		<h3 class="ex">※ 본 내용은 참고 자료입니다. 반드시 주최사 홈페이지의 일정 및 상세 내용을 확인하세요.</h3>
			<div class="detailtxt"><%=contest.getDetail() %></div>
		</div>
	</section>
	<footer class="btnfooter">
		<input type="button" class="listbtn" value="목록으로" onclick="location.href='contest.jsp'">
		<input type="button" class="createbtn" value="이전"> 
	</footer>
	
	
</body>
</html>