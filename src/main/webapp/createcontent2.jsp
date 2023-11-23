<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter"%>
<%@ page import="notification.Notifications" %>
  <%@ page import="notification.NotificationDAO" %>
  <%@ page import="java.util.ArrayList, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 작품 만들기</title>
<link rel ="stylesheet" href ="./css/menu.css">
<link rel ="stylesheet" href ="./css/writecontent.css">
<script src="menu.js"></script>
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>



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
			<table id="notificationsTable" style="display: none; position: fixed; top: 50px;">
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


	<div class="newcontent">
	<h1 class="createh1">새 작품 만들기</h1>
	
	
	<hr class="createhr">
	
	
		
	</div>
		<script>
	$(document).ready(function() {
	    $("#uploadForm").submit(function(e) {
	        e.preventDefault();

	        var formData = new FormData(this);

	        $.ajax({
	            url: "createcontentAction.jsp", // 이미지와 게시물을 처리할 서버 스크립트 페이지
	            type: "POST",
	            data: formData,
	            processData: false,
	            contentType: false,
	            success: function(response) {
	                // 업로드 성공 시 처리
	                alert("게시물이 성공적으로 업로드되었습니다.");
	                window.location.href = "mycontent.jsp";
	            },
	            error: function(xhr, status, error) {
	                // 업로드 실패 시 처리
	                alert("업로드 중 오류가 발생했습니다.");
	            }
	        });
	    });
	});
	</script>
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
	window.onload=function(){
		target=document.getElementById('image'); // file 아이디 선언
		target.addEventListener('change',function(){ // change 함수
			
			if(target.value.length){ // 파일 첨부인 상태일경우 파일명 출력
				$('#path').html(target.files[0].name);
			}else{ //버튼 클릭후 취소(파일 첨부 없을 경우)할때 파일명값 안보이게
				$('#path').html("");
			}
			
		});
	}
    </script>
	<form method="post" id="uploadForm" action="createcontentAction.jsp" enctype="multipart/form-data">
	<section class="createsec">
		<div class="createimage">작품 표지</div>
		<div class="imagefile">
		<div class="cover">
		 <img id="preview" style="width: 200px;height: 200px; display: block;">
		 </div>
                             
		<input type="file"  data-ax-path="file" id="image" class="image" name="image" onchange="readURL(this);" style="display:none">
		<label for ="image" id ="image">
		<span class="filebtn">표지 선택</span>
		</label>
		<div class="imginfo">* 표지 크기 200px X 200px *</div>
		<div id="path">
		
		</div>
		<!-- <p id="path" style="display : inline-block"> -->
		</div>
		<div class="contenttitle">작품 제목</div>
		<textarea class="title" name="fTitle" placeholder ="제목을 입력하세요" cols ="102" rows="2"></textarea>
		<div class="contentInto"></div>
		<textarea class="into" name="fInto" placeholder="작품 소개를 입력하세요" cols="102" rows="5"></textarea>
		
	</section>
	<hr class="createhr2">
	<footer class="btnfooter">
	
		<input type="button" class="listbtn" value="목록으로" onclick="location.href='mycontent.jsp'">
		<input type="submit" class="createbtn" value="생성">
		
	</footer>
	</form>
	
	

	
	
	
	



</body>
</html>