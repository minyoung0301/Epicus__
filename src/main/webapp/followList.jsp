<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>
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
    
    // followerID 변수를 선언하고 현재 로그인한 사용자의 아이디를 할당
    String followerID = userID;
    
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

<h1>내가 팔로우한 회원 목록</h1>
<%
    UserDAO userDAO = new UserDAO();
    List<User> followingList = userDAO.getFollowingList(followerID); // 팔로우한 회원 목록을 가져옴

    if (!followingList.isEmpty()) {
%>
<ul>
    <%
        for (User followingUser : followingList) {
    %>
    <li><a href="userPage.jsp?userID=<%= followingUser.getUserID() %>"><%= followingUser.getUserName() %></a></li>
    <%
        }
    %>
</ul>
<%
    } else {
        out.println("아직 아무도 팔로우하지 않았습니다.");
    }
%>
</body>
</html>