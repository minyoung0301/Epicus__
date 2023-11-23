<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>작품목록</title>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href="./css/mycontentlist.css">
<script src="menu.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>

 <link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.css">

<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
</head>
<body>


<%
	List<free> posts = new ArrayList<>();
	List<freecontent> posts2 = new ArrayList<>();
	Boolean isLike=false;
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");
	String userID = null;
	if (session.getAttribute("userID") != null)
	{
	    userID = (String)session.getAttribute("userID");
	}
	
	

	
	
	int freeID=0;
	if(request.getParameter("freeID") !=null){
		freeID = Integer.parseInt(request.getParameter("freeID"));
		
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
	    String sql1 = "SELECT image_path,fTitle,fInto,fDate,fAvailable, fopen,flike_count FROM free WHERE userID = ? and freeID=?";
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
	    String sql2 = "SELECT roundID,number,subtitle,summary,story,like_count,freeDate,Available,freecheck,hit,image_path FROM freecontent WHERE freeID=?";
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
	
 
 


	
	
%>
	<section class="mycontentsection">
		<div class="bar">
		<span class="ibtn">
		<i class="fas fa-regular fa-angle-left fa-xl" style="color: #ffffff;" onclick="location.href='mycontent.jsp'"></i>
<!-- 		<i class="fa-light fa-angle-left" style="color: #ffffff;" onclick="location.href='mycontent.jsp'"></i> -->
		</span>
		<%
					for(free post: posts){
						//int freeID = post.getFreeID();
		                String fTitle = post.getfTitle();
		                String fInto = post.getfInto();
		                
			        	String imagePathFromDB =  post.getImage_path(); // 이미지 경로 가져오기
			        	/*  String relativeImagePath = imagePathFromDB.replace("C:/Users/sms07/eclipse-workspace/Epicus__/src/main/webapp", ""); */
			        	String relativeImagePath = imagePathFromDB.replace("C:/Users/sms07/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/Epicus__//image", "");
		                int flike_count = post.getFlike_count();
		               
					
					%>
		<div class="title"><%=fTitle%></div>
		
		<button class="option" onclick="openSetting()"><i class="fas fa-solid fa-ellipsis-vertical fa-xl" style="color: #324b4c;"></i></button>
	

		<div id="setting">

			<li><a href="updatecontent.jsp?freeID=<%=freeID %>&userID=<%=userID%>">수정하기</a></li>
			
			<li><a href="deleteAction2.jsp?freeID=<%=freeID %>">삭제하기</a></li>
	
		</div>
		</div>
			<script>
	function openSetting(){
	    if(document.getElementById('setting').style.display==='block'){
	        document.getElementById('setting').style.display='none';
	    }else{
	        document.getElementById('setting').style.display='block';
	    }
	}
	</script>

	
		<div class="contenttitle"><img src="<%=request.getContextPath()%><%=relativeImagePath %>" style="width :200px; height : 200px; background-color : white;">
		<div class="v"></div>
		<span class="titlespan2"><%=fTitle%></span>
		<span class="Intospan"><%=fInto%></span>
		
		<span class="btnspan"><input type="button" class="revisebtn" value="퇴고하기" onclick="location.href='finishboard.jsp?userID=<%=userID%>&freeID=<%=freeID%>'"></span>
		
		<span class="plusspan"><input type="button" class="pluswrite" value="+ 글쓰기" onclick="location.href='write.jsp?freeID=<%=freeID%>'"></span>
		<button type="button" class="closespan"  onclick="location.href='closeAction.jsp?freeID=<%=freeID %>'"><img src="lock.png"></button>
		</div>
		
		
<%-- <div class="stardiv2">
	<img id="star" alt="좋아요">
	<span id="star" class="heartspan"></span>
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
</section>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const isstar = localStorage.getItem("isstar") === "true";
    const starCount = localStorage.getItem("starCount") || <%=flike_count%>;

    updateLikeUI(isstar, starCount);

    function updatestarUI(isstar, starCount) {
        const starImg = document.getElementById('star');
        const starCountSpan = document.getElementById('like');

        starImg.setAttribute('src', isLike ? './star_on.png' : './star_off.png');
        starImg.setAttribute('title', isLike ? 'on' : 'off');
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
    document.getElementById('star').addEventListener('click', like);
});
</script>
 --%>
	<nav class="round">
	
	 <script type="text/javascript">
  function showPopup() { window.open("popup.jsp?freeID=<%=freeID%>", "a", "width=200, height=300, left=500, top=500"); }
  </script>
  <div class="l3">
  <div class="l">
	<div class="l2">
	</div>
  
  </div>
  </div>
 
 <script type="text/javascript">
 document.getElementById("sortByDate").addEventListener("click", function() {
	    // 서버에 정렬 요청을 보냄
	    sortPosts("freeDate");
	    
	});
 function sortPosts(orderBy) {
	    var xhr = new XMLHttpRequest();
	    xhr.open("GET", "mycontentlist.jsp?orderBy=" + orderBy, true);
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState == 4 && xhr.status == 200) {
	            // 서버로부터 받은 응답을 페이지에 출력
	            document.getElementById("postList").innerHTML = xhr.responseText;
	        }
	    };
	    xhr.send();
	}
 </script>
  	<div class="bardiv">
  	 <span class="circle"></span>
  	 <span class="circle2"></span>
		<span class="roundspan">작품회차() |</span>
		<div class="option">
		<span class="first"><input type="button" id ="sortByDate" class="firstbutton" value="최신순">|</span>
		<span class="new"><input type="button" class="newbutton" value="1화부터"></span>
		</div>
	</div>
	</nav>

		
		
	<section class="list">
<%
    for(freecontent post2: posts2) {
       /* 
        int roundID = post2.getRoundID(); // roundID와 number 변수를 정의하고 값을 설정
 */	 int roundID = post2.getRoundID(); 
	int number = post2.getNumber();
        String summary = post2.getSummary();
        String subtitle = post2.getSubtitle();
    	String imagePathFromDB2 =  post2.getImage_path(); // 이미지 경로 가져오기
    	
    	String relativeImagePath2 = imagePathFromDB2.replace("C:/Users/sms07/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/Epicus__//image", "");
    %>

    <li class="listli">
        <div class="titlediv" id="postList">
            <img src="<%=request.getContextPath()%><%=relativeImagePath2 %>">
            <span class="roundspan2"><%=roundID%>화.</span>
            <span class="titlespan"><strong><a class="viewa" href="view2.jsp?freeID=<%=freeID%>&number=<%=number%>"><%=subtitle%></a></strong></span>
            <span class="infospan"><a class="suma" href="view2.jsp?freeID=<%=freeID%>&number=<%=number%>&roundID=<%=roundID%>"><%=summary%></a></span>
            <input type="button" class="downloada" value="word파일다운" onclick="location.href='http://localhost:8887/Epicus__/word.jsp?freeID=<%=freeID%>&number=<%=number%>'">
        </div>
        <hr class="listhr">
    </li>


<%}} %>
	
		
		
		
	<div class="pagediv">
		
	</div>
	</section>
	
	

</body>
</html>