<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="notification.Notifications" %>
<%@ page import="notification.NotificationDAO" %>
<%@ page import="java.util.ArrayList, java.util.List" %>	
<%@ page import ="java.text.ParseException"%>
<%@ page import ="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.*, java.util.Date" %>
<%@ page import="java.util.ArrayList, java.util.List" %>
<%@ page import="java.io.*" %>   
<%@ page import="magic.magic" %>
<%@ page import="magic.magiccontent" %>
<%@ page import="magic.characters"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/menu.css">
<link rel="stylesheet" href="./css/magic_test2.css">
<script src="menu.js"></script>
<script src="https://kit.fontawesome.com/b5051e9bb4.js" crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<body style="overflow-x: hidden; overflow-y: hidden;">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript" src="./smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>

<style>
    .character-details {
        display: none;
    }

    /* 모달 스타일 */
    .modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.7);
    }

    .modal-content {
        background-color: #fefefe;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
    }

    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        cursor: pointer;
    }
</style>
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
List<magic> posts = new ArrayList<>();
List<characters> charactersList = new ArrayList<>();
	//로그인이 된 사람들은 로그인정보를 담을 수 있도록한다.
	String userID = null;
	//만약에 현재 세션이 존재한다면
	if (session.getAttribute("userID") != null) {
		//그 아이디값을 받아서 userID인스턴스로 관리할 수 있도록 한다.
		userID = (String) session.getAttribute("userID");
	}
	 
	int magicID=0;
	if(request.getParameter("magicID") !=null){
		magicID = Integer.parseInt(request.getParameter("magicID"));
		
	} 
	  // 데이터베이스 연결 설정
     Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    //String image_path = "";

   try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/epicus", "root", "root");
    // 첫 번째 SQL 쿼리 실행
    String charactersSql = "SELECT id, image_path, explanationInput, name, placeInput, ageInput, residenceInput, genderInput, jobInput, birthdayInput, nicknameInput, personalityInput, appearanceInput, talentInput, advantageInput, roleInput, hobbyInput, etcInput FROM characters WHERE userID = ?";
    PreparedStatement charactersStmt = conn.prepareStatement(charactersSql);
    charactersStmt.setString(1, userID);
    ResultSet charactersResultSet = charactersStmt.executeQuery();


