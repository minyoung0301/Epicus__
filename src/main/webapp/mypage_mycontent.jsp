<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="notification.Notifications" %>
  <%@ page import="notification.NotificationDAO" %>
  <%@ page import="java.util.ArrayList, java.util.List" %>
    <%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="test.free" %>
<%@ page import="freetest.freecontent" %>
 <%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>

<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href ="./css/mypage.css">
<link rel ="stylesheet" href ="./css/mypage_mycontent.css">
<script src="menu.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
</head>
<body>
	<header class = "menubar">
<%
List<free> posts = new ArrayList<>();
List<freecontent> posts2 = new ArrayList<>();
	//로그인이 된 사람들은 로그인정보를 담을 수 있도록한다.
	String userID = null;
	//만약에 현재 세션이 존재한다면
	if (session.getAttribute("userID") != null) {
		//그 아이디값을 받아서 userID인스턴스로 관리할 수 있도록 한다.
		userID = (String) session.getAttribute("userID");
	}

	Connection conn = null;
	PreparedStatement stmt1 = null;
	PreparedStatement stmt2 = null;
	ResultSet rs = null;
	ResultSet rs2 = null;


	try {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/epicus", "root", "root");

	    // 첫 번째 SQL 문장
	    String sql1 = "SELECT freeID,image_path,fTitle,fInto,fDate,fAvailable, fopen,flike_count FROM free WHERE userID = ?";
	    stmt1 = conn.prepareStatement(sql1);
	    stmt1.setString(1, userID);
	    
	   

	    rs = stmt1.executeQuery();

	    while (rs.next()) {
	     	int freeID = rs.getInt("freeID");
	    	String fTitle = rs.getString("fTitle");
	    	String image_path = rs.getString("image_path");
	    	
	    	//String userID = rs.getString("userID");
	    	String fInto = rs.getString("fInto");
			//String fDate= rs.getString("fDate");
	    	int fAvailable = rs.getInt("fAvailable");
	    	int fopen = rs.getInt("fopen");
	    	int flike_count = rs.getInt("flike_count");
			Timestamp fDate =rs.getTimestamp("fDate");
	    	
	    	free post = new free(freeID,image_path,fTitle,userID,fInto,fDate,fAvailable,fopen,flike_count);
	     	posts.add(post);
	    }

	    // 두 번째 SQL 문장
	    String sql2 = "SELECT freeID,roundID,number,subtitle,summary,story,like_count,freeDate,Available,freecheck,hit,image_path FROM freecontent WHERE userID=?";
	    stmt2 = conn.prepareStatement(sql2);
	    
	    stmt2.setString(1, userID);
	    

	    rs2 = stmt2.executeQuery();

	    while (rs2.next()) {
	    	int freeID= rs2.getInt("freeID");
	    	int roundID = rs2.getInt("roundID");
	    	String subtitle = rs2.getString("subtitle");
	    	String summary = rs2.getString("summary");
	    	String story = rs2.getString("story");
	    	Timestamp freeDate =rs2.getTimestamp("freeDate");
	    	int available = rs2.getInt("available");
	    	int freecheck = rs2.getInt("freecheck");
	   		int number = rs2.getInt("number");
	    	int hit = rs2.getInt("hit");
	    	int like_count = rs2.getInt("like_count");
	    	String image_path = rs2.getString("image_path");
	    	freecontent post2 = new freecontent(freeID,roundID,number,subtitle,summary,story,like_count,userID,freeDate,available,freecheck,hit,image_path);
	        
	    	posts2.add(post2);
	    }
	} catch (Exception e) {
	    e.printStackTrace();
	} finally {
	    // 리소스 해제
	    if (rs != null) {
	        rs.close();
	    }
	    if (rs2 != null) {
	        rs2.close();
	    }
	    if (stmt1 != null) {
	        stmt1.close();
	    }
	    if (stmt2 != null) {
	        stmt2.close();
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
			<h1 class="titleh1">내 작품 목록</h1>
			
			
		
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
	<!-- <div class="tab_menu">
    <ul class="list">
      <li class="is_on">
        <a href="#tab1" class="btn">Tab Button1</a>
        <div id="tab1" class="cont">Tab Content1</div>
      </li>
      <li>
        <a href="#tab2" class="btn">Tab Button2</a>
        <div id="tab2" class="cont">Tab Content2</div>
      </li>
      
    </ul>
  </div> -->
  <script>
  const tabList = document.querySelectorAll('.tab_menu .list li');
  for(var i = 0; i < tabList.length; i++){
    tabList[i].querySelector('.btn').addEventListener('click', function(e){
      e.preventDefault();
      for(var j = 0; j < tabList.length; j++){
        tabList[j].classList.remove('is_on');
      }
      this.parentNode.classList.add('is_on');
    });
  }
  </script>
		<%
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
		for (free post : posts) {
		    int freeID = post.getFreeID();
		    String fTitle = post.getfTitle();
		    String fInto = post.getfInto();
		    Timestamp fDate = post.getfDate();
		    String formattedDate = (fDate != null) ? dateFormat.format(fDate) : "날짜 없음";
		    String image_path = post.getImage_path();
					/* for(freecontent post2: posts2){
						int number = post2.getNumber(); */
						
					%>
		<div class="mycontent">
		<div class="image">
		<img class="image" src="rabbit.png">
		</div>
	
		<div class="Title"><a class="lista" href="mycontentlist.jsp?freeID=<%=freeID%>"><%=fTitle %></a></div>
		<div class="Into"><a class="lista"  href="mycontentlist.jsp?freeID=<%=freeID%>"><%=fInto %></a></div>
		
		<%-- <div class="date"><%=formattedDate%></div> --%>
		<div class="download"><button class="downloadbtn"  onclick="location.href='http://localhost:8887/Epicus__/word.jsp?freeID=<%=freeID%>'"><i class="fas-solid fas-arrow-down-to-line" style="color: #ffffff;"></i>다운로드</button></div>
		<div class="lock"><button class="lockbtn" onclick="location.href='closeAction.jsp?freeID=<%=freeID%>'"><i class="fa-solid fa-lock" style="color: #324b4c;"></i>비공개</button></div>
		<div class="lock"><button class="deletebtn"><i class="fa-solid fa-trash" style="color: #324b4c;"></i>삭제</button></div>
		
		
			
	</div>
		<hr class="mycontenthr">
	<%}%>	
		<%-- <%} %> --%>
	</div>
	</section>

		<footer class="mypagefooter">
		
	</footer>
</body>
</html>