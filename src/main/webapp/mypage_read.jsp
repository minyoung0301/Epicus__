<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="notification.Notifications" %>
  <%@ page import="notification.NotificationDAO" %>
  <%@ page import="java.util.ArrayList, java.util.List" %>
 <%@ page import="java.sql.*" %>
 <%@ page import="test.free" %>
<%@ page import="javax.servlet.ServletException" %>
<%@page import="read.recontent" %>
<%@ page import="javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse" %> 
<jsp:include page="mypage_readDB.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href ="./css/mypage.css">
<link rel ="stylesheet" href ="./css/mypage_read.css">
<script src="menu.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
</head>
<body>
	<header class = "menubar">
<%
List<free> posts = new ArrayList<>();
	//List<recontent> posts = new ArrayList<>();
	//로그인이 된 사람들은 로그인정보를 담을 수 있도록한다.
	String userID = null;
	//만약에 현재 세션이 존재한다면
	if (session.getAttribute("userID") != null) {
		//그 아이디값을 받아서 userID인스턴스로 관리할 수 있도록 한다.
		userID = (String) session.getAttribute("userID");
	}

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    //String image_path = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/epicus", "root", "root");

        String sql = "SELECT free.* FROM free INNER JOIN readcontent ON free.freeID = readcontent.re_freeID where readcontent.re_userID=?";
        stmt = conn.prepareStatement(sql);
      
        stmt.setString(1, userID);
        rs = stmt.executeQuery();

        while (rs.next()) {
        	
			//int re_freeID = rs.getInt("re_freeID");
        	//int readID = rs.getInt("readID");
        	int freeID = rs.getInt("freeID");
        	//int re_number = rs.getInt("re_number");
        	
        	//String re_userID=rs.getString("re_userID");
        	 String fTitle = rs.getString("fTitle");
             String image_path = rs.getString("image_path");
         	
         	String ruserID = rs.getString("userID");
         	String fInto = rs.getString("fInto");
     		//String fDate= rs.getString("fDate");
         	int fAvailable = rs.getInt("fAvailable");
         	int fopen = rs.getInt("fopen");
     		Timestamp fDate =rs.getTimestamp("fDate");
         	int flike_count = rs.getInt("flike_count");
         	free post = new free(freeID,image_path,fTitle,userID,fInto,fDate,fAvailable,fopen,flike_count);
          	posts.add(post);
   
        	
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) {
            rs.close();
        }
        if (stmt != null) {
            stmt.close();
        }
        if (conn != null) {
            conn.close();
        }
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
			<h1 class="titleh1">최근 본 작품</h1>
			
			
		
		</nav>
	<section class="menubtn">
		
		<div class="mymenu">
			<ul class="myul">
				<li class="myli"><a href ="mypage_mycontent.jsp" >내 작품 목록</a></li>
				<li class="myli"><a href ="mypage_read.jsp" >최근 본 작품</a></li>
				<li class="myli"><a href ="mypage_bookmark.jsp">즐겨찾기</a></li>
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
					for(free post: posts){
						/* int readID = post.getReadID();
						
						int re_number = post.getRe_number(); */
						String ruserID = post.getUserID();
						String fTitle = post.getfTitle();
					    String fInto = post.getfInto();
					    String image_path = post.getImage_path();
					    int freeID = post.getFreeID();
		                //int roundID = post.getRoundID();
					
					%>
		<div class="readdiv">
			<div class="imagediv"><img class="cover" src="rabbit.png"></div>
			<div class="readtitle"><%= fTitle %></div>
			<div class="readInto"><%=fInto %></div>
			<div class="author"><%=ruserID %></div>
			<!-- <div class="date">fDate</div> -->
			<%-- <div class="roundID"><%=roundID %></div>
			<div class="next"><a class="contenta" href="view3.jsp?freeID=<%=readID%>&number=<%=readnumber%>">-> <%=readroundID %>화.<%=readsubtitle %> 이어보기</a></div> --%>
			<div class="delete"><button class="deletebtn" onclick="location.href='readdeleteAction.jsp?freeID=<%=freeID%>'"><i class="fa-solid fa-xmark fa-2xl" style="color: #324b4c;"></i></button></div>
		</div>
		<%} %>
		
		<hr class="readhr">
		
	</div>
	</section>
		<footer class="mypagefooter">
		
	</footer>
</body>
</html>
