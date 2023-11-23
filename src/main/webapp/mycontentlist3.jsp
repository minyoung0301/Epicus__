<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="test.free" %>
<%@ page import="test.freeDAO" %>
<%@ page import="freetest.freecontent" %>
<%@ page import="freetest.freecontentDAO" %>
<%-- <%@ page import="free.freestory" %> --%>
<%-- <%@ page import="free.freestoryDAO" %> --%>
<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작품목록</title>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href="./css/mycontentlist.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>

 <link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.css">

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
	
	

	
	
	
	 int pageNumber = 1; 
	 //만약에 파라미터로 pageNumber가 넘어왔다면 해당 파라미터의 값을 넣어주도록 한다.
	if (request.getParameter("pageNumber") != null)
	{
		//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다.
	    pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	} 
	
	 
%>

<%
String orderBy = request.getParameter("orderBy"); // JavaScript에서 전달된 정렬 조건

// 데이터베이스 연결 설정 (JDBC)
String dbURL = "jdbc:mysql://localhost:3306/epicus";
String dbUser = "root";
String dbPass = "root";

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

    // 정렬 조건에 따라 SQL 쿼리 작성
    String sql = "SELECT * FROM freecontent";
 if ("date".equals(orderBy)) {
        sql += " ORDER BY freeDate DESC";
    }
    
    PreparedStatement stmt = conn.prepareStatement(sql);
    ResultSet rs = stmt.executeQuery();

%>

<header class = "menubar">
	<div class="main"><a href ="home.jsp">Epicus</a></div>
	<div class="menu">
		
		<ul class ="menuul">
		<li class= "menuli"><a href ="home.jsp" >홈</a></li>
		<li class= "menuli"><a href ="mycontent.jsp">내작품</a></li>
		<li class= "menuli"><a href ="board.jsp">게시판</a></li>
		<li class= "menuli"><a href ="contest.jsp">공모전</a></li>
		<li class="menuli"><a href="mypage_mycontent.jsp">마이페이지</a></li>
		<%
			if (userID == null) {	
		%>
		<li class="menuli"><a href="login.jsp">로그인</a></li>
		<li class="menuli"><a href="join.jsp">회원가입</a></li>
		<%
		} else{
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

	

	<nav class="mycontent">
	<h1 class="mycontenth1">내 작품</h1>
	
	
	
	</nav>
	<%
	int freeID=0;
	if(request.getParameter("freeID") !=null){
		freeID = Integer.parseInt(request.getParameter("freeID"));
		
	}
	int roundID=0;
	if(request.getParameter("roundID") !=null){
		roundID = Integer.parseInt(request.getParameter("roundID"));
		
	}
	int number=0;
	if(request.getParameter("number") !=null){
		roundID = Integer.parseInt(request.getParameter("number"));
		
	}

	free free = new freeDAO().getfree(freeID);
	freecontent freecontent =new freecontentDAO().getfreecontent(freeID,number);
	
	
%>
	<section class="mycontentsection">
		<div class="bar">
		<span class="ibtn">
		<i class="fas fa-regular fa-angle-left fa-xl" style="color: #ffffff;" onclick="location.href='mycontent.jsp'"></i>
<!-- 		<i class="fa-light fa-angle-left" style="color: #ffffff;" onclick="location.href='mycontent.jsp'"></i> -->
		</span>
		<div class="title"><%=free.getfTitle() %></div>
		
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

	
		<div class="contenttitle"><img src="free.png" style="width :200px; height : 200px; background-color : white;">
		<div class="v"></div>
		<span class="titlespan2"><%=free.getfTitle() %></span>
		<span class="Intospan"><%=free.getfInto() %></span>
		
		<span class="btnspan"><input type="button" class="revisebtn" value="퇴고하기" onclick="location.href='finishboard.jsp?userID=<%=userID%>&freeID=<%=freeID%>'"></span>
		
		<span class="plusspan"><input type="button" class="pluswrite" value="+ 글쓰기" onclick="location.href='write.jsp?freeID=<%=freeID%>'"></span>
		<button type="button" class="closespan"  onclick="location.href='closeAction.jsp?freeID=<%=freeID %>'"><img src="lock.png"></button>
		</div>
		
		
		
		

	
	</section>
	
	
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
 
 <script>
 document.getElementById("sortByDate").addEventListener("click", function() {
	    // 서버에 정렬 요청을 보냄
	    sortPosts("date");
	    
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
		<span class="first"><input type="button" class="firstbutton" value="최신순">|</span>
		<span class="new"><input type="button" class="newbutton" value="1화부터"></span>
		</div>
	</div>
	</nav>

		
		
	<section class="list">

		<%	
	
			freecontentDAO freecontentDAO = new freecontentDAO();
	
			ArrayList<freecontent> list = freecontentDAO.getList(pageNumber,freeID,userID);
			
			for ( int i= 0; i<list.size(); i++)
			{
		%>

		<li class="listli">
			<div class="titlediv">
			<img src="paper.png">
			<span class="roundspan2"><%=list.get(i).getRoundID() %>화.</span>
			<span class="titlespan"><strong><a class ="viewa" href="view2.jsp?freeID=<%=list.get(i).getFreeID()%>&number=<%=list.get(i).getNumber()%>"><%=list.get(i).getSubtitle()%></a></strong></span>
			<span class="infospan"><a class="suma" href="view2.jsp?freeID=<%=list.get(i).getFreeID()%>&number=<%=list.get(i).getNumber()%>&roundID=<%=list.get(i).getRoundID()%>"><%=list.get(i).getSummary() %></a></span>
			<input type="button" class="downloada" value ="word파일다운" onclick="location.href='http://localhost:8888/testtest/word.jsp?freeID=<%=freeID%>&number=<%=list.get(i).getNumber()%>'">
			
			</div>
			<hr class="listhr">
			
			
			
			
		</li>
		
		
		
				<%
			}
		%>
	<div class="pagediv">
		
	</div>
	</section>
		
		<footer>
				<% 
	 if(pageNumber != 1) {
            %>
            	<!--페이지넘버가 1이 아니면 전부다 2페이지 이상이기 때문에 pageN에서 1을뺀값을 넣어서 게시판
            	 메인화면으로 이동하게 한다. class내부 에는 화살표모양으로 버튼이 생기게 하는 소스작성 아마 부트스트랩 기능인듯.-->
			<a href="mycontentlist.jsp?pageNumber=<%=pageNumber - 1 %>&freeID=<%=freeID %>" >이전</a>
                
            <%
            	//BbsDAO에서 만들었던 함수를 이용해서, 다음페이지가 존재 할 경우
                } if (freecontentDAO.nextPage(pageNumber + 1)) {
            %>
            	<!-- a태그를 이용해서 다음페이지로 넘어 갈 수있는 버튼을 만들어 준다. -->
                <a href="mycontentlist.jsp?pageNumber=<%=pageNumber + 1 %>&freeID=<%=freeID %>" >다음</a>
            <%
                }
            %>
		</footer>
		<%
    rs.close();
    stmt.close();
    conn.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>
	

</body>
</html>