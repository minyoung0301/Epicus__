<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter"%>
    <%@ page import="test.free" %>
    <%@ page import="read.recontent" %>
<%@ page import="java.util.Base64" %>

<%@ page import="freetest.freecontent" %>

<%-- <%@ page import="freetest.freecontentshowDAO" %> --%>
<%@ page import="ccomment.Comment" %>


<%@ page import="java.net.URLEncoder" %>
 <%@ page import="javax.servlet.http.HttpServletRequest, java.io.IOException, java.net.URL, java.net.MalformedURLException" %>
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

Boolean isLike=false;		
int like_count = 0;
		String userID = null;
		if (session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID");
		}
		

		int freeID = 0;
		if (request.getParameter("freeID") != null) {
	
	freeID = Integer.parseInt(request.getParameter("freeID"));
		} 
		int number = 0;
	
		if (request.getParameter("number") != null) {
	//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다. 다음과 같이 정수형으로 변환시켜준다.
	number = Integer.parseInt(request.getParameter("number"));
		}


		List<free> posts = new ArrayList<>();
		List<freecontent> posts2 = new ArrayList<>();
		List<Comment> posts3 = new ArrayList<>();

	
	
    Connection conn = null;
    PreparedStatement pstmt = null;
    Connection conn2 = null;
	PreparedStatement stmt = null;
	PreparedStatement stmt2 = null;
	ResultSet rs = null;
	ResultSet rs2 = null;
	Connection conn3 = null;
	
	ResultSet rs3 = null;
	

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String dbUrl = "jdbc:mysql://localhost:3306/epicus";
        String dbUser = "root";
        String dbPassword = "root";
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		

        String sql = "SELECT image_path,fTitle,userID,fInto,fDate,fAvailable, fopen, flike_count FROM free WHERE freeID = ?";
        stmt = conn.prepareStatement(sql);
      
        stmt.setInt(1, freeID);
        rs = stmt.executeQuery();

        while (rs.next()) {
        	
        	// DB에서 이미지 경로를 가져옴
        	String imagePathFromDB = rs.getString("image_path"); // 이미지 경로 가져오기

        	// 이미지 경로를 웹 애플리케이션의 상대 경로로 변환
        	String relativeImagePath = "/images/" + imagePathFromDB; // 상대 경로 설정
        	String realImagePath = request.getContextPath() + relativeImagePath; // 실제 경로 생성
        	


        	//int freeID = rs.getInt("freeID");
        	String fTitle = rs.getString("fTitle");
        	String image_path = rs.getString("image_path");
        	//String userID = rs.getString("userID");
        	String fInto = rs.getString("fInto");
        	Timestamp fDate =rs.getTimestamp("fDate");
			//String fDate= rs.getString("fDate");
        	int fAvailable = rs.getInt("fAvailable");
        	int fopen = rs.getInt("fopen");
        	int flike_count = rs.getInt("flike_count");
        	free post = new free(freeID,image_path,fTitle,userID,fInto,fDate,fAvailable,fopen,flike_count);
        	posts.add(post);
        	
        	
        	
        }
	    conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/epicus", "root", "root");

	   

	    // 두 번째 SQL 문장
	    String sql2 = "SELECT roundID,subtitle,summary,story,like_count, userID,freeDate,Available,freecheck,hit,image_path FROM freecontent WHERE freeID=? and number=?";
	    stmt2 = conn2.prepareStatement(sql2);
	    
	    stmt2.setInt(1, freeID);
	    stmt2.setInt(2,number);
	 

	    rs2 = stmt2.executeQuery();

	    while (rs2.next()) {
	    	int roundID = rs2.getInt("roundID");
	    	
        	String subtitle = rs2.getString("subtitle");
        	String summary = rs2.getString("summary");
        	String story = rs2.getString("story");
        	Timestamp freeDate =rs2.getTimestamp("freeDate");
        	int available = rs2.getInt("available");
        	int freecheck = rs2.getInt("freecheck");
        	//int like_count = rs2.getInt("like_count");
       		//int number = rs2.getInt("number");
        	int hit = rs2.getInt("hit");
        	
        	String image_path = rs2.getString("image_path");
        	freecontent post2 = new freecontent(freeID,roundID,number,subtitle,summary,story,like_count,userID,freeDate,available,freecheck,hit,image_path);
            
        	posts2.add(post2);
        	
        	 String insertQuery = "INSERT INTO readcontent (re_userID, re_freeID, re_number) VALUES (?, ?, ?)";
        	    PreparedStatement insertStatement = conn.prepareStatement(insertQuery);
        	    insertStatement.setString(1, userID);
        	    insertStatement.setInt(2, freeID);
        	    insertStatement.setInt(3, number);
        	    insertStatement.executeUpdate();
        	    insertStatement.close();

        	   
        	 
        	    String updateQuery = "UPDATE freecontent SET hit = hit + 1 WHERE freeID = ? AND number = ?";
        	    PreparedStatement updateStatement = conn.prepareStatement(updateQuery);
        	    updateStatement.setInt(1, freeID);
        	    updateStatement.setInt(2, number);
        	    updateStatement.executeUpdate();

        	    updateStatement.close();
        	    //conn.close();
        	
        	    String selectQuery = "SELECT * FROM comment WHERE freeID = ? and number=?";
        	    PreparedStatement selectStatement = conn.prepareStatement(selectQuery);
        	    selectStatement.setInt(1, freeID);
        	    selectStatement.setInt(2, number);
        	    ResultSet resultSet = selectStatement.executeQuery();

        	    while (resultSet.next()) {
        	    	
        	        String commentText = resultSet.getString("commentText");
        	        int commentID = resultSet.getInt("commentID");
        	        Timestamp commentDate = resultSet.getTimestamp("commentDate");
        	        int cAvailable =resultSet.getInt("cAvailable");
        	        Comment post3 = new Comment(commentID,freeID,userID,commentDate,commentText,cAvailable,number);
                    
                	posts3.add(post3);
        	    }

        	    selectStatement.close();
	    }
	} catch (Exception e) {
	    e.printStackTrace();
	} finally {
	    // 리소스 해제 
	    if (rs2 != null) {
	        rs2.close();
	    }
	    if(pstmt !=null){
	    	pstmt.close();
	    }
	    if (stmt2 != null) {
	        stmt2.close();
	    }
	    if (conn != null) {
	        conn.close();
	    }
	    if (conn2 != null) {
	        conn2.close();
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
		                for(freecontent post2: posts2) {
		                    //int number = post2.getNumber();
		                     //int roundID = post2.getRoundID(); // roundID와 number 변수를 정의하고 값을 설정
							int hit = post2.getHit();
		                     String story = post2.getStory();
		                     String summary = post2.getSummary();
		                     String subtitle = post2.getSubtitle();
		                     //int like_count = post2.getLike_countO();
					
					%>
	<nav class="titlenav">
		<span class="number"><%=fTitle%> : </span><span class="freeInto"><%=fInto%></span>
		<%-- <span class="Date"><%=fDate%></span> --%>
		<span class="Date"><i class="fa-solid fa-eye"></i><%=hit%></span>
		
		<hr class="titlehr">
		
		
	</nav>
	
	<section class="titlesec">
	<div class="btndiv">
	<%-- <span class="btnspan">

	
	<input type="button" class="beforebtn" value="/" onclick="location.href='view2.jsp?contentNumber=<%=contentNumber-1 %>&freeID=<%=freeID %>&number=<%=number %>&roundID=<%=roundID %>'">
	</span> --%>
	<%
  
       
    %>
	<span class="subtitlespan"><%=subtitle%></span>
	<%-- <span class="spanbtn"><input type="button" class="nextbtn" value=">" onclick="location.href='view2.jsp?contentNumber=<%=contentNumber+1 %>&freeID=<%=freeID %>&number=<%=number %>&roundID=<%=roundID %>'"></span>
	
 --%>
 	</div>
	<div class="summarydiv">
		<div class="summary">
			<h3 class="summaryh3">사건요약 (줄거리)</h3>
		</div>
		<div class="summarydiv2" style ="overflow:auto;"><%=summary%></div>
	</div>
	<div class="storydiv"><%=story%></div>
	<div class="btn">
	<input type="button" class="before" value="< 이전화">
	<input type="button" class="list" value="목록" onclick="location.href='showcontent.jsp?freeID=<%=freeID%>'">
	<input type="button" class="next" value="다음화 >">
	
	</div>
	</section>
	
<script>
function like() {
    const isHeart = document.querySelector("img[title=on]");
    const xhr = new XMLHttpRequest();

    xhr.onreadystatechange = function () {
        if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
            const likeCountSpan = document.getElementById('like');
            likeCountSpan.innerHTML = xhr.responseText;

            if (isHeart) {
                document.getElementById('heart').setAttribute('src', './love_off.png');
                document.getElementById('heart').setAttribute('title', 'off');
            } else {
                document.getElementById('heart').setAttribute('src', './love_on.png');
                document.getElementById('heart').setAttribute('title', 'on');
            }
        }
    }

    xhr.open('get', 'likeAction.jsp?freeID=<%=freeID%>&number=<%=number%>', true);
    xhr.send();
}
</script>

<script>
document.addEventListener("DOMContentLoaded", function () {
    // 페이지 로딩 시 좋아요 상태 가져오기
    const isLike = localStorage.getItem("isLike") === "true";
    const likeCount = localStorage.getItem("likeCount") || 0;

    updateLikeUI(isLike, likeCount);

    function updateLikeUI(isLike, likeCount) {
        const heartImg = document.getElementById('heart');
        const likeCountSpan = document.getElementById('like');

        heartImg.setAttribute('src', isLike ? './love_on.png' : './love_off.png');
        heartImg.setAttribute('title', isLike ? 'on' : 'off');
        likeCountSpan.innerHTML = likeCount + '명이 좋아합니다.';
    }

    function like() {
        const isLike = localStorage.getItem("isLike") === "true";
        const likeCount = parseInt(localStorage.getItem("likeCount")) || 0;

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

        xhr.open('get', 'likeAction.jsp?freeID=<%=freeID%>&number=<%=number%>', true);
        xhr.send();
    }

    // 클릭 이벤트 등록
    document.getElementById('heart').addEventListener('click', like);
});
</script>

<section class="likesec">
    <img id="heart" alt="좋아요">
    <span id="like" class="heartspan"></span>
</section>

		<script>
	$(document).ready(function() {
	    $("#commentfrm").submit(function(e) {
	        e.preventDefault();

	        var formData = new FormData(this);

	        $.ajax({
	            url: "commentAction.jsp?userID="+'<%=userID%>'+"&freeID="+<%=freeID%>+"&number="+<%=number%>, // 이미지와 게시물을 처리할 서버 스크립트 페이지
	            type: "POST",
	            data: formData,
	            processData: false,
	            contentType: false,
	            success: function(response) {
	                // 업로드 성공 시 처리
	                alert("게시물이 성공적으로 업로드되었습니다.");
	                window.location.href = "view3.jsp?freeID="+<%=freeID%>+"&number="+<%=number%>;
	            },
	            error: function(xhr, status, error) {
	                // 업로드 실패 시 처리
	                alert("업로드 중 오류가 발생했습니다.");
	            }
	        });
	    });
	});
	</script>
	<%} %>
	<form method="post" id="commentfrm" action ="commentAction.jsp?userID=<%=userID%>">
	
	<section class="commentsec">
	<h3 class="commenth3">댓글</h3>
		<textarea class="commentbox"  name="commentText" placeholder="댓글을 작성하세요" cols="100" rows="5"></textarea>
		<div class="submitdiv"><input type="submit" class="commentsubmit" value="등록"></div>
	</section>
	</form>
	<section class="commentsec2">
	<%
	for(Comment post3 : posts3){
		String commentText = post3.getCommentText();
		Timestamp commentDate = post3.getCommentDate();
		
		
		
		%>
	
	<div class="commentdiv">
	<span class="userspan"></span>
	
	<span class="commentdate"><%=commentDate%></span><br><br>
	<span class="comment"><%=commentText %></span>
	
	</div>
	<hr class="commenthr">
	<%} }%>
	
	</section>

	<footer class="listfooter">

		</footer>
</body>
</html>