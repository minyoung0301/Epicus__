<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="test.free" %>
<%@ page import="star.bookmark" %>
<%@ page import="freetest.freecontent" %>
<%@ page import="java.sql.*" %>   
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
<link rel ="stylesheet" href ="./css/mypage_bookmark.css">
<script src="menu.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
</head>
<body>
	<header class = "menubar">
<%
	Boolean isLike=false;
	List<free> posts = new ArrayList<>();
	//로그인이 된 사람들은 로그인정보를 담을 수 있도록한다.
	String userID = null;
	//만약에 현재 세션이 존재한다면
	if (session.getAttribute("userID") != null) {
		//그 아이디값을 받아서 userID인스턴스로 관리할 수 있도록 한다.
		userID = (String) session.getAttribute("userID");
	}
	Connection conn = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;


	try {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/epicus", "root", "root");

	    // 첫 번째 SQL 문장

	    String sql= "SELECT free.* FROM free INNER JOIN star ON free.freeID = star.s_freeID where star.s_userID=?";

	    preparedStatement = conn.prepareStatement(sql);
        preparedStatement.setString(1, userID);

        resultSet = preparedStatement.executeQuery();

	    while (resultSet.next()) {
	    	 int freeID = resultSet.getInt("freeID");
             String fTitle = resultSet.getString("fTitle");
             String image_path = resultSet.getString("image_path");
         	
         	//String userID = rs.getString("userID");
         	String fInto = resultSet.getString("fInto");
     		//String fDate= rs.getString("fDate");
         	int fAvailable = resultSet.getInt("fAvailable");
         	int fopen = resultSet.getInt("fopen");
     		Timestamp fDate =resultSet.getTimestamp("fDate");
         	int flike_count = resultSet.getInt("flike_count");
         	free post = new free(freeID,image_path,fTitle,userID,fInto,fDate,fAvailable,fopen,flike_count);
          	posts.add(post);
	    	
	    }
		
	    // 두 번째 SQL 문장
	   
	    
	} catch (Exception e) {
	    e.printStackTrace();
	} finally {
	    // 리소스 해제
		if (resultSet != null) resultSet.close();
        if (preparedStatement != null) preparedStatement.close();
        if (conn != null) conn.close();

	}
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
			<h1 class="titleh1">즐겨찾기</h1>
			
			
		
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
		<!-- <i class="fa-solid fa-circle-user fa-xl" style="color: #324b4c;"></i> -->
			
		</div>
		<div class="d">
	
		</div>

	<div class="mypagediv">
	<% 
	for(free post: posts){
		
	int freeID = post.getFreeID();
    String fTitle = post.getfTitle();
    String fInto = post.getfInto();
    int flike_count = post.getFlike_count();
    String image_path = post.getImage_path();
    %>
	 <div class="stardiv">
	 	<div class="cover"><img class="coverimg" src="rabbit.png"></div>
	 	<div class="fTitle"><%=fTitle %></div>
	 	<div class="fInto"><%=fInto %></div>
	 	<div class="profile1"><img class="pimg" src="profile.png"></div>
	 	<div class="author1"><%=userID %></div>
	 	<div class="star">
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
		xhr.open('get','mstarAction.jsp?freeID=<%=freeID%>',true);
		xhr.send();
	}
</script>
		<%
		if(isLike){
		%><img id="heart" src="./star_on.png" alt="좋아요" onclick="like()">
			<%}
		else
		{%><img id="heart" src="./star_off.png" alt="좋아요" onclick="like()">
		
	</div>
	 <hr class="starhr">
	 </div>
	 
		<%}} %>
	</div>
	</section>
		<footer class="mypagefooter">
		
	</footer>
</body>
</html>