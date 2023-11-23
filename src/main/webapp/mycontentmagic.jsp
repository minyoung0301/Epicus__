<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="magic.magic" %>
<%@ page import="notification.Notifications" %>
  <%@ page import="notification.NotificationDAO" %>
  <%@ page import="java.util.ArrayList, java.util.List" %>

 <%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href ="./css/mycontent.css">
<link rel ="stylesheet" href ="./css/mycontentmagic.css">
<script src="menu.js"></script>
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
<title>내 작품</title>

</head>
<body style="overflow-x: hidden;">

<%
	List<magic> posts = new ArrayList<>();
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

	        String sql = "SELECT magicID,mTitle,mInto,mDate,mAvailable, mopen, image_path, mlike_count FROM magic WHERE userID = ?";
	        stmt = conn.prepareStatement(sql);
	      
	        stmt.setString(1, userID);
	        rs = stmt.executeQuery();

	        while (rs.next()) {
	        	
	        	// DB에서 이미지 경로를 가져옴
	        	String imagePathFromDB = rs.getString("image_path"); // 이미지 경로 가져오기

	        	// 이미지 경로를 웹 애플리케이션의 상대 경로로 변환
	        	String relativeImagePath = "/images/" + imagePathFromDB; // 상대 경로 설정
	        	String realImagePath = request.getContextPath() + relativeImagePath; // 실제 경로 생성
	        	


	        	int magicID = rs.getInt("magicID");
	        	String mTitle = rs.getString("mTitle");
	        	String image_path = rs.getString("image_path");
	        	//String userID = rs.getString("userID");
	        	String mInto = rs.getString("mInto");
	        	Timestamp mDate =rs.getTimestamp("mDate");
				//String fDate= rs.getString("fDate");
	        	int mAvailable = rs.getInt("mAvailable");
	        	int mopen = rs.getInt("mopen");
	        	int mlike_count = rs.getInt("mlike_count");
	        	magic post = new magic(magicID,image_path,mTitle,userID,mInto,mDate,mAvailable,mopen,mlike_count);
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
			<table id="notificationsTable" border="1" style="display: none; position: fixed; top: 50px; right: 10px;">
 <tr>
     <th></th>
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
	
		<nav class="mycontentnav">
		<div class="mycontentdiv">내작품 > 마법사</div>
	 <hr class="mycontenthr">
	
		
	</nav>


	<section class="contentsection">
	<span class="freebtn"><img src="pen.png" class="freepen"><input type="button" class="free" value="자유" onclick="location.href='mycontent.jsp'"></span>
		<span class="wizardbtn"><img src="magic-tool.png" class="magic"><input type="button" class="wizard" value="마법사" onclick="location.href='mycontentmagic.jsp'"></span>
		<div class="searchdiv">
		<td><select class="form-control" name="searchField">
								<option value="0">선택</option>
								<option value="fTitle">제목</option>
								<option value="userID">작성자</option>
						</select></td>
		<input type="text" class="searchbox" name="searchText">
		
		<button type="submit" class="searchbtn"><i class="fa-solid fa-magnifying-glass fa-xl" style="color: #324b4c;"></i></button>
		
		</div>
		</section>
		<hr class="contenthr2">
		<section class="contentsection2">
		<%
					for(magic post: posts){
						int magicID = post.getMagicID();
		                String mTitle = post.getmTitle();
		                String mInto = post.getmInto();
		                String realImagePath = post.getImage_path();
		               
					
					%>
	<ul class="ullist">
	
		<li class="content1">
		<div class="image"><a href="mycontentlist2.jsp?magicID=<%= magicID %>"><img src="rabbit.png"></a></div>
		<div class="contentdiv"><%= mTitle %></div>
		</li>
		
	</ul>
	<%
			}
		%>
		<div class="btndiv">
		
		<span class="createbtn"><input type="button" class="pluscreate" value="+작품생성" onclick="location.href='magiccreatecontent.jsp'"></span>
		
		<span class="deletebtn"><input type="button" class="delete" value="작품삭제"></span>
		
		<span class="characterbtn"><input type="button" class="charactercreate" value="+캐릭터생성" onclick="location.href='characterlist.jsp'"></span>
		</div>
		</section>
		
		<footer class="contentfooter">
		
		
	
		
		</footer>
	
	
	

</body>
</html>