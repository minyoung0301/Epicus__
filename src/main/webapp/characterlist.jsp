<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="magic.characters" %>
<%@ page import="java.util.ArrayList, java.util.List" %>
<%@ page import="notification.Notifications" %>
  <%@ page import="notification.NotificationDAO" %>
 <%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel ="stylesheet" href ="./css/menu.css">
<!-- <link rel ="stylesheet" href ="./css/mycontent.css"> -->
<link rel ="stylesheet" href ="./css/characterlist.css">
<script src="menu.js"></script>
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
<title>내 작품</title>

</head>
<body style="overflow-x: hidden;">


<%
	
	List<characters> posts = new ArrayList<>();
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

	        String sql = "SELECT id,userID,image_path,explanationInput,name,placeInput,ageInput,residenceInput,genderInput,jobInput,birthdayInput,nicknameInput,personalityInput,appearanceInput,talentInput, advantageInput, roleInput,hobbyInput,etcInput FROM characters WHERE userID = ?";
	        stmt = conn.prepareStatement(sql);
	      
	        stmt.setString(1, userID);
	        rs = stmt.executeQuery();

	        while (rs.next()) {
	        	
	        	// DB에서 이미지 경로를 가져옴
	        	String imagePathFromDB = rs.getString("image_path"); // 이미지 경로 가져오기

	        	// 이미지 경로를 웹 애플리케이션의 상대 경로로 변환
	        	
	        	int id = rs.getInt("id");
	        	String explanationInput = rs.getString("explanationInput");
	        	String name = rs.getString("name");
	        	String placeInput = rs.getString("placeInput");
	        	String ageInput = rs.getString("ageInput");
	        	String residenceInput = rs.getString("residenceInput");
	        	String genderInput = rs.getString("genderInput");
	        	String jobInput = rs.getString("jobInput");
	        	String birthdayInput = rs.getString("birthdayInput");
	        	String nicknameInput = rs.getString("nicknameInput");
	        	String personalityInput = rs.getString("personalityInput");
	        	String appearanceInput = rs.getString("appearanceInput");
	        	String talentInput = rs.getString("talentInput");
	        	String advantageInput = rs.getString("advantageInput");
	        	String roleInput = rs.getString("roleInput");
	        	String hobbyInput = rs.getString("hobbyInput");
	        	String etcInput = rs.getString("etcInput");

				String image_path = rs.getString("image_path");

	        	
	   
	        	characters post = new characters(id,image_path,userID,explanationInput,name,placeInput,ageInput,
	                    residenceInput,genderInput,jobInput,birthdayInput,nicknameInput,
	                    personalityInput,appearanceInput,talentInput, advantageInput, roleInput,
	                    hobbyInput,etcInput);
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

	
	
	</header>
	
	<nav class="characternav">
		<div class="characterdiv">인물 목록</div>
		<span class="btnspan"><input type="button" class="createcharacter" value="인물추가" onclick="location.href='createcharacter.jsp'"></span>
	 <hr class="characterhr">
	
		
	</nav>
	<section class="charactersec">
	<%
		for(characters post : posts){
			 
        	String imagePathFromDB =  post.getImage_path(); // 이미지 경로 가져오기
        	/*  String relativeImagePath = imagePathFromDB.replace("C:/Users/sms07/eclipse-workspace/Epicus__/src/main/webapp", ""); */
        	String relativeImagePath = imagePathFromDB.replace("C:/Users/sms07/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/Epicus__//image", "");
			String name = post.getName();
			String explanationInput = post.getExplanationInput();
		
	%>
		<div class="listdiv">
			<div class="coverimg"><img src="<%=request.getContextPath()%><%=relativeImagePath %>"></div>
			<div class="charactername"><%=name %></div>
			<div class="explanation"><%=explanationInput %></div>
			<hr class="characterhr2">
		</div>
		<%} %>
		<input type="button" class="before" value="< 이전" onclick="location.href='mycontentmagic.jsp'">
	</section>
	
	
	

</body>
</html>