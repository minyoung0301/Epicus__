<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="test.free" %>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="freetest.freecontent" %>

 <%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse" %> 
<%@ page import="notification.Notifications" %>
  <%@ page import="notification.NotificationDAO" %>
  <%@ page import="java.util.ArrayList, java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href ="./css/write.css">
<script src="menu.js"></script>
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript" src="./smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var oEditors = [];
$(function(){
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: oEditors,
          elPlaceHolder: "ss", //textarea에서 지정한 id와 일치해야 합니다. 
          //SmartEditor2Skin.html 파일이 존재하는 경로
          sSkinURI: "./smarteditor/SmartEditor2Skin.html",  
          htParams : {
              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseToolbar : true,             
              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseVerticalResizer : true,     
              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
              bUseModeChanger : true,         
              fOnBeforeUnload : function(){
                   
              }
          }, 
          fOnAppLoad : function(){
              //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
              oEditors.getById["ss"].exec("PASTE_HTML", [""]);
          },
          fCreator: "createSEditor2"
      });
      
      //저장버튼 클릭시 form 전송
      $("#save").click(function(){
          oEditors.getById["ss"].exec("UPDATE_CONTENTS_FIELD", []);
          $("#frm").submit();
      });    
});
 
 
 
</script>
</head>
<body>
<%
	List<free> posts = new ArrayList<>();
	List<freecontent> posts2 = new ArrayList<>();
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
	int number = 0;
	if(request.getParameter("number") !=null){
		number = Integer.parseInt(request.getParameter("number"));
	}
	
	Connection conn = null;
	PreparedStatement stmt1 = null;
	PreparedStatement stmt2 = null;
	ResultSet rs = null;
	ResultSet rs2 = null;


	try {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/epicus", "root", "root");

	    // 첫 번째 SQL 문장
	    String sql1 = "SELECT image_path,fTitle,fInto,fDate,fAvailable, fopen,flike_count FROM free WHERE userID = ? and freeID=?";
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
        	int flike_count = rs.getInt("flike_count");
			Timestamp fDate =rs.getTimestamp("fDate");
        	
        	free post = new free(freeID,image_path,fTitle,userID,fInto,fDate,fAvailable,fopen,flike_count);
         	posts.add(post);
	    }

	    // 두 번째 SQL 문장
	    String sql2 = "SELECT roundID,subtitle,summary,story,like_count,freeDate,Available,freecheck,hit,image_path FROM freecontent WHERE freeID=? and number=?";
	    stmt2 = conn.prepareStatement(sql2);
	    
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
			 NotificationDAO notificationDAO = new NotificationDAO();
			        List<Notifications> notifications = notificationDAO.getNotifications(userID);
			%>
			<table id="notificationsTable" border="1" style="display: none; position: fixed; top: 50px; right: 10px;">
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
		<%
					for(free post: posts){
						//int freeID = post.getFreeID();
		                String fTitle = post.getfTitle();
		                String fInto = post.getfInto();
		                String image_path = post.getImage_path();
		                int flike_count = post.getFlike_count();
		                for(freecontent post2: posts2) {
		                    /* 
		                     int roundID = post2.getRoundID(); // roundID와 number 변수를 정의하고 값을 설정
		              */	 
		              int roundID = post2.getRoundID(); 
		             	//int number = post2.getNumber();
		                     String summary = post2.getSummary();
		                     String subtitle = post2.getSubtitle();
		                     String story = post2.getStory();
		               
					
					%>
	<script type="text/javascript">
    $(document).ready(function () {
        $('#frm').submit(function (e) {
            e.preventDefault(); // 폼 기본 동작을 중지
            var formData = $(this).serialize(); // 폼 데이터를 직렬화하여 문자열로 만듦

            $.ajax({
                type: "POST", // HTTP 요청 메소드 (POST 또는 GET)
                url: "updateAction.jsp?freeID="+<%=freeID%>+"&number="+<%=number%>+"&userID="+"<%=userID%>", // 데이터를 처리할 서버 쪽 JSP 파일의 경로
                data: formData, // 폼 데이터
                success: function (response) {
                	alert("수정이 완료되었습니다");
                	window.location.href="view2.jsp?freeID="+<%=freeID%>+"&number="+<%=number%>;
                		
                	
                    $('#result').html(response); // 서버의 응답을 결과 영역에 출력
                }
            });
        });
    });
</script>
	
	<nav class="titlenav">

		<span class="titlespan"><%=fTitle %></span>
		
		<hr class="navhr">
	</nav>
	<section class="createsec">
	<form method="post" id="frm" accept-charset="utf-8" action="updateAction.jsp">
		<div class="inputspan"><span class="roundspan">화</span><input type="text" class="roundbox" name="roundID" placeholder="<%=roundID%>"></div>
		<div class="imagefile">
		<div class="cover">
		 <img id="preview" style="max-width: 200px; max-height: 200px; display: block;">
		 </div>
		<label for="image">
			<div class="select">표지 선택</div>
		</label>
		<input type="file" class="image" name="image" id="image" onchange="readURL(this);" >
		</div>
	
		<div class="subdiv">부제목</div>
		<textarea class="sub" name="subtitle" cols=146 rows=4><%=subtitle %></textarea>
		<div class="sum">사건 요약(줄거리)</div>
		<textarea class="summary" name="summary" cols=146 rows=20><%=summary %></textarea>
		<div class="storybox">내용</div>
		<div class="box">
		<textarea name="story" id="ss" cols=144 rows=100><%=story%></textarea>
		</div>
		</form>
	</section>
	<footer class="createfooter">
	<input type="button" class="list" value="목록으로" onclick="location.href='mycontentlist.jsp?freeID=<%=freeID%>'">
	<input type="submit" id ="save" class="create" value="생성">
	</footer>
		
	<% }}%>



</body>
</html>