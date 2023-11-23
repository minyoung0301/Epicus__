<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="magic.magic" %>

<%@ page import="magic.magiccontent" %>

<%@ page import="magiccomment.cmagiccommentDAO" %>
<%@ page import="magiccomment.cmagiccomment" %>

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

String userID = null;
if (session.getAttribute("userID") != null) {
    userID = (String) session.getAttribute("userID");
}
int commentID = 0;
//만약에 매개변수로 넘어온 bbsID라는 매개변수가 존재 할 시 
//(이 매개변수는 bbs.jsp에서 view로 이동하는 a태그에서 넘겨준 값이다.)
if (request.getParameter("commentID") != null) {
//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다. 다음과 같이 정수형으로 변환시켜준다.
commentID = Integer.parseInt(request.getParameter("magicID"));
}

int magicID = 0;
if (request.getParameter("magicID") != null) {
    magicID = Integer.parseInt(request.getParameter("magicID"));
}

int number =Integer.parseInt(request.getParameter("number"));

Boolean isLike=false;		//💖1.변수추가 좋아요한 글인가?
int like_count = 0;
List<magic> posts = new ArrayList<>();
List<magiccontent> posts2 = new ArrayList<>();

Connection conn = null;
PreparedStatement stmt1 = null;
PreparedStatement stmt2 = null;
ResultSet rs = null;
ResultSet rs2 = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/epicus", "root", "root");

        String sql1 = "SELECT mTitle, mInto, mDate, mAvailable, mopen, image_path, mlike_count FROM magic WHERE userID = ? and magicID=?";
        stmt1 = conn.prepareStatement(sql1);
        stmt1.setString(1, userID);
        stmt1.setInt(2, magicID);
        
        rs = stmt1.executeQuery();

        while (rs.next()) {
            String mTitle = rs.getString("mTitle");
            String image_path = rs.getString("image_path");
            String mInto = rs.getString("mInto");
            int mAvailable = rs.getInt("mAvailable");
            int mopen = rs.getInt("mopen");
            Timestamp mDate = rs.getTimestamp("mDate");
            int mlike_count = rs.getInt("mlike_count");
            magic post = new magic(magicID, image_path, mTitle, userID, mInto, mDate, mAvailable, mopen,mlike_count);
            posts.add(post);
        }

        String sql2 = "SELECT roundID, genres, genre_opinion, keyword, keyword_opinion, time, space, time_opinion, " +
                     "space_opinion, natural_opinion, social_opinion, psychological_opinion, situational_opinion, " +
                     "other_opinion, internal_opinion, external_opinion, track_opinion, sub_opinion, story_opinion, " +
                     "main_opinion, like_count, magicDate, Available, magiccheck, hit, character_id " +
                     "FROM magiccontent WHERE userID = ? AND magicID = ? AND number=?";
        stmt2 = conn.prepareStatement(sql2);
        stmt2.setString(1, userID);
        stmt2.setInt(2, magicID);
        stmt2.setInt(3, number);

        rs2 = stmt2.executeQuery();

        while (rs2.next()) {
            int roundID = rs2.getInt("roundID");
            //int number = rs2.getInt("number");
            String genres = rs2.getString("genres");
            String genre_opinion = rs2.getString("genre_opinion");
            String keyword = rs2.getString("keyword");
            String keyword_opinion = rs2.getString("keyword_opinion");
            String time = rs2.getString("time");
            String space = rs2.getString("space");
            String time_opinion = rs2.getString("time_opinion");
            String space_opinion = rs2.getString("space_opinion");
            String natural_opinion = rs2.getString("natural_opinion");
            String social_opinion = rs2.getString("social_opinion");
            String psychological_opinion = rs2.getString("psychological_opinion");
            String situational_opinion = rs2.getString("situational_opinion");
            String other_opinion = rs2.getString("other_opinion");
            String internal_opinion = rs2.getString("internal_opinion");
            String external_opinion = rs2.getString("external_opinion");
            String track_opinion = rs2.getString("track_opinion");
            String sub_opinion = rs2.getString("sub_opinion");
            String story_opinion = rs2.getString("story_opinion");
            String main_opinion = rs2.getString("main_opinion");
            //int like_count = rs2.getInt("like_count");
            Timestamp magicDate = rs2.getTimestamp("magicDate");
            int Available = rs2.getInt("Available");
            int magiccheck = rs2.getInt("magiccheck");
            int hit = rs2.getInt("hit");
            int character_id = rs2.getInt("character_id");
            magiccontent post2 = new magiccontent(magicID, roundID, number, genres, genre_opinion, keyword,keyword_opinion, time, space,time_opinion,space_opinion,natural_opinion,social_opinion,psychological_opinion,situational_opinion,other_opinion,internal_opinion,external_opinion,track_opinion,sub_opinion,story_opinion,main_opinion,userID,like_count,magicDate,Available,magiccheck,hit,character_id);
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
 <script>
    function showTab(tabId) {
      // 모든 탭 내용을 숨김
      var tabContents = document.getElementsByClassName("tab-content");
      for (var i = 0; i < tabContents.length; i++) {
        tabContents[i].style.display = "none";
      }
      
      // 선택한 탭 내용을 보임
      document.getElementById(tabId).style.display = "block";
    }
  </script>
	 <script>
    // 초기 실행 시 탭 1 내용을 보이도록 설정
    showTab('tab1');
  </script>
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
			<%
			}
			%>
		</ul>
	
	</div>
	
	
	</header>
