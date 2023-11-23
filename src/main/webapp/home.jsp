<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import="java.util.ArrayList, java.util.List" %>
 <%@ page import="java.sql.*" %>
<%@ page import="user.UserDAO" %>
 <%@ page import="user.User" %>
 <%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="notification.Notifications" %>
  <%@ page import="notification.NotificationDAO" %>
 <jsp:include page="homeDB.jsp" />
<%-- <jsp:include page="chatlistDB.jsp"/>  --%>
 <%
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
     ResultSet rs = (ResultSet) request.getAttribute("resultSet");
   
%>
<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href ="./css/home.css">
<link rel ="stylesheet" href ="./css/chat.css">
<!-- <script src="chat.js"></script> -->
<script src="chat2.js"></script>
<script src="menu.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
<script language="JavaScript">

	$(document).ready(function() {
		//사용할 배너
		var $banner = $(".banner").find("ul");

		var $bannerWidth = $banner.children().outerWidth();//배너 이미지의 폭
		var $bannerHeight = $banner.children().outerHeight(); // 높이
		var $bannerLength = $banner.children().length;//배너 이미지의 갯수
		var rollingId;

		//정해진 초마다 함수 실행
		rollingId = setInterval(function() { rollingStart(); }, 3000);//다음 이미지로 롤링 애니메이션 할 시간차

		//마우스 오버시 롤링을 멈춘다.
		banner.mouseover(function(){
			//중지
			clearInterval(rollingId);
			$(this).css("cursor", "pointer");
		});
		//마우스 아웃되면 다시 시작
		banner.mouseout(function(){
			rollingId = setInterval(function() { rollingStart(); }, 3000);
			$(this).css("cursor", "default");
		});
		
		function rollingStart() {
			$banner.css("width", $bannerWidth * $bannerLength + "px");
			$banner.css("height", $bannerHeight + "px");
			//alert(bannerHeight);
			//배너의 좌측 위치를 옮겨 준다.
			$banner.animate({left: - $bannerWidth + "px"}, 1500, function() { //숫자는 롤링 진행되는 시간이다.
				//첫번째 이미지를 마지막 끝에 복사(이동이 아니라 복사)해서 추가한다.
				$(this).append("<li>" + $(this).find("li:first").html() + "</li>");
				//뒤로 복사된 첫번재 이미지는 필요 없으니 삭제한다.
				$(this).find("li:first").remove();
				//다음 움직임을 위해서 배너 좌측의 위치값을 초기화 한다.
				$(this).css("left", 0);
				//이 과정을 반복하면서 계속 롤링하는 배너를 만들 수 있다.
			});
		}
	}); 
	$banner.mouseover(function(){
		//중지
		clearInterval(rollingId);
		$(this).css("cursor", "pointer");
	});
	//마우스 아웃되면 다시 시작
	$banner.mouseout(function(){
		rollingId = setInterval(function() { rollingStart(); }, 3000);
		$(this).css("cursor", "default");
	});
</script>




</head>

<body>
<%

   
	String userID = null;
	//만약에 현재 세션이 존재한다면
	if (session.getAttribute("userID") != null) {
		//그 아이디값을 받아서 userID인스턴스로 관리할 수 있도록 한다.
		userID = (String) session.getAttribute("userID");
	}
	String followerID=userID;
/* 
    Connection conn2 = null;
    PreparedStatement stmt1 = null;
    ResultSet rs2 = null;

    //String image_path = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/epicus", "root", "root");

        String sql = "SELECT id,followingID FROM follow where followerID=?";
        stmt1 = conn2.prepareStatement(sql);
      
        stmt1.setString(1, followerID);
        rs2 = stmt1.executeQuery();

        while (rs2.next()) {

        	/*  String realImagePath = request.getContextPath() + relativeImagePath; // 실제 경로 생성  */
        	

			//String followerID =rs2.getString("followerID");
        /* 	String followingID= rs2.getString("followingID");
  
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs2 != null) {
            rs2.close();
        }
        if (stmt1 != null) {
            stmt1.close();
        }
        if (conn2 != null) {
            conn2.close();
        }
    } */ 
	%>
	
	
