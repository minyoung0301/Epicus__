<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.text.SimpleDateFormat" %>   
 <%@ page import="java.sql.*" %>
<%@ page import="test.free" %>
<%@ page import="notification.Notifications" %>
  <%@ page import="notification.NotificationDAO" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList, java.util.List" %>


  <%
  SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
%>    




<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href ="./css/board.css">
<script src="menu.js"></script>
</head>
<body style ="overflow-x:hidden;">
	<%
    String userID = null;
    List<free> posts = new ArrayList<>();
    // 만약에 현재 세션이 존재한다면
    if (session.getAttribute("userID") != null) {
        // 그 아이디값을 받아서 userID 인스턴스로 관리할 수 있도록 합니다.
        userID = (String) session.getAttribute("userID");
    }
    String searchField = request.getParameter("searchField");
    String searchText = request.getParameter("searchText");
    // 로그인이 된 사람들은 로그인 정보를 담을 수 있도록 합니다.

    ArrayList<String> searchResults = new ArrayList<>();

    if (searchField != null && searchText != null && !searchField.isEmpty() && !searchText.isEmpty()) {
        // 데이터베이스 연결 및 검색 쿼리 수행
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/epicus", "root", "root");
            stmt = conn.createStatement();
            String sql = "SELECT * FROM free WHERE " + searchField + " LIKE '%" + searchText + "%'";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                // 검색 결과 표시
                String imagePathFromDB = rs.getString("image_path"); // 이미지 경로 가져오기

                // 이미지 경로를 웹 애플리케이션의 상대 경로로 변환
                String relativeImagePath = "/images/" + imagePathFromDB; // 상대 경로 설정
                String realImagePath = request.getContextPath() + relativeImagePath; // 실제 경로 생성
				Timestamp fDate = rs.getTimestamp("fDate");
                int freeID = rs.getInt("freeID");
                String fTitle = rs.getString("fTitle");
                String fInto = rs.getString("fInto");
                String fuserID = rs.getString("userID");
                free post = new free(freeID, imagePathFromDB, fTitle, fuserID, fInto, null, 0, 0, 0); // fDate, fAvailable, fopen, flike_count 값은 임의로 지정
                posts.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 리소스 해제
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
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
	<nav class="boardnav">
		<h1 class="boardh1">게시판 > 전체</h1>

		<span class="arraybtn">
<!-- 		<input type="button" class= "pbtn" value="인기순"> -->
<!-- 		<input type="button" class="lbtn" value="최신순"> -->
		</span>
		
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

		for(free post: posts){
			int freeID = post.getFreeID();
            String fTitle = post.getfTitle();
            String fInto = post.getfInto();
            String realImagePath = post.getImage_path();
           String fuserID = post.getUserID();
 /*           Timestamp fDate = post.getfDate();
     	  String formattedDate = dateFormat.format(fDate); */
	    
		%>
		<div class="boarduldiv">
	<div class="image"><a href="showcontent.jsp?freeID=<%=post.getFreeID()%>"><img class="contentimg" src="rabbit.png"></a></div>
	<div class="title"><img class="talk" src="Talk2.png"><a class="titlea" href="showcontent.jsp?freeID=<%= post.getFreeID() %>"><%=fTitle %></a></div>
	<div class="user"><%=post.getUserID() %></div>
	<div class="Into"><img class="talk2" src="Talk.png"><a class="fIntoa" href="showcontent.jsp?freeID=<%= post.getFreeID()%>"><%=post.getfInto()%></a></div>
	<%-- <div class="date"><%=formattedDate%></div> --%>
	<hr class="contenthr">
	</div>
	<%
	    }
	%>
			</nav>
	

</body>
</html>