<%
					for(magic post: posts){
						//int freeID = post.getFreeID();
		                String mTitle = post.getmTitle();
		                String mInto = post.getmInto();
		                String image_path = post.getImage_path();
		               	Timestamp mDate= post.getmDate();  
					
					%>
	



	<nav class="titlenav">
		<span class="number"><%=mTitle%> : </span><span class="magicInto"><%=mInto%></span>
		<%-- <span class="Date"><%=mDate%></span> --%>

		<hr class="titlehr">
		
		
	</nav>
	<section class="titlesec">
	<div class="btndiv">
	<span class="btnspan">

	
<%-- 	<input type="button" class="fa-solid fa-chevron-left" id="beforebtn" onclick="location.href='view4.jsp?contentNumber=<%=contentNumber-1%>&magicID=<%=magicID%>&number=<%=number%>&roundID=<%=roundID%>'"> --%>
<!-- 	</span> -->
	<%
    for(magiccontent post2: posts2) {
       //int number = post2.getNumber();
        int roundID = post2.getRoundID(); // roundID와 number 변수를 정의하고 값을 설정
		String sub_opinion = post2.getSub_opinion();
		String story_opinion = post2.getSub_opinion();
      	String main_opinion =post2.getMain_opinion();
      	String genres =post2.getGenres();
      	String genre_opinion =post2.getGenre_opinion();
      	String keyword =post2.getKeyword();
      	String keyword_opinion =post2.getKeyword_opinion();
      	String time =post2.getTime_opinion();
      	String time_opinion =post2.getTime_opinion();
      	String space =post2.getSpace();
      	String space_opinion =post2.getSpace_opinion();
      	String natural_opinion =post2.getNatural_opinion();
      	String social_opinion =post2.getSocial_opinion();
      	String psychological_opinion =post2.getPsychological_opinion();
      	String situational_opinion =post2.getSituational_opinion();
      	String other_opinion =post2.getOther_opinion();
      	String internal_opinion =post2.getInternal_opinion();
      	String external_opinion =post2.getExternal_opinion();
      	String track_opinion = post2.getTrack_opinion();
       
    %>
	<span class="subtitlespan"><%=sub_opinion%></span>
<%-- 	<span class="spanbtn"><input type="button" class="nextbtn" value=">" onclick="location.href='view4.jsp?contentNumber=<%=contentNumber+1%>&magicID=<%=magicID%>&number=<%=number%>&roundID=<%=roundID%>'"></span> --%>
<!-- 	<span class="optionbtn"><i class="fab fa-regular fa-ellipsis-vertical"></i></span> -->
	
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
	<div class="tabdiv">
	<button class="magictext"  onclick="showTab('tab1')">스토리</button>
    <button class="option2" onclick="showTab('tab2')">스토리 정보</button>
    </div>
    <div id="tab1" class="tab-content">
		<div class="summarydiv">
			<div class="summary">
				<h3 class="summaryh3">사건요약 (줄거리)</h3>
			</div>
			<div class="summarydiv2"><%=story_opinion%></div>
		</div>
		<div class="storydiv" style ="overflow:auto;"><pre><%=main_opinion%></pre></div>
	</div>
	<div id="tab2" class="tab-content">
	<div class="summarydiv">
			<div class="summary">
				<h3 class="summaryh3">장르</h3>
			</div>
			<div class="summarydiv2"><%=genres%></div>
		</div>
		<div class="summarydiv">
			<div class="summary">
				<h3 class="summaryh3">장르 정리</h3>
			</div>
			<div class="summarydiv2"><%=genre_opinion%></div>
		</div>
		<div class="summarydiv">
			<div class="summary">
				<h3 class="summaryh3">키워드</h3>
			</div>
			<div class="summarydiv2"><%=keyword%></div>
		</div>
		<div class="summarydiv">
			<div class="summary">
				<h3 class="summaryh3">키워드 정리</h3>
			</div>
			<div class="summarydiv2"><%=keyword_opinion%></div>
		</div>
		<div class="summarydiv">
			<div class="summary">
				<h3 class="summaryh3">시간적배경</h3>
			</div>
			<div class="summarydiv2"><%=time%></div>
		</div>
		<div class="summarydiv">
			<div class="summary">
				<h3 class="summaryh3">시간적배경 정리</h3>
			</div>
			<div class="summarydiv2"><%=time_opinion%></div>
		</div>
		<div class="summarydiv">
			<div class="summary">
				<h3 class="summaryh3">공간적배경</h3>
			</div>
			<div class="summarydiv2"><%=space%></div>
		</div>
		<div class="summarydiv">
			<div class="summary">
				<h3 class="summaryh3">공간적배경정리</h3>
			</div>
			<div class="summarydiv2"><%=space_opinion%></div>
		</div>
		<div class="summarydiv">
			<div class="summary">
				<h3 class="summaryh3">배경의종류:자연적배경</h3>
			</div>
			<div class="summarydiv2"><%=natural_opinion%></div>
		</div>
		<div class="summarydiv">
			<div class="summary">
				<h3 class="summaryh3">배경의종류:사회적배경</h3>
			</div>
			<div class="summarydiv2"><%=social_opinion%></div>
		</div>
		<div class="summarydiv">
			<div class="summary">
				<h3 class="summaryh3">배경의종류:심리적배경</h3>
			</div>
			<div class="summarydiv2"><%=psychological_opinion%></div>
		</div>
		<div class="summarydiv">
			<div class="summary">
				<h3 class="summaryh3">배경의종류:상황적배경</h3>
			</div>
			<div class="summarydiv2"><%=situational_opinion%></div>
		</div>
		<div class="summarydiv">
			<div class="summary">
				<h3 class="summaryh3">기타</h3>
			</div>
			<div class="summarydiv2"><%=other_opinion%></div>
		</div>
		<div class="summarydiv">
			<div class="summary">
				<h3 class="summaryh3">내면적사건</h3>
			</div>
			<div class="summarydiv2"><%=internal_opinion%></div>
		</div>
		<div class="summarydiv">
			<div class="summary">
				<h3 class="summaryh3">외면적사건</h3>
			</div>
			<div class="summarydiv2"><%=external_opinion%></div>
		</div>
		<div class="summarydiv">
			<div class="summary">
				<h3 class="summaryh3">복선</h3>
			</div>
			<div class="summarydiv2"><%=track_opinion%></div>
		</div>
	</div>
		<div class="btn">
	<input type="button" class="before" value="< 이전화" onclick="location.href='view4.jsp?magicID=<%=magicID%>&number=<%=number-1%>'">
	<input type="button" class="list" value="목록" onclick="location.href='mycontentlist2.jsp?magicID=<%=magicID%>'">
	<input type="button" class="next" value="다음화 >" onclick="location.href='view4.jsp?magicID=<%=magicID%>&number=<%=number+1%>'">
	</div>
	</section>
	
	<section class="likesec">
	
		<%
		if(isLike){
		%><img id="heart" src="./love_on.png" alt="좋아요" onclick="like()"><span id="like" class="heartspan"><%=like_count %>명이 좋아합니다.</span>
			<%}
		else
		{%><img id="heart" src="./love_off.png" alt="좋아요" onclick="like()"><span id="like" class="heartspan"><%=like_count %>명이 좋아합니다.</span><%}%>
		
	</section>
	<%} }%> 
	<section class="commentsec">
<%-- <%
if (magiccommentID == 0) {
%>
<!-- 이 부분의 내용 -->
<%
} else {
%>
<h3 class="commenth3">댓글</h3>
<%
}
%>
	</section>
	<section class="commentsec2">
	<%
	cmagiccommentDAO cmagiccommentDAO = new cmagiccommentDAO();
		
		ArrayList<cmagiccomment> list =cmagiccommentDAO.getList(pageNumber,magicID,number);
		
		for ( int i= 0; i<list.size(); i++)
		{
	%>
	<div class="commentdiv">
	<span class="userspan"><%=list.get(i).getUserID() %></span>
	
	<span class="commentdate"><%=list.get(i).getCommentDate() %></span><br><br>
	<span class="comment"><%=list.get(i).getCommentText() %></span>
	
	</div>
	<hr class="commenthr">
	
				<%
			}
		%> --%>
	</section>
	
	 <script>

 showTab('tab1');
  </script>
	<footer class="listfooter">
	
		</footer>
</body>
</html>