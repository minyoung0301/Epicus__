<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="test.free" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList, java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="notification.Notifications" %>
  <%@ page import="notification.NotificationDAO" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse" %> 
<jsp:include page="boardDB.jsp" />
<%
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
    ResultSet rs = (ResultSet) request.getAttribute("resultSet");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="menu.js"></script>
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href ="./css/board.css">
</head>
<body style ="overflow-x:hidden;">
	<%
	
	Boolean isLike=false;
	//List<free> posts = new ArrayList<>();
	String searchField =request.getParameter("searchField");
	String searchText =request.getParameter("searchText");
	
	String userID = null;
	
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	
	%>
<header class = "menubar">
	<div class="main"><a href ="home.jsp">Epicus</a></div>
	<div class="menu">
		
		<ul class ="menuul">
		<li class= "menuli"><a href ="home.jsp" >홈</a></li>
		<li class= "menuli"><a href ="mycontent.jsp">내작품</a></li>
		<li class= "menuli"><a href ="board.jsp?fopen=1">게시판</a></li>

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

	
	

	<nav class="boardnav">
		<h1 class="boardh1">게시판 > 전체</h1>

		<div class="searchdiv">
		<form method="post" name="search" action="board2.jsp">
		
		<td><select class="form-control" name="searchField">
								<option value="0">선택</option>
								<option value="fTitle">제목</option>
								<option value="userID">작가명</option>
						</select></td>
		<input type="text" class="search" name="searchText">
		<input type="submit" class="searchbtn" value="검색">
		</form>
		</div>
		
		<hr class="boardhr">
		
		
		
	</nav>
	<nav class="menunav">
	<div class="uldiv">
		<ul class="ulmenu">
		  <li class="limenu"><a class="active" href="board.jsp">전체</a></li>
		  <li class="limenu"><a class="active" href="#">추리</a></li>
		  <li class="limenu"><a class="active" href="#">무협</a></li>
		  <li class="limenu"><a class="active" href="#">일기</a></li>
		  <li class="limenu"><a class="active" href="#">사극</a></li>
		  <li class="limenu"><a class="active" href="#">스릴러</a></li>
		  <li class="limenu"><a class="active" href="#">게임</a></li>
		  <li class="limenu"><a class="active" href="#">우화</a></li>
		  <li class="limenu"><a class="active" href="#">공포</a></li>
		  <li class="limenu"><a class="active" href="#">로맨스</a></li>
		  <li class="limenu"><a class="active" href="#">모험</a></li>
		  <li class="limenu"><a class="active" href="#">과학(SF)</a></li>
		  <li class="limenu"><a class="active" href="#">자서전</a></li>
		  <li class="limenu"><a class="active" href="#">역사</a></li>
		  <li class="limenu"><a class="active" href="#">판타지</a></li>
		  <li class="limenu"><a class="active" href="#">전기</a></li>
		  <li class="limenu"><a class="active" href="#">라이트노벨</a></li>
		  
		</ul>
	</div>
	<div class="contestbanner">
	<img class="contestimg" src="contestbanner.png" onclick="location.href='contest.jsp'">
	</div>	

	
	  <%
	  
	  while (rs.next()) { 
	  int freeID = rs.getInt("freeID");
	  int flike_count = rs.getInt("flike_count");
	  Timestamp fDate = rs.getTimestamp("fDate");
	  String formattedDate = dateFormat.format(fDate);
	  
	  %>

<div class="boarduldiv">
	<div class="image"><a href="showcontent.jsp?freeID=<%= rs.getInt("freeID") %>"><img class="contentimg" src="rabbit.png"></a></div>
	<div class="title"><img class="talk" src="Talk2.png"><a class="titlea" href="showcontent.jsp?freeID=<%= rs.getInt("freeID") %>"><%= rs.getString("fTitle") %></a></div>
	<div class="user"><%=rs.getString("userID") %></div>
	<div class="Into"><img class="talk2" src="Talk.png"><a class="fIntoa" href="showcontent.jsp?freeID=<%=rs.getInt("freeID")%>"><%= rs.getString("fInto") %></a></div>
	<div class="date"><%=formattedDate%></div>
	<div class="star">
    <%
    if (isLike) {
    %>
        <img id="heart" src="./star_on.png" alt="좋아요" title="on" onclick="like()">
        <span id="like" class="heartspan"><%=flike_count %></span>
    <%
    } else {
    %>
        <img id="heart" src="./star_off.png" alt="좋아요" title="off" onclick="like()">
        <span id="like" class="heartspan"><%=flike_count %></span>
    <% } %>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const isLike = localStorage.getItem("isLike") === "true";
    const likeCount = localStorage.getItem("likeCount") || <%=flike_count%>;

    updateLikeUI(isLike, likeCount);

    function updateLikeUI(isLike, likeCount) {
        const heartImg = document.getElementById('heart');
        const likeCountSpan = document.getElementById('like');

        heartImg.setAttribute('src', isLike ? './star_on.png' : './star_off.png');
        heartImg.setAttribute('title', isLike ? 'on' : 'off');
        likeCountSpan.innerHTML = likeCount;
    }

    function like() {
        const isLike = localStorage.getItem("isLike") === "true";
        const likeCount = parseInt(localStorage.getItem("likeCount")) || <%=flike_count%>;

        // 좋아요 상태 토글
        const newIsLike = !isLike;
        const newLikeCount = newIsLike ? likeCount + 1 : likeCount - 1;

        // 로컬 스토리지에 저장
        localStorage.setItem("isLike", newIsLike);
        localStorage.setItem("likeCount", newLikeCount);

        // UI 업데이트
        updateLikeUI(newIsLike, newLikeCount);

        // 서버로 좋아요 정보 전송
        const xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
                // 서버 응답 처리
            }
        }

        xhr.open('get', 'starAction.jsp?freeID=<%=rs.getInt("freeID")%>', true);
        xhr.send();
    }

    // 클릭 이벤트 등록
    document.getElementById('heart').addEventListener('click', like);
});
</script>
	<hr class="contenthr">
	</div>
<%-- 	<div class="star">
	<script>
function like(){
		const isHeart = document.querySelector("img[title=on]");
		if(isHeart){
			document.getElementById('heart').setAttribute('src','./star_off.png');
			document.getElementById('heart').setAttribute('title','off');
		}else{
			document.getElementById('heart').setAttribute('src','./star_on.png');
			document.getElementById('heart').setAttribute('title','on');
		}
		//사진경로는 본인에게 맞게 수정이 필요합니다.
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(){
			if(xhr.readyState == XMLHttpRequest.DONE && xhr.status ==200){
				document.getElementById('like').innerHTML = xhr.responseText;
			}	
		}
		xhr.open('get','starAction.jsp?freeID=<%=freeID%>',true);
		xhr.send();
	}
</script>
		<%
		if(isLike){
		%><img id="heart" src="./star_on.png" alt="좋아요" onclick="like()"><span id="like" class="heartspan"><%=flike_count %></span>
			<%}
		else
		{%><img id="heart" src="./star_off.png" alt="좋아요" onclick="like()"><span id="like" class="heartspan"><%=flike_count %></span>
		
	</div>
	<hr class="contenthr">

	</div>

		<%}} %>	 --%>
		<%} %>
			</nav>
	
	

</body>
</html>