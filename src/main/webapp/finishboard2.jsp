<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="test.freeshowDAO" %>
<%@ page import="magic.magiccontent" %>

<%@ page import="magic.magic" %>

<%@ page import="freetest.freecontent" %>
 <%@ page import="user.Notification" %>
  <%@ page import="notification.NotificationDAO" %>

<%@ page import="java.util.ArrayList" %>
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
	int magicID = 0;
	//만약에 매개변수로 넘어온 bbsID라는 매개변수가 존재 할 시 
	//(이 매개변수는 bbs.jsp에서 view로 이동하는 a태그에서 넘겨준 값이다.)
	if (request.getParameter("magicID") != null) {
//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다. 다음과 같이 정수형으로 변환시켜준다.
magicID = Integer.parseInt(request.getParameter("magicID"));
	}
	int roundID=0;
	if (request.getParameter("roundID") != null) {
//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다. 다음과 같이 정수형으로 변환시켜준다.
roundID = Integer.parseInt(request.getParameter("roundID"));
	} 
	int number=0;
	if(request.getParameter("number") !=null){
		roundID = Integer.parseInt(request.getParameter("number"));
		
	}
	magic magic = new magicDAO().getmagic(magicID);
	magiccontent magiccontent = new magiccontentDAO().getmagiccontent(magicID,number);

	
	%>



	

<header class = "menubar">
	<div class="main"><a href ="home.jsp">Epicus</a></div>
	<div class="menu">
		
		<ul class ="menuul">
		<li class= "menuli"><a href ="home.jsp" >홈</a></li>
		<li class= "menuli"><a href ="mycontent.jsp">내작품</a></li>
		<li class= "menuli"><a href ="board.jsp">게시판</a></li>
		<li class= "menuli"><a href ="contest.jsp">공모전</a></li>
		<li class="menuli"><a href="mypage_mycontent.jsp"></a></li>
		
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
			        List<Notification> notifications = notificationDAO.getNotifications(userID);
			%>
			<table id="notificationsTable" border="1" style="display: none; position: fixed; top: 50px; right: 10px;">
 <tr>
     <th>알림 내용</th>
 </tr>
 <%
     for (Notification notification : notifications) {
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
	
	<nav class="titlenav">
		<span class="number"><%=magic.getmTitle()%> : </span><span class="freeInto"><%=magic.getmInto() %></span>
	
		
		<hr class="titlehr">
	
	
	
		
	</nav>
	
	<script type="text/javascript">
  function showPopup() { 
	  window.open('popup.jsp?magicID=<%=magicID%>', "a", "width=600, height=200, left=650, top=400"); 
		window.close();	 
  }
  </script>
		<section class="allsec">
		<div class="listbtn"><input type="button" class="list" value="목록으로" onclick="location.href='mycontentlist2.jsp?magicID=<%=magicID%>'"><span class="downspan"><input type="button" class="alldownload" value="전체 word다운로드" onclick="location.href='magicword2.jsp?magicID=<%=magic.getMagicID()%>'"><input type="button" class="openbtn" value="작품 공개" onclick="showPopup();"></span></div>
			
		


		<div class="all" style="overflow:auto;">
		<%	
	
			magiccontentDAO magiccontentDAO = new magiccontentDAO();
			magicDAO magicDAO = new magicDAO();
			ArrayList<magic> list1 = magicDAO.getList(pageNumber,userID);
	
			ArrayList<magiccontent> list = magiccontentDAO.getList(pageNumber,magicID,userID);
			
			for ( int i= 0; i<list.size(); i++)
			{
		%>
		<div class="subtitlediv"><%=list.get(i).getSub_opinion() %></div>
		<div class="summarydiv"><%=list.get(i).getStory_opinion() %></div>
		<div class="downloaddiv"><input type="button" class="downbtn" value="word다운" onclick="location.href='http://localhost:8888/testtest/magicword.jsp?magicID=<%=magicID%>&roundID=<%=list.get(i).getRoundID()%>&number=<%=list.get(i).getNumber()%>'"></div>
		</div>
		<%
			}
	%>
	</section>
	

</body>
</html>