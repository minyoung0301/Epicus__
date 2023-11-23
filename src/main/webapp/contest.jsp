<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="contest.contestDAO" %>
<%@ page import="contest.contest2" %>
<%@ page import="java.util.ArrayList, java.util.List" %>
<%@ page import="notification.Notifications" %>
  <%@ page import="notification.NotificationDAO" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공모전</title>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href ="./css/contest.css">
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
<script src="menu.js"></script>



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
	 int pageNumber = 1; 
	 //만약에 파라미터로 pageNumber가 넘어왔다면 해당 파라미터의 값을 넣어주도록 한다.
	if (request.getParameter("pageNumber") != null)
	{
		//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다.
	    pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
		<li class="menuli"><a href="mypage_mycontent.jsp">마이페이지</a></li>
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

		<nav class="searchnav">
		<span class="contestspan">공모전</span>
		<div class="searchdiv">
		<span class="contestspan2"><input type="text" class="search"></span>
		<span class="contestspan3"><input type="button" class="searchbtn" value="검색"></span>
		
		</div>
		</nav>
		<nav class="contestnav">
		<div class="banner"><img src="contest2.png" class="bannerimg"></div>
	</nav>
	<section class="contestmenu">
		<div class="contestmenubar">
			<ul class="contestul2">
				<li class="contest2li">전체 공모전  |</li>
			</ul>
			
			
		</div>
		<div class="btn">
		
		</div>
	</section>
	
	<nav class="pencilmenu">
	<%if(session.getAttribute("userID").equals("admin")){ %>
	<div class="contestwrite"><img src="pencil.png" onclick="location.href='writecontest.jsp'"><span class="writecontest">공모전 작성</span></div>
	
	<%} %>
	</nav>
	
	<section class="contestlist">
		<ul class="contestul1">
			<li class="contestli">번호</li>
			<li class="contestli2">제목</li>
			<li class="contestli3">조회수</li>
		</ul>
		<%	
	
			contestDAO contestDAO = new contestDAO();
	
			ArrayList<contest2> list = contestDAO.getList(pageNumber);
			
			for ( int i= 0; i<list.size(); i++)
			{
		%>
		<ul class="contestul2">
			<li class="contestli"><a href="contestview.jsp?contestID=<%=list.get(i).getContestID() %>"><%=list.get(i).getContestID() %></a></li>
			<li class="contestli2"><a href="contestview.jsp?contestID=<%=list.get(i).getContestID() %>"><%=list.get(i).getcTitle()%></a></li>
			<li class="contestli3"><a href="contestview.jsp?contestID=<%=list.get(i).getContestID() %>"><%=list.get(i).getcHit() %></a></li>
			
		</ul>
		<%} %>
	</section>
	


</body>
</html>