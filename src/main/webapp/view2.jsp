<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter"%>
    <%@ page import="test.free" %>

<%@ page import="like.likeDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="freetest.freecontent" %>

<%@ page import="ccomment.Comment" %>


 <%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse" %> 
<%@ page import="java.util.ArrayList, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="Stylesheet"  href="./css/view.css">
<script src="menu.js"></script>
<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>

    <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
</head>
<body>
<%


request.setCharacterEncoding("UTF-8");

// MS word로 다운로드/실행, filename에 저장될 파일명을 적어준다.

		//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userID = null;
		if (session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID");
		}
		int commentID = 0;
		//만약에 매개변수로 넘어온 bbsID라는 매개변수가 존재 할 시 
		//(이 매개변수는 bbs.jsp에서 view로 이동하는 a태그에서 넘겨준 값이다.)
		if (request.getParameter("commentID") != null) {
	//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다. 다음과 같이 정수형으로 변환시켜준다.
	commentID = Integer.parseInt(request.getParameter("freeID"));
		}
		//매개변수및 기본셋팅 처리 하는 부분
		int freeID = 0;
		//만약에 매개변수로 넘어온 bbsID라는 매개변수가 존재 할 시 
		//(이 매개변수는 bbs.jsp에서 view로 이동하는 a태그에서 넘겨준 값이다.)
		if (request.getParameter("freeID") != null) {
	//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다. 다음과 같이 정수형으로 변환시켜준다.
	freeID = Integer.parseInt(request.getParameter("freeID"));
		}
	int number = Integer.parseInt(request.getParameter("number"));
	

	
	
		Boolean isLike=false;		//💖1.변수추가 좋아요한 글인가?
		//int like_count = 0;
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
	    String sql1 = "SELECT fTitle,fInto,fDate,fAvailable, fopen, image_path,flike_count FROM free WHERE userID = ? and freeID=?";
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
			Timestamp fDate =rs.getTimestamp("fDate");
			int flike_count = rs.getInt("flike_count");
        	
        	free post = new free(freeID,image_path,fTitle,userID,fInto,fDate,fAvailable,fopen,flike_count);
         	posts.add(post);
	    }

	    // 두 번째 SQL 문장
	    String sql2 = "SELECT roundID,subtitle,summary,story,like_count,freeDate,Available,freecheck,hit,image_path FROM freecontent WHERE userID = ? and freeID=? and number=?";
	    stmt2 = conn.prepareStatement(sql2);
	    stmt2.setString(1, userID);
	    stmt2.setInt(2, freeID);
	    stmt2.setInt(3,number);

	    rs2 = stmt2.executeQuery();

	    while (rs2.next()) {
	    	int roundID = rs2.getInt("roundID");
        	String subtitle = rs2.getString("subtitle");
        	String summary = rs2.getString("summary");
        	String story = rs2.getString("story");
        	Timestamp freeDate =rs2.getTimestamp("freeDate");
        	int available = rs2.getInt("available");
        	int freecheck = rs2.getInt("freecheck");
       		//int number = rs2.getInt("number");
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
			<%
			}
			%>
		</ul>
	
	</div>
	
	
	</header>

	

<%
					for(free post: posts){
						//int freeID = post.getFreeID();
		                String fTitle = post.getfTitle();
		                String fInto = post.getfInto();
		                String image_path = post.getImage_path();
		               	Timestamp fDate= post.getfDate();
					
					%>

	<nav class="titlenav">
		<span class="number"><%=fTitle%> : </span><span class="freeInto"><%=fInto %></span>

		
		<%-- <span class="Date"><%=fDate%></span> --%>
		<hr class="titlehr">
		
		
	</nav>
	<button class="option" onclick="openSetting()"><i class="fa-solid fa-ellipsis-vertical fa-xl" style="color: #324b4c;"></i></button>
	

		<div id="setting">
			<ul class="optionul">
				<li class="optionli"><a href="update2.jsp?freeID=<%=freeID %>&number=<%=number %>&userID=<%=userID%>">수정하기</a></li>
			
				<li class="optionli"><a href="deleteAction.jsp?freeID=<%=freeID %>&number=<%=number %>">삭제하기</a></li>
			</ul>
		</div>
	<%} %>
	<section class="titlesec">
	<div class="btndiv">
	
	<%
    for(freecontent post2: posts2) {
       //int number = post2.getNumber();
        int roundID = post2.getRoundID(); // roundID와 number 변수를 정의하고 값을 설정
		int like_count = post2.getLike_count();
        String story = post2.getStory();
        String summary = post2.getSummary();
        String subtitle = post2.getSubtitle();
       
    %>
	
	<span class="subtitlespan"><%=subtitle%></span>
	
	
	
	
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
	<div class="summarydiv">
		<div class="summary">
			<h3 class="summaryh3">사건요약 (줄거리)</h3>
		</div>
		<div class="summarydiv2"><%=summary%></div>
	</div>
	<div class="storydiv" style ="overflow:auto;"><%=story %></div>
	
	<div class="btn">
	<input type="button" class="before" value="< 이전화" onclick="location.href='view2.jsp?freeID=<%=freeID%>&number=<%=number-1%>'">
	<input type="button" class="list" value="목록" onclick="location.href='mycontentlist.jsp?freeID=<%=freeID%>'">
	<input type="button" class="next" value="다음화 >" onclick="location.href='view2.jsp?freeID=<%=freeID%>&number=<%=number+1%>'">
	</div>
	</section>
	
	<script>
function like(){
		const isHeart = document.querySelector("img[title=on]");
		if(isHeart){
			document.getElementById('heart').setAttribute('src','./love_off.png');
			document.getElementById('heart').setAttribute('title','off');
		}else{
			document.getElementById('heart').setAttribute('src','./love_on.png');
			document.getElementById('heart').setAttribute('title','on');
		}
		//사진경로는 본인에게 맞게 수정이 필요합니다.
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(){
			if(xhr.readyState == XMLHttpRequest.DONE && xhr.status ==200){
				document.getElementById('like').innerHTML = xhr.responseText;
			}	
		}
		xhr.open('get','likeAction.jsp?freeID=<%=freeID%>&number=<%=number%>',true);
		xhr.send();
	}
</script>

	<section class="likesec">
	
		<%
		if(isLike){
		%><img id="heart" src="./love_on.png" alt="좋아요" onclick="like()"><span id="like" class="heartspan"><%=like_count %>명이 좋아합니다.</span>
			<%}
		else
		{%><img id="heart" src="./love_off.png" alt="좋아요" onclick="like()"><span id="like" class="heartspan"><%=like_count %>명이 좋아합니다.</span><%}%>
		
	</section>
	<%} %>
	<section class="commentsec">
	<% if(commentID==0){
		%>
		<% 
	}else{
		%>
		
	<h3 class="commenth3">댓글</h3>
	
	
	<%} %>
	</section>
	<section class="commentsec2">
	<%
	
	%>
	
	<div class="commentdiv">
	<span class="userspan"></span>
	
	<span class="commentdate"></span><br><br>
	<span class="comment"></span>
	
	</div>
	<hr class="commenthr">
	
				<%
			
		%>
	</section>
	
	<footer class="listfooter">
	
		</footer>
</body>
</html>