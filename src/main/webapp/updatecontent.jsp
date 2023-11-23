<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="test.free" %>
<%@ page import="test.freeDAO" %>
    <%@ page import="java.io.PrintWriter"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 작품 만들기</title>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href ="./css/writecontent.css">
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>




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
	int freeID=0;
	if(request.getParameter("freeID") !=null){
		freeID = Integer.parseInt(request.getParameter("freeID"));
		
	}
	 int pageNumber = 1; 
	 //만약에 파라미터로 pageNumber가 넘어왔다면 해당 파라미터의 값을 넣어주도록 한다.
	if (request.getParameter("pageNumber") != null)
	{
		//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다.
	    pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	} 
	free free = new freeDAO().getfree(freeID);
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

	<div class="newcontent">
	<h1 class="createh1">새 작품 만들기</h1>
	
	
	<hr class="createhr">
	
	
		
	</div>
	<form method="post" action="updateAction2.jsp?freeID=<%=freeID%>">
	<section class="createsec">
		<div class="createimage">작품 표지</div>
		<input type="file" id="file1" class="image" name="image" style="display: none;">
		<label for ="file1" class="filebtn" style="background-color : #324B4C; width:150px; height :30px;">이미지 불러오기</label>
		
		<div class="imagebox"></div>
		<div class="contenttitle">작품 제목</div>
		<textarea class="title" name="fTitle" cols ="102" rows="2"><%=free.getfTitle() %></textarea>
		<div class="contentInto"></div>
		<textarea class="into" name="fInto" cols="102" rows="5"><%=free.getfInto() %></textarea>
		
	</section>
	<hr class="createhr2">
	<footer class="btnfooter">
	
		<input type="button" class="listbtn" value="내 작품으로" onclick="location.href='mycontent.jsp'">
		<input type="submit" class="createbtn" value="생성">
		
	</footer>
	</form>
	
	

	
	
	
	



</body>
</html>