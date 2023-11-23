<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="magic.magic" %>
 <%@ page import="java.sql.*" %>
<%@ page import="magic.magiccontent" %>
<%@ page import="java.util.ArrayList, java.util.List" %>

<%@ page import="notification.Notifications" %>
  <%@ page import="notification.NotificationDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href="./css/mycontentlist.css">
<script src="menu.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>


<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
</head>
<body>


<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");
	String userID = null;
	if (session.getAttribute("userID") != null)
	{
	    userID = (String)session.getAttribute("userID");
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
			if (userID == null) {	
		%>
		<li class="menuli"><a href="login.jsp">로그인</a></li>
		<li class="menuli"><a href="join.jsp">회원가입</a></li>
		<%
		} else{
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

	

	<nav class="mycontent">
	<h1 class="mycontenth1">내 작품</h1>
	
	
	
	</nav>
	<%
	List<magic> posts = new ArrayList<>();
	List<magiccontent> posts2 = new ArrayList<>();
	int magicID=0;
	if(request.getParameter("magicID") !=null){
		magicID = Integer.parseInt(request.getParameter("magicID"));
		
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
	    String sql1 = "SELECT image_path, mTitle, mInto, mDate, mAvailable, mopen, mlike_count FROM magic WHERE userID = ? and magicID=?";
	    stmt1 = conn.prepareStatement(sql1);
	    stmt1.setString(1, userID);
	    stmt1.setInt(2,magicID);
	    
	   

	    rs = stmt1.executeQuery();

	    while (rs.next()) {
	     	//int freeID = rs.getInt("freeID");
        	String mTitle = rs.getString("mTitle");
        	String image_path = rs.getString("image_path");
        	
        	//String userID = rs.getString("userID");
        	String mInto = rs.getString("mInto");
			//String fDate= rs.getString("fDate");
        	int mAvailable = rs.getInt("mAvailable");
        	int mopen = rs.getInt("mopen");
        	int mlike_count = rs.getInt("mlike_count");
			Timestamp mDate =rs.getTimestamp("mDate");
        	
        	magic post = new magic(magicID,image_path,mTitle,userID,mInto,mDate,mAvailable,mopen,mlike_count);
         	posts.add(post);
	    }

	    // 두 번째 SQL 문장
	    String sql2 = "SELECT roundID,number,genres,genre_opinion,keyword,keyword_opinion,time,space,time_opinion,space_opinion,natural_opinion,social_opinion,psychological_opinion,situational_opinion,other_opinion,internal_opinion,external_opinion,track_opinion,sub_opinion,story_opinion,main_opinion,like_count,userID,magicDate,Available,magiccheck,hit,character_id FROM magiccontent WHERE magicID=?";
	    stmt2 = conn.prepareStatement(sql2);
	    
	    stmt2.setInt(1, magicID);
	    

	    rs2 = stmt2.executeQuery();

	    while (rs2.next()) {
	     	//int magicID = rs2.getInt("magicID");
        	String genres = rs2.getString("genres");
        	String genre_opinion = rs2.getString("genre_opinion");
        	String keyword = rs2.getString("keyword");
        	String keyword_opinion = rs2.getString("keyword_opinion");
        	String time = rs2.getString("time");
        	String space = rs2.getString("space");
        	String time_opinion = rs2.getString("time_opinion");
        	String space_opinion = rs2.getString("space_opinion");
        	String natural_opinion = rs2.getString("natural_opinion");
        	String social_opinion = rs2.getString("social_opinion");
        	String psychological_opinion = rs2.getString("psychological_opinion");
        	String situational_opinion = rs2.getString("situational_opinion");
        	String other_opinion = rs2.getString("other_opinion");
        
        	String internal_opinion = rs2.getString("internal_opinion");
        	String external_opinion = rs2.getString("external_opinion");
        	String track_opinion = rs2.getString("track_opinion");
        	String sub_opinion = rs2.getString("sub_opinion");
        	String story_opinion = rs2.getString("story_opinion");
        	String main_opinion = rs2.getString("main_opinion");
        	int character_id = rs2.getInt("character_id");
        	int magiccheck = rs2.getInt("magiccheck");
        	Timestamp magicDate =rs2.getTimestamp("magicDate");
        	int available = rs2.getInt("available");
        	int roundID = rs2.getInt("roundID");
       		int number = rs2.getInt("number");
        	int hit = rs2.getInt("hit");
        	int like_count = rs2.getInt("like_count");
        	//String image_path = rs2.getString("image_path");
        	magiccontent post2 = new magiccontent(magicID,roundID,number,genres,genre_opinion,keyword,keyword_opinion,time,space,time_opinion,space_opinion,natural_opinion,social_opinion,psychological_opinion,situational_opinion,other_opinion,
        			internal_opinion,external_opinion,track_opinion,sub_opinion,
        			story_opinion,main_opinion,userID,like_count,magicDate,available,magiccheck,hit,
        			character_id);
            
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
	<section class="mycontentsection">
		<div class="bar">
		<span class="ibtn">
		<i class="fas fa-regular fa-angle-left" style="color: #ffffff;"></i>
<!-- 		<i class="fa-light fa-angle-left" style="color: #ffffff;" onclick="location.href='mycontent.jsp'"></i> -->
		</span>
		<%
					for(magic post: posts){
						//int magicID = post.getMagicID();
		                String mTitle = post.getmTitle();
		                String mInto = post.getmInto();
		                String realImagePath = post.getImage_path();
		               
					
					%>
		<div class="title"><%=mTitle %></div>
		</div>

	
		<div class="contenttitle"><img src="free.png" style="width :200px; height : 200px; background-color : white;">
		<div class="v"></div>
		<span class="titlespan2"><%=mTitle %></span>
		<span class="Intospan"><%=mInto %></span>
		
		<span class="btnspan"><input type="button" class="revisebtn" value="퇴고하기" onclick="location.href='finishboard2.jsp?userID=<%=userID%>&magicID=<%=magicID%>'"></span>
		
		<span class="plusspan"><input type="button" class="pluswrite" value="+ 글쓰기" onclick="location.href='magiccontent.jsp?magicID=<%=magicID%>'"></span>
		<button type="button" class="closespan"  onclick="location.href='closeAction.jsp?magicID=<%=magicID %>'"><img src="lock.png"></button>
		</div>
		
		
		<%} %>
		

	
	</section>
	
	
	<nav class="round">
	
	 <script type="text/javascript">
  function showPopup() { window.open("popup.jsp?magicID=<%=magicID%>", "a", "width=200, height=300, left=500, top=500"); }
  </script>
  <div class="l3">
  <div class="l">
	<div class="l2">
	</div>
  
  </div>
  </div>
 
  	<div class="bardiv">
  	 <span class="circle"></span>
  	 <span class="circle2"></span>
		<span class="roundspan">작품회차() |</span>
		<div class="option">
		<span class="first"><input type="button" class="firstbutton" value="최신순">|</span>
		<span class="new"><input type="button" class="newbutton" value="1화부터"></span>
		</div>
	</div>
	</nav>

		
		
	<section class="list">

		<%	
		for(magiccontent post: posts2){
			//int magicID = post.getMagicID();
            int number = post.getNumber();
            //String realImagePath = post.getImage_path();
           	String sub_opinion  = post.getSub_opinion();
           	int roundID = post.getRoundID();
           	String story_opinion = post.getStory_opinion();
		%>
	
		<li class="listli">
			<div class="titlediv">
			<img src="paper.png">
			<span class="roundspan2"><%=roundID%>화.</span>
			<span class="titlespan"><strong><a class ="viewa" href="view4.jsp?magicID=<%=magicID%>&number=<%=number%>"><%=sub_opinion%></a></strong></span>
			<span class="infospan"><a class="suma" href="view2.jsp?magicID=<%=magicID%>&number=<%=number%>&roundID=<%=roundID%>"><%=story_opinion %></a></span>
			<input type="button" class="downloada" value ="word파일다운" onclick="location.href='http://localhost:8887/testtest/word.jsp?magicID=<%=magicID%>&number=<%=number%>'">
			<hr class="listhr">
			</div>
			
			
			
			
		</li>
		
			
		
				<%
			}
		%>
	<div class="pagediv">
		
	</div>
	</section>
		
		<footer>
	
		</footer>
	

</body>
</html>