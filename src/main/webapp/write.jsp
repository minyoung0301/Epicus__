<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="test.free" %>
	<%@ page import ="java.text.ParseException"%>
	<%@ page import ="java.text.SimpleDateFormat"%>
	<%@ page import="java.sql.*, java.util.Date" %>
<%@ page import="notification.Notifications" %>
  <%@ page import="notification.NotificationDAO" %>
  <%@ page import="java.util.ArrayList, java.util.List" %>

    <%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
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
	int freeID=0;
	if(request.getParameter("freeID") !=null){
		freeID = Integer.parseInt(request.getParameter("freeID"));
		
	} 
	  // 데이터베이스 연결 설정
     Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    //String image_path = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/epicus", "root", "root");

        String sql = "SELECT image_path,fTitle,fInto,fDate,fAvailable,fopen,flike_count  FROM free WHERE userID = ? and freeID=?";
        stmt = conn.prepareStatement(sql);
      
        stmt.setString(1, userID);
        stmt.setInt(2,freeID);
        rs = stmt.executeQuery();

        while (rs.next()) {
        	
        	//int freeID = rs.getInt("freeID");
        	String fTitle = rs.getString("fTitle");
        	String image_path = rs.getString("image_path");
        	//String userID = rs.getString("userID");
        	String fInto = rs.getString("fInto");
        	Timestamp fDate =rs.getTimestamp("fDate");
			//String fDate= rs.getString("fDate");
        	int fAvailable = rs.getInt("fAvailable");
        	int fopen = rs.getInt("fopen");
        	int flike_count =rs.getInt("flike_count");
        	free post = new free(freeID,image_path,fTitle,userID,fInto,fDate,fAvailable,fopen,flike_count);
        	posts.add(post);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) {
            rs.close();
        }
        if (stmt != null) {
            stmt.close();
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
			<script>
	$(document).ready(function() {
	    $("#frm").submit(function(e) {
	        e.preventDefault();

	        var formData = new FormData(this);

	        $.ajax({
	            url: "writestoryAction.jsp?freeID="+<%=freeID%>, // 이미지와 게시물을 처리할 서버 스크립트 페이지
	            type: "POST",
	            data: formData,
	            processData: false,
	            contentType: false,
	            success: function(response) {
	                // 업로드 성공 시 처리
	                alert("게시물이 성공적으로 업로드되었습니다.");
	                window.location.href="mycontentlist.jsp?freeID="+<%=freeID%>;
	            },
	            error: function(xhr, status, error) {
	                // 업로드 실패 시 처리
	                alert("업로드 중 오류가 발생했습니다.");
	            }
	        });
	    });
	});
	</script>
		<%
					for(free post: posts){
						//int freeID = post.getFreeID();
		                String fTitle = post.getfTitle();
		                //String fInto = post.getfInto();
		                //String image_path = post.getImage_path();
		               
					
					%>
	<script>
	function readURL(input) {
		  if (input.files && input.files[0]) {
		    var reader = new FileReader();
		    reader.onload = function(e) {
		      document.getElementById('preview').src = e.target.result;
		    };
		    reader.readAsDataURL(input.files[0]);
		  } else {
		    document.getElementById('preview').src = "";
		  }
		}
    </script>
	
	<nav class="titlenav">
	
		<span class="titlespan"><%=fTitle %></span>
		<%} %>
		
		<hr class="navhr">
	</nav>
	<section class="createsec">
	<form method="post" id="frm"  enctype="multipart/form-data" accept-charset="utf-8" action="writestoryAction.jsp">
		<div class="inputspan"><span class="roundspan">화</span><input type="text" class="roundbox" name="roundID"></div>
		<div class="imagefile">
		<div class="cover">
		 <img id="preview" style="width: 200px;height: 200px; display: block;">
		 </div>
		<label for="image">
			<div class="select">표지 선택</div>
		</label>
		<input type="file" class="image" name="image" id="image" onchange="readURL(this);" >
		</div>
		<div class="subdiv">부제목</div>
		<textarea class="sub" name="subtitle" placeholder = "부제목을 입력해주세요" cols=146 rows=4></textarea>
		<div class="sum">사건 요약(줄거리)</div>
		<textarea class="summary" name="summary" placeholder = "줄거리를 입력해주세요" cols=146 rows=20></textarea>
		<div class="storybox">내용</div>
		<div class="box">
		<textarea name="story" id="ss" placeholder = "내용을 입력해주세요" cols=144 rows=100></textarea>
		</div>
			</form>
	</section>
	<footer class="createfooter">
	<input type="button" class="list" value="목록으로" onclick="location.href='mycontentlist.jsp?freeID=<%=freeID%>'">
	<input type="submit" id ="save" class="create" value="생성">
	</footer>
	



</body>
</html>