<header class = "menubar">
	<div class="main"><a href ="home.jsp">Epicus</a></div>
	<div class="menu">
		
		<ul class ="menuul">
		<li class= "menuli"><a href ="home.jsp" >홈</a></li>
		<li class= "menuli"><a href ="mycontent.jsp">내작품</a></li>
		<li class= "menuli"><a href ="board.jsp">게시판</a></li>
		<li class= "menuli"><a href ="contest.jsp">공모전</a></li>
		<!-- <li class="menuli"></li> -->
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
        <th><img src="profile.png"></th>
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

	<nav class="homenav">
	<div class="contents">

		<div class="banner">
			<ul>
				<li><img src="1.png" width="1230px" height="500px"></li>
				<li><img src="2.png" width="1230px" height="500px"></li>
				<li><img src="3.png" width="1230px" height="500px"></li>
				
			</ul>
		</div>
	</div>
	</nav>
	<nav class="homenav2">
		<div class="banner2"><img src="banner2.png" class="b2"></div>
		<div class="banner3"><img src="banner3.png" class="b3"></div>
	</nav>
	<section class="main2">
		<span class="rank">실시간 랭킹</span>
		<span class="all"><input type="button" class="allbtn" onclick="location.href='board.jsp'" value="전체보기 >"></span>
		<div class="content">
				<%
	  
	  while (rs.next()) { 
		int freeID = rs.getInt("freeID");
	  int flike_count = rs.getInt("flike_count");
	  Timestamp fDate = rs.getTimestamp("fDate");
	  String formattedDate = dateFormat.format(fDate);
		
	  %>
			<ul class="contentul">
				<li class="contentli"><img class="contentimg" src="free.png"></li>
				<li class="contentli"><img class="contentimg" src="wizard.png"></li>
				<li class="contentli"><img class="contentimg" src="free.png"></li>
				<li class="contentli"><img class="contentimg" src="free.png"></li>
				<li class="contentli"><img class="contentimg" src="free.png"></li>
				<li class="contentli"><img class="contentimg" src="free.png"></li>
				<li class="contentli"><img class="contentimg" src="free.png"></li>
				<li class="contentli"><img class="contentimg" src="free.png"></li>
			</ul>
			</div>
			  <div class="content">	
	
	
	 	 <ul class="contentul2">
		
				<li class="title">
					<%=rs.getString("fTitle") %>
				</li>
				<li class="into">
					<%=rs.getString("fInto") %>
				</li>
				<li class="author">
					<%=rs.getString("userID")%>
				</li>
			
		
		</ul>
	
	<%} %>
	</div>
	
	</section>
	<section class="main3">
		<span class="rank">새로나온 작품</span>
		<span class="all"><input type="button" class="allbtn" onclick="location.href='board.jsp'" value="더보기 +"></span>
		<div class="newcontent">
			<li class="newli"><img class="new" src="https://image-comic.pstatic.net/webtoon/796152/thumbnail/thumbnail_IMAG21_26b9c1d8-ca2d-4fc7-87ea-a3334634236a.jpg"></li>
			
			<li class="newli"><img class="new" src="https://image-comic.pstatic.net/webtoon/790713/thumbnail/thumbnail_IMAG21_3919364435331003700.jpg"></li>
			<li class="newli"><img class="new" src="https://image-comic.pstatic.net/webtoon/654774/thumbnail/thumbnail_IMAG21_4048794550434817075.jpg"></li>
			<li class="newli"><img class="new" src="https://image-comic.pstatic.net/webtoon/712362/thumbnail/thumbnail_IMAG21_7220173143199539507.jpg"></li>
			<li class="newli"><img class="new" src="https://image-comic.pstatic.net/webtoon/616239/thumbnail/thumbnail_IMAG21_7c320dd0-7f6e-4645-b82b-e46752ed7375.jpg"></li>
			<li class="newli"><img class="new" src="https://image-comic.pstatic.net/webtoon/799267/thumbnail/thumbnail_IMAG21_f522ff4f-4f7c-40bf-b9f2-f58d049d4a82.jpg"></li>
			
		</div>
		<div class="info">
			<li class="title1">마루는 강쥐</li>
			<li class="title2">대학원 탈출일지</li>
			<li class="title3">소녀의 세계</li>
			<li class="title4">개를 낳았다</li>
			<li class="title5">윌유메리미</li>
			<li class="title6">안녕 나의 수집</li>
		</div>
	</section>

	<script>
	    var chatContainer = document.getElementById('chat-container');
	    var isChatVisible = chatContainer.style.display !== 'none';

	    if (isChatVisible) {
	        chatContainer.style.display = 'none';
	    } else {
	        chatContainer.style.display = 'block';
	    }
	}

	$(document).ready(function(){
	  var currentPosition = parseInt($(".quickmenu").css("top"));
	  $(window).scroll(function() {
	    var position = $(window).scrollTop(); 
	    $(".quickmenu").stop().animate({"top":position+currentPosition+"px"},100);
	  });
	}); 
	/* function sendMessage() {
        var message = $('#message-input').val();

        $.ajax({
            type: 'POST',
            url: 'user/ChatServlet',
            data: { message: message },
            success: function(response) {
                $('#chat-container').append('<p>' + response + '</p>');
                $('#message-input').val('');
                $('#chat-container').scrollTop($('#chat-container')[0].scrollHeight);
            },
            error: function(error) {
                console.log('Error:', error);
            }
        });
    }

    setInterval(function() {
        $.ajax({
            type: 'GET',
            url: 'user/ChatServlet',
            success: function(response) {
                $('#chat-container').html(response);
                $('#chat-container').scrollTop($('#chat-container')[0].scrollHeight);
            },
            error: function(error) {
                console.log('Error:', error);
            }
        });
    }, 2000); */
	</script>
	
	<div class="quickmenu" onclick="toggleChat()">
		<img src="chat.png" class="chatimg">
	</div>

   <div id="chat-container" >
 	<%
		UserDAO userDAO = new UserDAO();
		/* User user = new User(); */
    	List<User> followingList2 = userDAO.getFollowingList2(followerID); // 팔로우한 회원 목록을 가져옴
    
	
	for ( int i= 0; i<followingList2.size(); i++)
	{
    
	%>
	
	<%-- <div class="userID"><%=followingList2.get(i).getUserID() %></div> --%>
	<img src="character.png" class="userpng">
	<div class="userName"><%=followingList2.get(i).getUserName()%></div>
	
	<%} %>
	 
    	<input type="text" id="message-input" placeholder="Type your message">
    	<button onclick="sendMessage()">Send</button>
	  </div>

	
	<footer class="homefooter">
		<hr class="foothr">
		<li class="footli">본캠퍼스 : (14632) 경기도 부천시 신흥로 56번길 25 / 소사캠퍼스 : (14774) 경기도 부천시 소사로 56</li>
		<li class="footli">Tel : 032-610-0114 / Fax : 032-663-0114</li>

		<li class="footli">COPYRIGHT© 2023 Bucheon University. All Rights Reserved.</li>
	</footer>
	
</body>
</html>