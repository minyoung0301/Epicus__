<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="test.free" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="freetest.freecontent" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse" %>
<%@ page import="java.io.*" %>
<%@ page import="notification.Notifications" %>
  <%@ page import="notification.NotificationDAO" %>
  <%@ page import="java.util.ArrayList, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href="./css/mycontentlist.css">
<script src="menu.js"></script>
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
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
	
	 int freeID = 1; 
	 //만약에 파라미터로 pageNumber가 넘어왔다면 해당 파라미터의 값을 넣어주도록 한다.
	if (request.getParameter("freeID") != null)
	{
		//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다.
	    freeID = Integer.parseInt(request.getParameter("freeID"));
	} 


	
	

Boolean isLike=false;
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

	

	<nav class="mycontent">
	<h1 class="mycontenth1">게시판</h1>
	
	
	
	</nav>
	<%

	List<free> posts = new ArrayList<>();
	List<freecontent> posts2 = new ArrayList<>();

	 

	Connection conn = null;
	PreparedStatement stmt1 = null;
	PreparedStatement stmt2 = null;
	ResultSet rs = null;
	ResultSet rs2 = null;


	try {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/epicus", "root", "root");

	    // 첫 번째 SQL 문장
	    String sql1 = "SELECT image_path,fTitle,userID,fInto,fDate,fAvailable, fopen,flike_count FROM free WHERE  freeID=?";
	    stmt1 = conn.prepareStatement(sql1);
	    
	    stmt1.setInt(1,freeID);
	   

	    rs = stmt1.executeQuery();

	    while (rs.next()) {
	     	//int freeID = rs.getInt("freeID");
        	String fTitle = rs.getString("fTitle");
        	String image_path = rs.getString("image_path");
        	int flike_count = rs.getInt("flike_count");
        	//String userID = rs.getString("userID");
        	String fInto = rs.getString("fInto");
			//String fDate= rs.getString("fDate");
        	int fAvailable = rs.getInt("fAvailable");
        	int fopen = rs.getInt("fopen");
			Timestamp fDate =rs.getTimestamp("fDate");
        	
        	free post = new free(freeID,image_path,fTitle,userID,fInto,fDate,fAvailable,fopen,flike_count);
         	posts.add(post);
         	//freeID = rs.getInt("freeID");
         	
         	Cookie freeIDCookie = new Cookie("freeID", Integer.toString(freeID));
         	freeIDCookie.setMaxAge(3600);
         	response.addCookie(freeIDCookie);
         	 Cookie userIDCookie = new Cookie("userID", userID);
         	  String encodedFTitle = URLEncoder.encode(fTitle, "UTF-8");
         	    String encodedFInto = URLEncoder.encode(fInto, "UTF-8");

         	    // UTF-8로 인코딩된 문자열을 쿠키에 설정
         	    Cookie fTitleCookie = new Cookie("fTitle", encodedFTitle);
         	    Cookie fIntoCookie = new Cookie("fInto", encodedFInto);

         	    fTitleCookie.setMaxAge(3600);
         	    fIntoCookie.setMaxAge(3600);

         	    response.addCookie(fTitleCookie);
         	    response.addCookie(fIntoCookie);
        	//
        	userIDCookie.setMaxAge(3600);
               // 쿠키를 응답에 추가
            //
            response.addCookie(userIDCookie); 
	    }

	    // 두 번째 SQL 문장
	    String sql2 = "SELECT roundID,number,subtitle,summary,story,like_count,userID,freeDate,Available,freecheck,hit,image_path FROM freecontent WHERE freeID=? ";
	    stmt2 = conn.prepareStatement(sql2);
	    
	    stmt2.setInt(1, freeID);
	 

	    rs2 = stmt2.executeQuery();

	    while (rs2.next()) {
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
        	//freeID = rs2.getInt("freeID");
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
		<div class="ibtn">
		<i class="fas fa-regular fa-angle-left fa-xl" style="color: #ffffff;" onclick="location.href='board.jsp'"></i>
		</div>
			<%
					for(free post: posts){
						//int freeID = post.getFreeID();
		                String fTitle = post.getfTitle();
		                String fInto = post.getfInto();
		                String image_path = post.getImage_path();
		               
						int flike_count = post.getFlike_count();
					%>
		<div class="title1"><%=fTitle%></div>
		</div>

		<div class="contenttitle"><img src="book.png">
		<%-- <span class="titlespan2"><%=free.getfTitle() %></span> --%>
		 <span class="titlespan2"><%=fTitle%></span>
		<%-- <span class="Intospan"> <%=free.getfInto() %></span> --%>
		 <span class="Intospan"> <%=fInto%></span> 
		</div>
	
	

	<div class="stardiv2">
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

        xhr.open('get', 'starAction.jsp?freeID=<%=freeID%>', true);
        xhr.send();
    }

    // 클릭 이벤트 등록
    document.getElementById('heart').addEventListener('click', like);
});
</script>
	
	
	<nav class="round">
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
    for(freecontent post2: posts2) {
    	//int freeID = post2.getFreeID();
       /* 
        int roundID = post2.getRoundID(); // roundID와 number 변수를 정의하고 값을 설정
 */	 int roundID = post2.getRoundID(); 
	int number = post2.getNumber();
        String summary = post2.getSummary();
        String subtitle = post2.getSubtitle();
    %>
	<ul class="listul">
		<li class="listli">
			<div class="titlediv">
			<img src="paper.png">
			<span class="roundspan2"><%=roundID%>화.</span>
			<span class="titlespan"><strong><a class ="viewa" href="view3.jsp?freeID=<%=freeID%>&number=<%=number%>"><%=subtitle%></a></strong></span>
			<span class="infospan"><a class="suma" href="view3.jsp?freeID=<%=freeID%>&number=<%=number%>"><%=summary%></a></span>
			
		
			</div>
			
		</li>
		
			</ul>
			<hr class="listhr">
				<%
			}} 
		%>
	<div class="pagediv">
		
	</div>
	</section>
	

</body>
</html>