while (charactersResultSet.next()) {
    int character_id = charactersResultSet.getInt("id");
    String image_path = charactersResultSet.getString("image_path");
    String explanationInput = charactersResultSet.getString("explanationInput");
    String characterName = charactersResultSet.getString("name");
    String placeInput = charactersResultSet.getString("placeInput");
    String ageInput = charactersResultSet.getString("ageInput");
    String residenceInput = charactersResultSet.getString("residenceInput");
    String genderInput = charactersResultSet.getString("genderInput");
    String jobInput = charactersResultSet.getString("jobInput");
    String birthdayInput = charactersResultSet.getString("birthdayInput");
    String nicknameInput = charactersResultSet.getString("nicknameInput");
    String personalityInput = charactersResultSet.getString("personalityInput");
    String appearanceInput = charactersResultSet.getString("appearanceInput");
    String talentInput = charactersResultSet.getString("talentInput");
    String advantageInput = charactersResultSet.getString("advantageInput");
    String roleInput = charactersResultSet.getString("roleInput");
    String hobbyInput = charactersResultSet.getString("hobbyInput");
    String etcInput = charactersResultSet.getString("etcInput");
    characters character = new characters(character_id, userID,image_path, explanationInput, characterName, placeInput, ageInput, residenceInput, genderInput, jobInput, birthdayInput, nicknameInput, personalityInput, appearanceInput, talentInput, advantageInput, roleInput, hobbyInput, etcInput);
    charactersList.add(character); // characters 객체를 charactersList에 추가
}

    charactersResultSet.close();
    charactersStmt.close();

    // 두 번째 SQL 쿼리 실행
    String sql = "SELECT mTitle, mInto, mDate, mAvailable, mopen, image_path, mlike_count FROM magic WHERE userID = ? AND magicID = ?";
    stmt = conn.prepareStatement(sql);
    
    stmt.setString(1, userID);
    stmt.setInt(2, magicID);
    ResultSet magicResultSet = stmt.executeQuery();

    while (magicResultSet.next()) {
        String mTitle = magicResultSet.getString("mTitle");
        String image_path = magicResultSet.getString("image_path");
        String mInto = magicResultSet.getString("mInto");
        Timestamp mDate = magicResultSet.getTimestamp("mDate");
        int mAvailable = magicResultSet.getInt("mAvailable");
        int mopen = magicResultSet.getInt("mopen");
        int mlike_count = magicResultSet.getInt("mlike_count");
        magic post = new magic(magicID, image_path, mTitle, userID, mInto, mDate, mAvailable, mopen,mlike_count);
        posts.add(post);
    }

    magicResultSet.close();
    stmt.close();
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
<body oncontextmenu="return false;">
	<script>
		function goToScroll(name) {
			var location = document.querySelector("." + name).offsetTop;
			window.scrollTo({
				top : location
			});
		}
	</script>
	<header class="menubar">
		<div class="main">
			<a href="home.jsp">Epicus</a>
		</div>
		<div class="menu">

			<ul class="menuul">
				<li class="menuli"><a href="home.jsp">홈</a></li>
				<li class="menuli"><a href="mycontent.jsp">내작품</a></li>
				<li class="menuli"><a href="board.jsp">게시판</a></li>
				<li class="menuli"><a href="contest.jsp">공모전</a></li>
			
			<% 	if (userID == null) {
				%>
			<li class="menuli"><a href="login.jsp">로그인</a></li>
			<li class="menuli"><a href="join.jsp">회원가입</a></li>
	
	<%
				// 로그인이 되어있는 사람만 볼수 있는 화면
			} else {
			 NotificationDAO notificationDAO = new NotificationDAO();
			        List<Notifications> notifications = notificationDAO.getNotifications(userID);
			%>
			<table id="notificationsTable" border="1" style="display: none; position: fixed; top: 50px;">
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
	            url: "magicstoryAction.jsp?magicID="+<%=magicID%>, // 이미지와 게시물을 처리할 서버 스크립트 페이지
	            type: "POST",
	            data: formData,
	            processData: false,
	            contentType: false,
	            success: function(response) {
	                // 업로드 성공 시 처리
	                alert("게시물이 성공적으로 업로드되었습니다.");
	                window.location.href="mycontentlist2.jsp?magicID="+<%=magicID%>;
	            },
	            error: function(xhr, status, error) {
	                // 업로드 실패 시 처리
	                alert("업로드 중 오류가 발생했습니다.");
	            }
	        });
	    });
	});
	</script>
	
					
	<div class = "treeview" id = "treeview" style= "overflow: auto;">
				 	<div id="sidebar">
      		<div id="treeview-container1">
				<h3>마법사 트리뷰</h3>	
			</div>
			<div id="treeview-container"> 	
      			<ul id="treeview">
      				<li><i class="fas fa-solid fa-caret-right fa-lg" style="color: #324b4c;"></i><a href="#section1" id="scroll_move">장르</a>
        				<ul id="genres"></ul>
      				</li>
      			</ul>
      		</div>
	     		<div id="treeview-container"> 	
     			<ul id="treeview">
      				<li><i class="fas fa-solid fa-caret-right fa-lg" style="color: #324b4c;"></i><a href="#section3" id="scroll_move">키워드</a>
        				<ul id="keyword"></ul>
      				</li>
      			</ul>
      			</div>
      		<div id="treeview-container">	
      			<ul id="treeview">
      				<li><i class="fas fa-solid fa-caret-right fa-lg" style="color: #324b4c;"></i><a href="#section5" id="scroll_move">시간적배경</a>
        				<ul id="time">
        				</ul>
      				</li>
      			</ul>
      			</div>
      		<div id="treeview-container">	
      			<ul id="treeview">
      				<li><i class="fas fa-solid fa-caret-right fa-lg" style="color: #324b4c;"></i><a href="#section6" id="scroll_move">공간적배경</a>
        				<ul id="space">
        				</ul>
        			</li>
        		</ul>
        		</div> 
      		<div id="treeview-container">	
      			<ul>
      				<li><i class="fas fa-solid fa-caret-right fa-lg" style="color: #324b4c;"></i><a href="#section8" id="scroll_move">등장인물</a>
        				<ul id="character_id" />
      				</li>
      			</ul>
      		</div>
			   	</div>
			   	<div class="image">
			   		<img src ="pencil2.png">
			   		
			   	</div>
			   	</div>
	<form method="POST" id="frm" enctype="multipart/form-data" accept-charset ="utf-8" action ="magicstoryAction.jsp">
	<!-- 	장르선택 -->
		<%
					for(magic post: posts){
						//int freeID = post.getFreeID();
		                String mTitle = post.getmTitle();
		                //int mlike_count = post.getMlike_count();
		                //String fInto = post.getfInto();
		                //String image_path = post.getImage_path();
		                for(characters post2: charactersList){
		                	int character_id = post2.getId();
		                
		                
		               
					
					%>
	<div class="section1" id="section1">
		<div class="Select_genre">
		<span class="sub_title"><%=mTitle %></span>
		<span class="roundspan"><input type="text" class="round" name="roundID">화</span>
		<span class="write">글쓰기</span>
			
		</div>
		<hr>
		<div class=retangle></div>
		
		<div class="Pro">
		<progress id="progress" max="100" value="0"> 10% </progress>
			<button class="select_G">1</button>
			<button class="G">2</button>
			<button class="K">3</button>
			<button class="Plane">4</button>
			<button class="B">5</button>
			<button class="P">6</button>
		
			<span class="p1">장르</span>
		
			<span class="p2">키워드</span>
			<span class="p3">배경</span>
			<span class="p4">인물</span>
			<span class="p5">사건</span>
			<span class="p6">집필하기</span>
		
		</div>
		<div class="Pro_name">
		
		</div>
		<div class="Title_genre">
		<span class="GS">장르 선택</span>
		<span class="GS_etc">※ 2개 이상 선택 가능</span>
			
		</div>
		<div class=retangle1></div>
		<div id="checkbox-container_1">
			<label><input type="checkbox" name="genres" value="추리">추리</label>
			<label><input type="checkbox" name="genres" value="과학">과학</label>
			<label><input type="checkbox" name="genres" value="공포">공포</label>
			<label><input type="checkbox" name="genres" value="스릴러">스릴러</label>
			<label class="l"><input type="checkbox" name="genres" value="판타지">판타지</label>
			<br>
			<br> 
			<label><input type="checkbox" name="genres" value="무협">무협</label>
			<label><input type="checkbox" name="genres" value="게임">게임</label> 
			<label><input type="checkbox" name="genres" value="우화">우화</label> 
			<label><input type="checkbox" name="genres" value="에세이">에세이</label> 
			<label class="l"><input type="checkbox" name="genres" value="로맨스">로맨스</label> 
			<br>
			<br> 
			<label><input type="checkbox" name="genres" value="모험">모험</label> 
			<label><input type="checkbox" name="genres" value="역사">역사</label> 
			<label><input type="checkbox" name="genres" value="사극">사극</label> 
			<label><input type="checkbox" name="genres" value="인문학">인문학</label> 
			<label class="l"><input type="checkbox" name="genres" value="자서전">자서전</label> 
			<br>
			<br> 
			<label><input type="checkbox" name="genres" value="일기">일기</label> 
			<label><input type="checkbox" name="genres" value="기타">기타</label> 
			
		</div>
		<div class="Next_Button1">
			<button type ="button" onclick="goToScroll('section2')" class="Next">다음 ></button>
		</div>
		   </div>
	<!-- 	장르정리 -->
	<div class="section2" id="section2">
		<div class="Select_genre1">
		<span class="sub_title"><%=mTitle%></span>
		<span class="write">글쓰기</span>
			
		</div>
		<hr>
		<div class=retangle></div>
		<div class="Pro">
		<progress id="progress" max="100" value="0"> 10% </progress>
		
			<button class="select_G">1</button>
			<button class="G">2</button>
			<button class="K">3</button>
			<button class="Plane">4</button>
			<button class="B">5</button>
			<button class="P">6</button>
			
		
	
			<span class="p1">장르</span>
		
			<span class="p2">키워드</span>
			<span class="p3">배경</span>
			<span class="p4">인물</span>
			<span class="p5">사건</span>
			<span class="p6">집필하기</span>
		
		</div>
		<div class="Title_genre2">
			<h5 class="GS">장르정리</h5>
			<hr>
		</div>
		<div class=retangle2></div>
		<div id="checkbox-container_12">
			<textarea name="genre_opinion" id="genre_opinion" cols="90" rows="5" oninput="update_genre()"></textarea>
			<hr>
		</div>
		<div class="Next_Button12">
			<button type ="button" onclick="goToScroll('section1')" class="Before">< 이전</button>
			<button type ="button" onclick="goToScroll('section3')" class="Next">다음 ></button>
		</div>
	</div>

	<!-- 	키워드선택 -->
	<div class="section3" id="section3">
		<div class="Select_genre3">
			<span class="sub_title"><%=mTitle%></span>
		<span class="write">글쓰기</span>
		</div>
		<hr>
		<div class=retangle></div>
		<div class="Pro">
		<progress id="progress" max="100" value="20"> 10% </progress>
		
			<button type ="button" onclick="goToScroll('section1')" class="select_G">✔</button>
			<button class="G3">2</button>
			<button class="K">3</button>
			<button class="Plane">4</button>
			<button class="B">5</button>
			<button class="P">6</button>
			
		<span class="p1">장르</span>
		
			<span class="p2">키워드</span>
			<span class="p3">배경</span>
			<span class="p4">인물</span>
			<span class="p5">사건</span>
			<span class="p6">집필하기</span>
		
		</div>
		<div class="Title_genre3">
			<span class="GS">키워드선택</span>
			<span class="GS_etc">※ 2개 이상 선택 가능</span>
		</div>
		<div class=retangle13></div>
		<div id="checkbox-container_13">
			<label><input type="checkbox" name="keyword" value="가족">가족</label>
			<label><input type="checkbox" name="keyword" value="개그">개그</label>
			<label><input type="checkbox" name="keyword" value="기획">기획</label>
			<label><input type="checkbox" name="keyword" value="기회">기회</label>
			<label><input type="checkbox" name="keyword" value="귀환">귀환</label>
			<label><input type="checkbox" name="keyword" value="공격">공격</label>
			<label class="s"><input type="checkbox" name="keyword" value="꿈">꿈</label>
			<br>
			<br> 
			<label><input type="checkbox" name="keyword" value="과제">과제</label> 
			<label><input type="checkbox" name="keyword" value="구걸">구걸</label> 
			<label><input type="checkbox" name="keyword" value="공범">공범</label> 
			<label><input type="checkbox" name="keyword" value="구원">구원</label> 
			<label><input type="checkbox" name="keyword" value="능력">능력</label> 
			<label><input type="checkbox" name="keyword" value="동물">동물</label> 
			<label class="s"><input type="checkbox" name="keyword" value="데이트">데이트</label> <br>
			<br> 
			<label><input type="checkbox" name="keyword" value="변화">변화</label> 
			<label><input type="checkbox" name="keyword" value="복수">복수</label> <label>
			<input type="checkbox" name="keyword" value="불법">불법</label> 
			<label><input type="checkbox" name="keyword" value="비밀">비밀</label> 
			<label><input type="checkbox" name="keyword" value="범인">범인</label>
			<label><input type="checkbox" name="keyword" value="식물">식물</label>
			<label class="s"><input type="checkbox" name="keyword" value="스포츠">스포츠</label> <br>
			<br> 
			<label><input type="checkbox" name="keyword" value="순수">순수</label>
			<label><input type="checkbox" name="keyword" value="사랑">사랑</label> 
			<label><input type="checkbox" name="keyword" value="사기">사기</label> 
			<label><input type="checkbox" name="keyword" value="생존">생존</label> 
			<label><input type="checkbox" name="keyword" value="요정">요정</label> 
			<label><input type="checkbox" name="keyword" value="암호">암호</label> 
			<label class="s"><input type="checkbox" name="keyword" value="외계인">외계인</label> <br>
			<br> 
			<label><input type="checkbox" name="keyword" value="자유">자유</label> 
			<label><input type="checkbox" name="keyword" value="재벌">재벌</label> 
			<label><input type="checkbox" name="keyword" value="희생">희생</label> 
			<label><input type="checkbox" name="keyword" value="행성">행성</label> 
			<label><input type="checkbox" name="keyword" value="하늘">하늘</label> 
			<label><input type="checkbox" name="keyword" value="기타">기타 </label>
			
		</div>
		<div class="Next_Button13">
			<button type ="button" onclick="goToScroll('section4')" class="Next">다음 ></button>
			<button type ="button" onclick="goToScroll('section2')" class="Before3"><
				이전</button>
		</div>
		
	</div>
	<!-- 	키워드정리 -->
	<div class="section4" id="section4">
		<div class="Select_genre4">
			<span class="sub_title"><%=mTitle%></span>
		<span class="write">글쓰기</span>
		</div>
		<hr>
		<div class=retangle></div>
		<div class="Pro">
		<progress id="progress" max="100" value="20"> 10% </progress>
		
			<button type ="button" onclick="goToScroll('section1')" class="select_G">✔</button>
			<button class="G3">2</button>
			<button class="K">3</button>
			<button class="Plane">4</button>
			<button class="B">5</button>
			<button class="P">6</button>
			
		<span class="p1">장르</span>
		
			<span class="p2">키워드</span>
			<span class="p3">배경</span>
			<span class="p4">인물</span>
			<span class="p5">사건</span>
			<span class="p6">집필하기</span>
			
		</div>
		<div class="Title_genre2">
			<h5 class="GS">키워드정리</h5>
			<hr>
		</div>
		<div class=retangle2></div>
		<div id="checkbox-container_12">
			<textarea name="keyword_opinion" id="keyword_opinion" cols="90" rows="5" oninput="update_keyword()"></textarea><br>
			<hr>
		</div>
		<div class="Next_Button12">
			<button type ="button" onclick="goToScroll('section3')" class="Before">< 이전</button>
			<button type ="button" onclick="goToScroll('section5')" class="Next">다음 ></button>
		</div>
	</div>
	<!-- 	배경선택(시간적배경) -->
	<div class="section5" id="section5">
		<div class="Select_genre3">
			<span class="sub_title"><%=mTitle%></span>
		<span class="write">글쓰기</span>
		</div>
		<hr>
		<div class=retangle></div>
		<div class="Pro">
		<progress id="progress" max="100" value="40"> 10% </progress>
		
			<button type ="button" onclick="goToScroll('section1')" class="select_G">✔</button>
			<button type ="button" onclick="goToScroll('section3')" class="G3">✔</button>
			<button class="K5">3</button>
			<button class="Plane">4</button>
			<button class="B">5</button>
			<button class="P">6</button>
		
		<span class="p1">장르</span>
		
			<span class="p2">키워드</span>
			<span class="p3">배경</span>
			<span class="p4">인물</span>
			<span class="p5">사건</span>
			<span class="p6">집필하기</span>
		
		</div>
		<div class="Title_genre5">
			<span class="GS">시간적배경</span>
			<span class="GS_etc">※ 2개 이상 선택 가능</span>
		</div>
		<div class=retangle1></div>
		<div id="checkbox-container_14">
			<label><input type="checkbox" name="time" value="아침">아침</label>
			<label><input type="checkbox" name="time" value="점심">점심</label>
			<label><input type="checkbox" name="time" value="저녁">저녁</label>
			<label><input type="checkbox" name="time" value="과거">과거</label>
			<label><input type="checkbox" name="time" value="6.25전쟁">6.25전쟁</label>
			<br>
			<br> 
			<label><input type="checkbox" name="time" value="미래">미래</label> 
			<label><input type="checkbox" name="time" value="현재">현재</label>
			<label><input type="checkbox" name="time" value="여름">여름</label> 
				<label><input type="checkbox" name="time" value="가을">가을</label> <label><input
				type="checkbox" name="time" value="봄">봄</label> 
			<br>
			<br> 
			<label><input type="checkbox" name="time" value="겨울">겨울</label> 
			<label><input type="checkbox" name="time" value="조선">조선</label> 
			<label><input type="checkbox" name="time" value="근대">근대</label> 
			<label><input type="checkbox" name="time" value="중세">중세</label> 
			<label><input type="checkbox" name="time" value="1980년대">1980년대</label>
			<br>
			<br> 
			<label><input type="checkbox" name="time" value="기타">기타 </label>

			
		</div>
		<div class="Next_Button15">
			<button type ="button" onclick="goToScroll('section6')" class="Next">다음 ></button>
			<button type ="button" onclick="goToScroll('section4')" class="Before3">
				이전</button>
		</div>
	</div>
<!-- 	공간적배경 -->
<div class="section6" id="section6">
		<div class="Select_genre3">
			<span class="sub_title"><%=mTitle%></span>
		<span class="write">글쓰기</span>
		</div>
		<hr>
		<div class=retangle></div>
		<div class="Pro">
		<progress id="progress" max="100" value="40"> 10% </progress>
		
			<button type ="button" onclick="goToScroll('section1')" class="select_G">✔</button>
			<button type ="button" onclick="goToScroll('section3')" class="G3">✔</button>
			<button class="K5">3</button>
			<button class="Plane">4</button>
			<button class="B">5</button>
			<button class="P">6</button>
			
		<span class="p1">장르</span>
		
			<span class="p2">키워드</span>
			<span class="p3">배경</span>
			<span class="p4">인물</span>
			<span class="p5">사건</span>
			<span class="p6">집필하기</span>
			
		</div>
		<div class="Title_genre5">
			<span class="GS">배경선택<span style="font-size:16px; margin-left : 6px;"><공간적배경></span></span>
			<span class="GS_etc">※ 2개 이상 선택 가능</span>
			
		</div>
		<div class=retangle1></div>
		<div id="checkbox-container_1">
			<label><input type="checkbox" name="space" value="학교">학교</label>
			<label><input type="checkbox" name="space" value="바다">바다</label>
			<label><input type="checkbox" name="space" value="병원">병원</label>
			<label><input type="checkbox" name="space" value="마을">마을</label>
			<label><input type="checkbox" name="space" value="집">집</label>
			<br>
			<br> 
			<label><input type="checkbox" name="space" value="궁전">궁전</label>
			 <label><input type="checkbox"name="space" value="공원">공원</label>
			  <label><input type="checkbox" name="space" value="가게">가게</label> 
			  <label><input type="checkbox" name="space" value="계곡">계곡</label> 
			  <label><input type="checkbox" name="space" value="놀이공원">놀이공원</label> 
			  <br><br> 
			  <label><input type="checkbox" name="space" value="기차">기차</label> 
			  <label><input type="checkbox" name="space" value="버스">버스</label> 
			  <label><input type="checkbox" name="space" value="복도">복도</label> 
			  <label><input type="checkbox" name="space" value="극장">극장</label> 
			  <label><input type="checkbox" name="space" value="강">강</label> 
			  <br><br> 
			  <label><input type="checkbox" name="space" value="호수">호수</label> 
			  <label><input type="checkbox" name="space" value="기타">기타</label>


		</div>
		<div class="Next_Button15">
			<button type ="button" onclick="goToScroll('section7')" class="Next">다음 ></button>
			<button type ="button" onclick="goToScroll('section5')" class="Before3"><
				이전</button>
		</div>
	</div>
<!-- 	배경정리 -->
<div class="section7" id="section7">
		<div class="Select_genre7">
			<span class="sub_title"><%=mTitle%></span>
		<span class="write">글쓰기</span>
		</div>
		
		<div class=retangle></div>
		<div class="Pro">
		<progress id="progress" max="100" value="40"> 10% </progress>
		
			<button type ="button" onclick="goToScroll('section1')" class="select_G">✔</button>
			<button type ="button" onclick="goToScroll('section3')" class="G3">✔</button>
			<button class="K5">3</button>
			<button class="Plane">4</button>
			<button class="B">5</button>
			<button class="P">6</button>
			
		<span class="p1">장르</span>
		
			<span class="p2">키워드</span>
			<span class="p3">배경</span>
			<span class="p4">인물</span>
			<span class="p5">사건</span>
			<span class="p6">집필하기</span>
		
		</div>
		
		<div class="Title_genre2">
			<h5 class="GS">배경정리</h5>
			<hr>
		</div>
		<div class="scroll">
		<div  class=retangle3 style= "overflow: auto;">
		<h5 class="background_1">1. 배경요소</h5>
		<h5 class="background_2">(1) 시간 : 소설에서 인물이 행동하고 사건이 일어나는 시간적 상황으로 시대적 요소나 계절적 요소가 여기에 포함</h5>
			<div id="checkbox-container_71">
				<textarea name="time_opinion" id="time_opinion" cols="90" rows="5" oninput="update_time()"></textarea>
			</div>
			<h5 class="background_3">(2) 공간 : 인물이 활동하고 사건이 일어나는 공간적인 무대로, 자연 환경이나 생활 환경 등을 의미하며 국가나 지역 등이 포함</h5>
			<div id="checkbox-container_71">
				<textarea name="space_opinion" id="space_opinion" cols="90" rows="5" oninput="update_space()"></textarea>
			</div>
		<h5 class="background_1">2. 배경의종류</h5>
		<h5 class="background_3">(1) 자연적 배경 : 주로 사건이 일어나는 구체적 시간과 공간</h5>
			<div id="checkbox-container_71">
				<textarea name="natural_opinion" id="natural_opinion" cols="90" rows="5" oninput="update_natural()"></textarea>
			</div>
			<h5 class="background_3">(2) 사회적 배경 : 자연적 배경과 구별하여 소설 속에 나타난 사회 현실과 역사적 상황을 의미</h5>
			<div id="checkbox-container_71">
				<textarea name="social_opinion" id="social_opinion" cols="90" rows="5" oninput="update_social()"></textarea>
			</div>
			<h5 class="background_3">(3) 심리적 배경 : 인물의 심리 상황이나 독특한 내면 세계를 의미</h5>
			<div id="checkbox-container_71">
				<textarea name="psychological_opinion" id="psychological_opinion" cols="90" rows="5" oninput="update_psychological()"></textarea>
			</div>
			<h5 class="background_3">(4) 상황적 배경 : 인간의 실존적인 상황을 배경으로 설정하는 것</h5>
			<div id="checkbox-container_71">
				<textarea name="situational_opinion" id="situational_opinion" cols="90" rows="5" oninput="update_situational()"></textarea>
			</div>
			<h5 class="background_1">3.기타</h5>
				<div id="checkbox-container_71">
					<textarea name="other_opinion" id="other_opinion" cols="90" rows="5" oninput="update_other()"></textarea>
				
		</div>
		</div>
		<div class="Next_Button16">
			<button type ="button" onclick="goToScroll('section8')" class="Next">다음 ></button>
			<button type ="button" onclick="goToScroll('section6')" class="Before3"><
				이전</button>
		</div>
			
	</div>
	</div>
<!--<-- 인물정리 -->
 <div class="section8" id="section8">
      <div class="Select_genre7">
         <span class="sub_title"><%=mTitle%></span>
		<span class="write">글쓰기</span>
      </div>
      <hr>
      <div class=retangle></div>
       <div class="Pro">
      <progress id="progress" max="100" value="60"> 10% </progress>
     
         <button type ="button" onclick="goToScroll('section1')" class="select_G">✔</button>
         <button type ="button" onclick="goToScroll('section3')" class="G3">✔</button>
         <button type ="button" onclick="goToScroll('section5')" class="K5">✔</button>
         <button class="Plane8">4</button>
         <button class="B">5</button>
         <button class="P">6</button>
      
      <span class="p1">장르</span>
		
			<span class="p2">키워드</span>
			<span class="p3">배경</span>
			<span class="p4">인물</span>
			<span class="p5">사건</span>
			<span class="p6">집필하기</span>
			
		</div>
  
      <div class="Title_genre2">
         <h5 class="GS">인물목록</h5>
          <hr>
          <div class=retangle4 style= "overflow: auto;">
               <% 
				for (characters character : charactersList) {
				%>
				    <div class="character">
				        <input type="checkbox" name="character_id" value="<%=character.getId()%>">
				        <label class="character-name" data-characterid="<%=character.getId()%>"><%=character.getName()%></label>
				        <div class="character-details" id="details<%=character.getId()%>">
				            <%=character.getPersonalityInput()%> <!-- 성격 정보를 보여줍니다 -->
				        </div>
				    </div>
				<%
				}
				%>
   <div id="characterModal" class="modal">
        <div class="modal-content">
            <span class="close" id="closeModalButton">&times;</span>
            
            <h2>캐릭터 세부 정보</h2>
            <div class="user"><img src="user.png" class="user"></div>
            <div id="characterDetails">
               <p id="characterNameLabel">이름 : <span id="characterName"></span></p>
               <p id="characterNameLabel">성격 : <span id="characterPersonality"></span></p>
            </div>
        </div>
    </div>

    <script>
        const characterNames = document.querySelectorAll(".character-name");
        const characterDetails = document.getElementById("characterDetails");
        const characterModal = document.getElementById("characterModal");
        const closeModalButton = document.getElementById("closeModalButton");

        characterNames.forEach((name) => {
            name.addEventListener("click", (event) => {
                const characterId = name.getAttribute("data-characterid");
                const characterNameText = name.textContent;
                const characterPersonalityText = document.getElementById("details" + characterId).textContent;

                // 모달 내부의 텍스트 업데이트
                const characterNameElement = document.getElementById("characterName");
                const characterPersonalityElement = document.getElementById("characterPersonality");
                characterNameElement.textContent = characterNameText;
                characterPersonalityElement.textContent = characterPersonalityText;

                characterModal.style.display = "block";
            });
        });

        closeModalButton.addEventListener("click", () => {
            characterModal.style.display = "none";
        });
    </script>
      </div>
      
      <ul id="nameList">
      <span id="personList">
      </span>

  <div id="personInfo" style="display : none;">
    <h2 id="personName"></h2>
    <span class="ispan"><i class="fas fa-solid fa-caret-right fa-lg" style="color: #324b4c;"></i></span><span>성별: <span id="personGender"></span></span>
    <span class="ispan"><i class="fas fa-solid fa-caret-right fa-lg" style="color: #324b4c;"></i></span><span>특징: <span id="personCharacteristics"></span></span>
  </div>
      </ul>
      </div>
      <div class="Next_Button16">
         <button type ="button" onclick="goToScroll('section9')" class="Next">다음 ></button>
         <button type ="button" onclick="goToScroll('section7')" class="Before3">이전</button>
      </div>   
       <div id="personPopup" class="popup">
       <div class ="inputdiv">
        <label for="nameInput">이름:</label>
    <textarea name ="nameInput" id="nameInput"></textarea>
    </div>
    <div class="inputdiv2">
    <label for="gender">성별:</label>
    <select id="gender"  name="genderInput">
      <option value="남성">남성</option>
      <option value="여성">여성</option>
    </select>
    </div>
    <div class="inputdiv3">
    <label for="characteristics">특징:</label>
    <textarea id="characteristics" name="characteristics"></textarea>
   </div>
    <button id="saveButton" type="button">확인</button>
     
  </div>
   </div><!-- 사건설정 -->
<div class="section9" id="section9">
		<div class="Select_genre7">
			<span class="sub_title"><%=mTitle %></span>
		<span class="write">글쓰기</span>
		</div>
		<hr>
		<div class=retangle></div>
		<div class="Pro">
		<progress id="progress" max="100" value="80"> 10% </progress>
		
			<button type ="button" onclick="goToScroll('section1')" class="select_G">✔</button>
			<button type ="button" onclick="goToScroll('section3')" class="G3">✔</button>
			<button type ="button" onclick="goToScroll('section5')" class="K5">✔</button>
			<button type ="button" onclick="goToScroll('section8')" class="Plane8">✔</button>
			<button class="B9">5</button>
			<button class="P">6</button>
			
		<span class="p1">장르</span>
		
			<span class="p2">키워드</span>
			<span class="p3">배경</span>
			<span class="p4">인물</span>
			<span class="p5">사건</span>
			<span class="p6">집필하기</span>
		
		</div>
		
		<div class="Title_genre2">
			<h5 class="GS">사건설정</h5>
			<hr>
		</div>
		<div class="scroll">
		<div  class=retangle3 style= "overflow: auto;">
		
		<h5 class="background_1">1. 내면적사건</h5>
			<div id="checkbox-container_91">
				<textarea name="internal_opinion" id="internal_opinion" cols="130" rows="5" oninput="update_internal()"></textarea><br>
			</div>
		<h5 class="background_1">2. 외면적사건</h5>
			<div id="checkbox-container_91">
				<textarea name="external_opinion" id="external_opinion" cols="130" rows="5" oninput="update_external()"></textarea>
			</div>
			<h5 class="background_1">3.복선</h5>
				<div id="checkbox-container_91">
					<textarea name="track_opinion" id="track_opinion" cols="130" rows="5" oninput="update_track()"></textarea>
				</div>
		</div>
		
		<div class="Next_Button16">
			<button type ="button" onclick="goToScroll('section10')" class="Next">다음 ></button>
			<button type="button" onclick="goToScroll('section8')" class="Before3">
				< 이전</button>
			</div>	
	</div>
	</div>
<!-- 	집필하기 -->
	<div class="section10" id="section10">
		<div class="Select_genre7">
			<span class="sub_title"><%=mTitle%></span>
		<span class="write">글쓰기</span>
		</div>
		<hr>
		<div class=retangle></div>
		<div class="Pro">
		<progress id="progress" max="100" value="100"> 10% </progress>
		
			<button type ="button" onclick="goToScroll('section1')" class="select_G">✔</button>
			<button type ="button" onclick="goToScroll('section3')" class="G3">✔</button>
			<button type ="button" onclick="goToScroll('section5')" class="K5">✔</button>
			<button type ="button" onclick="goToScroll('section8')" class="Plane8">✔</button>
			<button type ="button" onclick="goToScroll('section9')" class="B9">✔</button>
			<button class="P10">6</button>
	
		<span class="p1">장르</span>
		
			<span class="p2">키워드</span>
			<span class="p3">배경</span>
			<span class="p4">인물</span>
			<span class="p5">사건</span>
			<span class="p6">집필하기</span>
			
		</div>
		
		<div class="Title_genre2">
			<h5 class="GS">집필하기</h5>
			<hr>
		</div>
		<div  class=retangle3 style= "overflow: auto;">
		<h5 class="background_1">부제목</h5>
			<div id="checkbox-container_101">
				<textarea name="sub_opinion" id="sub_opinion" cols="130" rows="5" oninput="update_sub()"></textarea>
			</div>
		<h5 class="background_1">사건요약</h5>
			<div id="checkbox-container_101">
				<textarea name="story_opinion" id="story_opinion" cols="130" rows="5" oninput="update_story()"></textarea>
			</div>
		</div>
		<div class="Next_Button16">
			<button type ="button" onclick="goToScroll('section11')" class="Next">다음 ></button>
			<button type ="button" onclick="goToScroll('section9')" class="Before3"><
				이전</button>
		</div>		
	</div>
		<div class="section11" id="section11">
		<div class="Select_genre7">
			<span class="sub_title"><%=mTitle%></span>
		<span class="write">글쓰기</span>
		</div>
		<hr>
		<div class=retangle></div>
		<div class="Pro">
		<progress id="progress" max="100" value="100"> 10% </progress>
		
			<button type ="button" onclick="goToScroll('section1')" class="select_G">✔</button>
			<button type ="button" onclick="goToScroll('section3')" class="G3">✔</button>
			<button type ="button" onclick="goToScroll('section5')" class="K5">✔</button>
			<button type ="button" onclick="goToScroll('section8')" class="Plane8">✔</button>
			<button type ="button" onclick="goToScroll('section9')" class="B9">✔</button>
			<button class="P10">6</button>
	
		<span class="p1">장르</span>
		
			<span class="p2">키워드</span>
			<span class="p3">배경</span>
			<span class="p4">인물</span>
			<span class="p5">사건</span>
			<span class="p6">집필하기</span>
		
		</div>
		<div class="Title_genre2">
			<h5 class="GS">집필하기</h5>
			<hr>
		</div>
		<div  class=retangle3 style= "overflow: auto;">
			
				<div id="checkbox-container_111">
					<textarea name="main_opinion" id="main_opinion" cols="130" rows="10" oninput="main_track()"></textarea>
				</div>
		</div>
		<div class="Next_Button16">
			<button type="submit" class="save" id ="save" >작성</button>
			
			<button type ="button" onclick="goToScroll('section10')" class="Before3" type="button">
				이전</button>
		</div>
		</div>
				<%} }%>
			</form>	

		
	


  	
  	
	 <script>
  	// 버튼을 눌러 페이지 스크롤이동
  	function toGenre() {
      document.getElementById('genre_Screen').scrollIntoView({ behavior: 'smooth' });
    }
  	
  	function toGenre_detail() {
        document.getElementById('genre_detailScreen').scrollIntoView({ behavior: 'smooth' });
      }
  	
  	function to() {
        document.getElementById('_detailScreen').scrollIntoView({ behavior: 'smooth' });
      }
  	
  	function to() {
        document.getElementById('_detailScreen').scrollIntoView({ behavior: 'smooth' });
      }
  	
  	function to() {
        document.getElementById('_detailScreen').scrollIntoView({ behavior: 'smooth' });
      }
  
 	// 체크박스 선택 시, 트리뷰에 추가하는 함수
    function addNode(value, parent) {
      const node = document.createElement("li");
      node.textContent = value;
      parent.appendChild(node);
    }
 	
    // 장르 textarea의 내용을 트리뷰에 추가하는 함수
    function update_genre() {
      const genreOpinion = document.getElementById("genre_opinion").value;
      const genreNode = document.getElementById("genre_opinion_node");

      genreNode.textContent = genreOpinion;
    }
 	
      //장르 체크박스 이벤트 핸들러
      const genresInputs = document.getElementsByName("genres");
      const genresNode = document.getElementById("genres");
      for (let i = 0; i < genresInputs.length; i++) {
        genresInputs[i].addEventListener("change", function() {
          if (genresInputs[i].checked) {
            addNode(genresInputs[i].value, genresNode);
          } else {
            for (let j = 0; j < genresNode.childNodes.length; j++) {
              if (genresNode.childNodes[j].textContent === genresInputs[i].value) {
                genresNode.removeChild(genresNode.childNodes[j]);
              }
            }
          }
        });
      }
      
      //textarea
      function toggleOther() {
          var otherGenresInput = document.getElementById("other_genres");
          if (otherGenresInput.disabled) {
            otherGenresInput.disabled = false;
          } else {
            otherGenresInput.disabled = true;
            otherGenresInput.value = "";
          }
        }
      
      //키워드 체크박스 이벤트 핸들러
      const keywordInputs = document.getElementsByName("keyword");
      const keywordNode = document.getElementById("keyword");
      for (let i = 0; i < keywordInputs.length; i++) {
    	  keywordInputs[i].addEventListener("change", function() {
          if (keywordInputs[i].checked) {
            addNode(keywordInputs[i].value, keywordNode);
          } else {
            for (let j = 0; j < keywordNode.childNodes.length; j++) {
              if (keywordNode.childNodes[j].textContent === keywordInputs[i].value) {
            	  keywordNode.removeChild(keywordNode.childNodes[j]);
              }
            }
          }
        });
      }
    //인물 체크박스 이벤트 핸들러
      const character_idInputs = document.getElementsByName("character_id");
      const character_idNode = document.getElementById("character_id");
      for (let i = 0; i < character_idInputs.length; i++) {
    	  character_idInputs[i].addEventListener("change", function() {
          if (character_idInputs[i].checked) {
            addNode(character_idInputs[i].value, character_idNode);
          } else {
            for (let j = 0; j < character_idNode.childNodes.length; j++) {
              if (character_idNode.childNodes[j].textContent === character_idInputs[i].value) {
            	  character_idNode.removeChild(character_idNode.childNodes[j]);
              }
            }
          }
        });
      }
      
   	  // 키워드 textarea의 내용을 트리뷰에 추가하는 함수
      function update_keyword() {
        const keywordOpinion = document.getElementById("keyword_opinion").value;
        const keywordNode = document.getElementById("keyword_opinion_node");

        keywordNode.textContent = keywordOpinion;
      }
      
      //시간적배경 체크박스 이벤트 핸들러
      const timeInputs = document.getElementsByName("time");
      const timeNode = document.getElementById("time");
      for (let i = 0; i < timeInputs.length; i++) {
    	  timeInputs[i].addEventListener("change", function() {
          if (timeInputs[i].checked) {
            addNode(timeInputs[i].value, timeNode);
          } else {
            for (let j = 0; j < timeNode.childNodes.length; j++) {
              if (timeNode.childNodes[j].textContent === timeInputs[i].value) {
            	  timeNode.removeChild(timeNode.childNodes[j]);
              }
            }
          }
        });
      }
      
   	  // 시간적배경 textarea의 내용을 트리뷰에 추가하는 함수
      function update_time() {
        const timeOpinion = document.getElementById("time_opinion").value;
        const timeNode = document.getElementById("time_opinion_node");

        timeNode.textContent = timeOpinion;
      }
      
      //공간적배경 체크박스 이벤트 핸들러
      const spaceInputs = document.getElementsByName("space");
      const spaceNode = document.getElementById("space");
      for (let i = 0; i < spaceInputs.length; i++) {
    	  spaceInputs[i].addEventListener("change", function() {
          if (spaceInputs[i].checked) {
            addNode(spaceInputs[i].value, spaceNode);
          } else {
            for (let j = 0; j < spaceNode.childNodes.length; j++) {
              if (spaceNode.childNodes[j].textContent === spaceInputs[i].value) {
            	  spaceNode.removeChild(spaceNode.childNodes[j]);
              }
            }
          }
        });
      }
      
      // 공간적배경 textarea의 내용을 트리뷰에 추가하는 함수
      function update_space() {
        const spaceOpinion = document.getElementById("space_opinion").value;
        const spaceNode = document.getElementById("space_opinion_node");

        spaceNode.textContent = spaceOpinion;
      }
      
  	  // 자연적배경 textarea의 내용을 트리뷰에 추가하는 함수
      function update_natural() {
        const naturalOpinion = document.getElementById("natural_opinion").value;
        const naturalNode = document.getElementById("natural_opinion_node");

        naturalNode.textContent = naturalOpinion;
      }
  	  
      // 사회적배경 textarea의 내용을 트리뷰에 추가하는 함수
      function update_social() {
        const socialOpinion = document.getElementById("social_opinion").value;
        const socialNode = document.getElementById("social_opinion_node");

        socialNode.textContent = socialOpinion;
      }
  
      // 심리적배경 textarea의 내용을 트리뷰에 추가하는 함수
      function update_psychological() {
        const psychologicalOpinion = document.getElementById("psychological_opinion").value;
        const psychologicalNode = document.getElementById("psychological_opinion_node");

        psychologicalNode.textContent = psychologicalOpinion;
      }
  
  	  // 상황적배경 textarea의 내용을 트리뷰에 추가하는 함수
      function update_situational() {
        const situationalOpinion = document.getElementById("situational_opinion").value;
        const situationalNode = document.getElementById("situational_opinion_node");

        situationalNode.textContent = situationalOpinion;
      }
  	
  	  // 기타 textarea의 내용을 트리뷰에 추가하는 함수
      function update_other() {
        const otherOpinion = document.getElementById("other_opinion").value;
        const otherNode = document.getElementById("other_opinion_node");

        otherNode.textContent = otherOpinion;
      }  	  
  	  
 	  // 내면적 textarea의 내용을 트리뷰에 추가하는 함수
      function update_internal() {
        const otherOpinion = document.getElementById("internal_opinion").value;
        const otherNode = document.getElementById("internal_opinion_node");

        otherNode.textContent = otherOpinion;
      } 
      // 외면적 textarea의 내용을 트리뷰에 추가하는 함수
      function update_external() {
        const otherOpinion = document.getElementById("external_opinion").value;
        const otherNode = document.getElementById("external_opinion_node");

        otherNode.textContent = otherOpinion;
      } 
      // 복선 textarea의 내용을 트리뷰에 추가하는 함수
      function update_track() {
        const otherOpinion = document.getElementById("track_opinion").value;
        const otherNode = document.getElementById("track_opinion_node");

        otherNode.textContent = otherOpinion;
      } 
    </script>
   
    
</body>
</html>