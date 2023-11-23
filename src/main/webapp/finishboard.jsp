<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>

<%@ page import="test.free" %>

<%@ page import="freetest.freecontent" %>

 <%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse" %> 
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
<link rel ="stylesheet" href ="./css/finishboard.css">
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>




</head>

<body>
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
	

	int freeID = 0;
	//만약에 매개변수로 넘어온 bbsID라는 매개변수가 존재 할 시 
	//(이 매개변수는 bbs.jsp에서 view로 이동하는 a태그에서 넘겨준 값이다.)
	if (request.getParameter("freeID") != null) {
//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다. 다음과 같이 정수형으로 변환시켜준다.
freeID = Integer.parseInt(request.getParameter("freeID"));
	}
	int roundID=0;
	if (request.getParameter("roundID") != null) {
//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다. 다음과 같이 정수형으로 변환시켜준다.
roundID = Integer.parseInt(request.getParameter("roundID"));
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
	    String sql1 = "SELECT  image_path,fTitle,fInto,fDate,fAvailable, fopen,flike_count FROM free WHERE userID = ? and freeID=?";
	    stmt1 = conn.prepareStatement(sql1);
	    stmt1.setString(1, userID);
	    stmt1.setInt(2,freeID);
	   

	    rs = stmt1.executeQuery();

	    while (rs.next()) {
	     	//int freeID = rs.getInt("freeID");
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
	    String sql2 = "SELECT roundID,number,subtitle,summary,story,like_count,freeDate,Available,freecheck,hit,image_path FROM freecontent WHERE userID = ? and freeID=?";
	    stmt2 = conn.prepareStatement(sql2);
	    stmt2.setString(1, userID);
	    stmt2.setInt(2, freeID);
	 

	    rs2 = stmt2.executeQuery();

	    while (rs2.next()) {
	    	//int roundID = rs2.getInt("roundID");
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
		<%
					for(free post: posts){
						//int freeID = post.getFreeID();
		                String fTitle = post.getfTitle();
		                String fInto = post.getfInto();
		                String image_path = post.getImage_path();
		               
					
					%>
	<nav class="titlenav">
		<span class="number"><%=fTitle%> : </span><span class="freeInto"><%=fInto %></span>
	
		
		<hr class="titlehr">
	
	
	
		
	</nav>
	<%} %>
	
	<script type="text/javascript">
  function showPopup() { 
	  window.open('popup2.jsp?freeID=<%=freeID%>', "a", "width=600, height=200, left=650, top=400"); 
		window.close();	 
  }
  </script>
		<section class="allsec">
		<div class="listbtn"><input type="button" class="list" value="목록으로" onclick="location.href='mycontentlist.jsp?freeID=<%=freeID%>'"><span class="downspan">
		<input type="button" class="alldownload" value="전체 word다운로드" onclick="location.href='http://localhost:8887/Epicus__/word2.jsp?freeID=<%=freeID%>'"><input type="button" class="openbtn" value="작품 공개" onclick="showPopup();"></span></div>
			
		
		<%
					for(freecontent post2: posts2){
					    String summary = post2.getSummary();
				        String subtitle = post2.getSubtitle();
				        int number = post2.getNumber();
					
					%>

		<div class="all" style="overflow:auto;">
	
		<div class="subtitlediv"><%=subtitle %></div>
		<div class="summarydiv"><%=summary %></div>
		<div class="downloaddiv"><input type="button" class="downbtn" value="word다운" onclick="location.href='http://localhost:8887/Epicus__/word.jsp?freeID=<%=freeID%>&roundID=<%=roundID%>&number=<%=number%>'"></div>
		</div>
		<%
			}
	%>
	</section>
	

</body>
</html>