<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="notification.Notifications" %>
<%@ page import="notification.NotificationDAO" %>
    <%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%-- <jsp:useBean id ="notification" class="notification.Notifications" scope="page"/>
<jsp:setProperty name="Notifications" property="followingID"/>
<jsp:setProperty name="Notifications" property="message"/> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//로그인이 된 사람들은 로그인정보를 담을 수 있도록한다.
	String userID = null;
	//만약에 현재 세션이 존재한다면
	if (session.getAttribute("userID") != null) {
		//그 아이디값을 받아서 userID인스턴스로 관리할 수 있도록 한다.
		userID = (String) session.getAttribute("userID");
	}
	 int pageNumber = 1; 
	 //만약에 파라미터로 pageNumber가 넘어왔다면 해당 파라미터의 값을 넣어주도록 한다.
	if (request.getParameter("pageNumber") != null)
	{
		//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다.
	    pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
		<li class="menuli"><a href="mypage.jsp">마이페이지</a></li>
		<%
				// 접속하기는 로그인이 되어있지 않은 경우만 나오게한다.
			if (userID == null) {
			%>
			<li class="menuli"><a href="login.jsp">로그인</a></li>
			<li class="menuli"><a href="join.jsp">회원가입</a></li>
	
	<%
				// 로그인이 되어있는 사람만 볼수 있는 화면
			} else {
			%>
			<li class="menuli"><a href="logoutAction.jsp">로그아웃</a></li>
			<span class="profile"><i class="fa-solid fa-circle-user fa-xl" style="color: #324b4c;"></i></span>
			<%} %>
		</ul>
	
	</div>
	
	
	</header>


     <%
     String followerID = request.getParameter("followerID");
     String followingID = request.getParameter("followingID"); // 팔로우할 대상의 아이디

        if (followerID != null && followingID != null) {
            UserDAO userDAO = new UserDAO();

            // 팔로우 정보를 데이터베이스에 저장
            int result = userDAO.followUser(followerID, followingID);

            if (result == 1) {
            	 out.println("<script type=\"text/javascript\">");
            	    out.println("alert('팔로우가 완료되었습니다.');");
            	    out.println("location='mypage_friend.jsp';");
            	    out.println("</script>");
                String message = userID + "님이 팔로우 하였습니다.";
                NotificationDAO notificationDAO = new NotificationDAO();
                notificationDAO.addNotification(followingID, message); // 반환값 무시
               
            } else {
                out.println("팔로우에 실패했습니다.");
                
            }
        } else {
            out.println("팔로우할 대상을 찾을 수 없습니다.");
        }
    %>
</body>
</html>