<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
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
	<div class="main"><a href ="#">Epicus</a></div>
	<div class="menu">

		<ul class ="menuul">
		<li class= "menuli"><a href ="#" >홈</a></li>
		<li class= "menuli"><a href ="mycontent.jsp">내작품</a></li>
		<li class= "menuli"><a href ="board.jsp">게시판</a></li>
		<li class= "menuli"><a href ="#">공동작가</a></li><li class= "menuli"><a href ="#">공모전</a></li>
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
			<%} %>
		</ul>
	
	</div>
	
	
	</header>
<h1>검색 결과</h1>
<%
    UserDAO userDAO = new UserDAO();
    String targetUserID = request.getParameter("userID"); // 검색 대상 사용자의 아이디

    User user = userDAO.getUserByID(targetUserID); // 검색 대상 사용자 정보 조회

    if (user != null) {
%>
<table>
    <tr>
        <th>이름</th>
        <th>아이디</th>
        <th>이메일</th>
    </tr>
    <tr>
        <td><%= user.getUserName() %></td>
        <td><%= user.getUserID() %></td>
        <td><%= user.getUserEmail() %></td>
        <td>
            <form action="follow.jsp" method="post">
                <input type="hidden" name="followerID" value="<%= userID %>">
                <input type="hidden" name="followingID" value="<%= targetUserID %>">
                <input type="submit" value="팔로우">
            </form>
        </td>
    </tr>
</table>
<% 
    } else {
        out.println("해당하는 회원을 찾을 수 없습니다.");
    }
%>
</body>
</html>