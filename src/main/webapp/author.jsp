<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="test.free" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="notification.Notifications" %>
<%@ page import="notification.NotificationDAO" %>
<%@ page import="java.util.ArrayList, java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse" %>

 
<jsp:include page="authorDB.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%

SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
ResultSet rs = (ResultSet) request.getAttribute("resultSet");
response.setContentType("text/html; charset=UTF-8");
response.setCharacterEncoding("UTF-8");
%> 
<title>작가페이지</title>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href="./css/author.css">
<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>

 <link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.css">

<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
</head>
<body>
	<%
	List<free> posts = new ArrayList<>();
	//로그인이 된 사람들은 로그인정보를 담을 수 있도록한다.
 	String userID = null;
	
	//만약에 현재 세션이 존재한다면
	if (session.getAttribute("userID") != null) {
		//그 아이디값을 받아서 userID인스턴스로 관리할 수 있도록 한다.
		userID = (String) session.getAttribute("userID");
	} 
	String fuserID = request.getParameter("userID");
	
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

	

	<nav class="autornav">
		<div class="authordiv">
			<div class="left-arrowdiv">
				
			</div>
			<div class="authorprofile">
    		
    
        <div class="characterdiv">
        <img src="character.png" class="character">
        </div>
        <p class="id"><%=fuserID%></p>
        
        <input type="button" class="fplus" value="구독">


    </div>
			
		</div>
	</nav>
	<section class="autorsec">
	
		<div class="contentdiv">
		<%
	 while (rs.next()) { 
		  int freeID = rs.getInt("freeID");
		  int flike_count = rs.getInt("flike_count");
		  
		  Timestamp fDate = rs.getTimestamp("fDate");
		  String formattedDate = dateFormat.format(fDate);
		   

		                
					
					%>
			<div class="contentdiv2">
			
				<div class="coverimg">
					<img class="wizard" src="wizard.png">
				</div>
				
				<div class="ftitle">
					<%=rs.getString("fTitle") %>
				</div>
				
				<div class="fuserID">
					<%=fuserID %>
				</div>
				
				<div class="fInto">
					<%=rs.getString("fInto") %>
				</div>
				
				<div class="date">
					<%=formattedDate %>
				</div>
			 
				
		
			</div>
			<%} %>
			<div id="chat-container">
			    <input type="text" id="message-input" placeholder="메시지를 입력하세요">
			    <button onclick="sendMessage()">Send</button>
			</div>
			<div class="chat-container">
			
			</div>
		</div>
	

    <script>
        function sendMessage() {
            var message = $('#message-input').val();
            var recipientUsername = "<%=fuserID%>"; 
            var fuserID= "<%=fuserID%>"
            
            var senderUsername = "userID";
            $.ajax({
                type: 'POST',
                url: 'user/ChatServlet?recipientUsername='+"<%=fuserID%>"+'&senderUsername='+"<%=userID%>",
                data: { recipientUsername : recipientUsername, message: message },
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                success: function(response) {
                    $('chat-container').append('<p>' + response + '</p>');
                    $('#message-input').val('');
                    $('chat-container').scrollTop($('chat-container')[0].scrollHeight);
                },
                error: function(error) {
                    console.log('Error:', error);
                }
            });
        }

        setInterval(function() {
            $.ajax({
                type: 'GET',
                url: 'user/ChatServlet?recipientUsername='+"<%=fuserID%>"+'&senderUsername='+"<%=userID%>",
                success: function(response) {
                    $('#chat-container').html(response);
                    $('chat-container').scrollTop($('chat-container')[0].scrollHeight);
                },
                error: function(error) {
                    console.log('Error:', error);
                }
            });
        }, 2000);
    </script>
		
	</section>
</body>
</html>