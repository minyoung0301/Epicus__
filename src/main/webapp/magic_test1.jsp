<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마법사</title>
<link rel="stylesheet" href="./css/magic_test.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<body style="overflow-x: hidden; overflow-y: auto;">

	
</head>
<body>
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
		<%
		//로그인이 된 사람들은 로그인정보를 담을 수 있도록한다.
		String userID = null;
		//만약에 현재 세션이 존재한다면
		if (session.getAttribute("userID") != null) {
			//그 아이디값을 받아서 userID인스턴스로 관리할 수 있도록 한다.
			userID = (String) session.getAttribute("userID");
		}
		%>
		<div class="main">
			<a href="#">Epicus</a>
		</div>
		<div class="menu">

			<ul class="menuul">
				<li class="menuli"><a href="#">홈</a></li>
				<li class="menuli"><a href="mycontent.jsp">내작품</a></li>
				<li class="menuli"><a href="#">게시판</a></li>
				<li class="menuli"><a href="#">공동작가</a></li>
				<li class="menuli"><a href="#">공모전</a></li>
				<%
				// 접속하기는 로그인이 되어있지 않은 경우만 나오게한다.
				if (userID == null) {
				%>

				<li class="menuli1"><a href="login.jsp">로그인</a></li>
				<li class="menuli1"><a>|</a></li>
				<li class="menuli1"><a href="join.jsp">회원가입</a></li>

				<%
				// 로그인이 되어있는 사람만 볼수 있는 화면
				} else {
				%>
				<li class="menuli"><a href="logoutAction.jsp">로그아웃</a></li>
				<%
				}
				%>
			</ul>
		</div>
	</header>
	<!-- 	장르선택 -->
	<div class="section1" id="section1">
		<div class="Select_genre">
			<h5 class="sub_title">글쓰기</h5>
			<h4 class="sub_title">내작품</h4>
		</div>
		<hr>
		<div class=retangle></div>
		<progress id="progress" max="100" value="0"> 10% </progress>
		<div class="Pro">
			<button class="select_G">1</button>
			<button class="G">2</button>
			<button class="K">3</button>
			<button class="Plane">4</button>
			<button class="B">5</button>
			<button class="P">6</button>
			<button class="I">7</button>
		</div>
		<div class="Pro_name">
			<h2 class="p1">장르</h2>
			<h2 class="p2">키워드</h2>
			<h2 class="p3">배경</h2>
			<h2 class="p4">인물</h2>
			<h2 class="p5">사건</h2>
			<h2 class="p6">집필하기</h2>
			<h2 class="p7">퇴고하기</h2>
		</div>
		<div class="Title_genre">
			<h5 class="GS">장르선택</h5>
			<hr>
			<h6 class="GS_etc">※ 2개 이상 선택 가능</h6>
		</div>
		<div class=retangle1></div>
		<div id="checkbox-container_1">
			<label><input type="checkbox" name="genres" value="추리">추리</label>
			<label><input type="checkbox" name="genres" value="과학">과학</label>
			<label><input type="checkbox" name="genres" value="공포">공포</label>
			<label><input type="checkbox" name="genres" value="스릴러">스릴러</label>
			<label><input type="checkbox" name="genres" value="판타지">판타지</label>
			<br>
			<br> 
			<label><input type="checkbox" name="genres" value="무협">무협</label>
			<label><input type="checkbox" name="genres" value="게임">게임</label> 
			<label><input type="checkbox" name="genres" value="우화">우화</label> 
			<label><input type="checkbox" name="genres" value="에세이">에세이</label> 
			<label><input type="checkbox" name="genres" value="로맨스">로맨스</label> 
			<br>
			<br> 
			<label><input type="checkbox" name="genres" value="모험">모험</label> 
			<label><input type="checkbox" name="genres" value="역사">역사</label> 
			<label><input type="checkbox" name="genres" value="사극">사극</label> 
			<label><input type="checkbox" name="genres" value="인문학">인문학</label> 
			<label><input type="checkbox" name="genres" value="자서전">자서전</label> 
			<br>
			<br> 
			<label><input type="checkbox" name="genres" value="일기">일기</label> 
			<label><input type="checkbox" name="genres" value="기타">기타</label> 
			<hr>
		</div>
		<div class="Next_Button1">
			<button onclick="goToScroll('section2')" class="Next">다음 ></button>
		</div>
		   </div>
	<!-- 	장르정리 -->
	<div class="section2" id="section2">
		<div class="Select_genre1">
			<h5 class="sub_title">글쓰기</h5>
			<h4 class="sub_title">내작품</h4>
		</div>
		<hr>
		<div class=retangle></div>
		<progress id="progress" max="100" value="0"> 10% </progress>
		<div class="Pro">
			<button class="select_G">1</button>
			<button class="G">2</button>
			<button class="K">3</button>
			<button class="Plane">4</button>
			<button class="B">5</button>
			<button class="P">6</button>
			<button class="I">7</button>
		</div>
		<div class="Pro_name">
			<h2 class="p1">장르</h2>
			<h2 class="p2">키워드</h2>
			<h2 class="p3">배경</h2>
			<h2 class="p4">인물</h2>
			<h2 class="p5">사건</h2>
			<h2 class="p6">집필하기</h2>
			<h2 class="p7">퇴고하기</h2>
		</div>
		<div class="Title_genre2">
			<h5 class="GS">장르정리</h5>
			<hr>
		</div>
		<div class=retangle2></div>
		<div id="checkbox-container_12">
			<textarea name="opinion" id="genre_opinion" cols="90" rows="5" oninput="update_genre()"></textarea>
			<hr>
		</div>
		<div class="Next_Button12">
			<button onclick="goToScroll('section1')" class="Before">< 이전</button>
			<button onclick="goToScroll('section3')" class="Next">다음 ></button>
		</div>
	</div>

	<!-- 	키워드선택 -->
	<div class="section3" id="section3">
		<div class="Select_genre3">
			<h5 class="sub_title">글쓰기</h5>
			<h4 class="sub_title">내작품</h4>
		</div>
		<hr>
		<div class=retangle></div>
		<progress id="progress" max="100" value="15"> 10% </progress>
		<div class="Pro">
			<button onclick="goToScroll('section1')" class="select_G">✔</button>
			<button class="G3">2</button>
			<button class="K">3</button>
			<button class="Plane">4</button>
			<button class="B">5</button>
			<button class="P">6</button>
			<button class="I">7</button>
		</div>
		<div class="Pro_name">
			<h2 class="p1">장르</h2>
			<h2 class="p23">키워드</h2>
			<h2 class="p3">배경</h2>
			<h2 class="p4">인물</h2>
			<h2 class="p5">사건</h2>
			<h2 class="p6">집필하기</h2>
			<h2 class="p7">퇴고하기</h2>
		</div>
		<div class="Title_genre3">
			<h5 class="GS">키워드선택</h5>
			<hr>
			<h6 class="GS_etc">※ 2개 이상 선택 가능</h6>
		</div>
		<div class=retangle13></div>
		<div id="checkbox-container_13">
			<label><input type="checkbox" name="keyword" value="가족">가족</label>
			<label><input type="checkbox" name="keyword" value="개그">개그</label>
			<label><input type="checkbox" name="keyword" value="기획">기획</label>
			<label><input type="checkbox" name="keyword" value="기회">기회</label>
			<label><input type="checkbox" name="keyword" value="귀환">귀환</label>
			<label><input type="checkbox" name="keyword" value="공격">공격</label>
			<label><input type="checkbox" name="keyword" value="꿈">꿈</label>
			<br>
			<br> 
			<label><input type="checkbox" name="keyword" value="추리">과제</label> 
			<label><input type="checkbox" name="keyword" value="추리">구걸</label> 
			<label><input type="checkbox" name="keyword" value="공범">공범</label> 
			<label><input type="checkbox" name="keyword" value="구원">구원</label> 
			<label><input type="checkbox" name="keyword" value="능력">능력</label> 
			<label><input type="checkbox" name="keyword" value="동물">동물</label> <label><input
				type="checkbox" name="keyword" value="데이트">데이트</label> <br>
			<br> 
			<label><input type="checkbox" name="keyword" value="추리">변화</label> 
			<label><input type="checkbox" name="keyword" value="추리">복수</label> <label>
			<input type="checkbox" name="keyword" value="불법">불법</label> 
			<label><input type="checkbox" name="keyword" value="비밀">비밀</label> 
			<label><input type="checkbox" name="keyword" value="범인">범인</label>
			<label><input type="checkbox" name="keyword" value="식물">식물</label> <label><input type="checkbox" name="keyword" value="스포츠">스포츠</label> <br>
			<br> 
			<label><input type="checkbox" name="keyword" value="추리">순수</label>
			<label><input type="checkbox" name="keyword" value="추리">사랑</label> 
			<label><input type="checkbox" name="keyword" value="사기">사기</label> 
			<label><input type="checkbox" name="keyword" value="생존">생존</label> 
			<label><input type="checkbox" name="keyword" value="요정">요정</label> 
			<label><input type="checkbox" name="keyword" value="암호">암호</label> 
			<label><input type="checkbox" name="keyword" value="외계인">외계인</label> <br>
			<br> 
			<label><input type="checkbox" name="keyword" value="추리">자유</label> 
			<label><input type="checkbox" name="keyword" value="추리">재벌</label> 
			<label><input type="checkbox" name="keyword" value="희생">희생</label> 
			<label><input type="checkbox" name="keyword" value="행성">행성</label> 
			<label><input type="checkbox" name="keyword" value="하늘">하늘</label> 
			<label><input type="checkbox" name="keyword" value="기타">기타 </label>
			<hr>
		</div>
		<div class="Next_Button13">
			<button onclick="goToScroll('section4')" class="Next">다음 ></button>
			<button onclick="goToScroll('section2')" class="Before3"><
				이전</button>
		</div>
		
	</div>
	<!-- 	키워드정리 -->
	<div class="section4" id="section4">
		<div class="Select_genre4">
			<h5 class="sub_title">글쓰기</h5>
			<h4 class="sub_title">내작품</h4>
		</div>
		<hr>
		<div class=retangle></div>
		<progress id="progress" max="100" value="15"> 10% </progress>
		<div class="Pro">
			<button onclick="goToScroll('section1')" class="select_G">✔</button>
			<button class="G3">2</button>
			<button class="K">3</button>
			<button class="Plane">4</button>
			<button class="B">5</button>
			<button class="P">6</button>
			<button class="I">7</button>
		</div>
		<div class="Pro_name">
			<h2 class="p1">장르</h2>
			<h2 class="p23">키워드</h2>
			<h2 class="p3">배경</h2>
			<h2 class="p4">인물</h2>
			<h2 class="p5">사건</h2>
			<h2 class="p6">집필하기</h2>
			<h2 class="p7">퇴고하기</h2>
		</div>
		<div class="Title_genre2">
			<h5 class="GS">키워드정리</h5>
			<hr>
		</div>
		<div class=retangle2></div>
		<div id="checkbox-container_12">
			<textarea name="opinion" id="keyword_opinion" cols="90" rows="5" oninput="update_keyword()"></textarea><br>
			<hr>
		</div>
		<div class="Next_Button12">
			<button onclick="goToScroll('section3')" class="Before">< 이전</button>
			<button onclick="goToScroll('section5')" class="Next">다음 ></button>
		</div>
	</div>
	<!-- 	배경선택(시간적배경) -->
	<div class="section5" id="section5">
		<div class="Select_genre3">
			<h5 class="sub_title">글쓰기</h5>
			<h4 class="sub_title">내작품</h4>
		</div>
		<hr>
		<div class=retangle></div>
		<progress id="progress" max="100" value="30"> 10% </progress>
		<div class="Pro">
			<button onclick="goToScroll('section1')" class="select_G">✔</button>
			<button onclick="goToScroll('section3')" class="G3">✔</button>
			<button class="K5">3</button>
			<button class="Plane">4</button>
			<button class="B">5</button>
			<button class="P">6</button>
			<button class="I">7</button>
		</div>
		<div class="Pro_name">
			<h2 class="p1">장르</h2>
			<h2 class="p23">키워드</h2>
			<h2 class="p35">배경</h2>
			<h2 class="p4">인물</h2>
			<h2 class="p5">사건</h2>
			<h2 class="p6">집필하기</h2>
			<h2 class="p7">퇴고하기</h2>
		</div>
		<div class="Title_genre5">
			<h5 class="GS">
	배경선택<span style="font-size:16px; margin-left : 6px;"><시간적배경></span>
			</h5>
			<hr>
			<h6 class="GS_etc">※ 2개 이상 선택 가능</h6>
		</div>
		<div class=retangle1></div>
		<div id="checkbox-container_1">
			<label><input type="checkbox" name="time" value="아침">아침</label>
			<label><input type="checkbox" name="time" value="점심">점심</label>
			<label><input type="checkbox" name="time" value="저녁">저녁</label>
			<label><input type="checkbox" name="time" value="과거">과거</label>
			<label><input type="checkbox" name="time" value="6.25전쟁">6.25전쟁</label>
			<br>
			<br> 
			<label><input type="checkbox" name="genres6" value="추리">미래</label> <label><input type="checkbox"
				name="genres7" value="추리">현재</label> <label><input
				type="checkbox" name="time" value="여름">여름</label> <label><input
				type="checkbox" name="time" value="가을">가을</label> <label><input
				type="checkbox" name="time" value="봄">봄</label> 
			<br>
			<br> 
			<label><input type="checkbox" name="time" value="추리">겨울</label> 
			<label><input type="checkbox" name="time" value="추리">조선</label> 
			<label><input type="checkbox" name="time" value="근대">근대</label> 
			<label><input type="checkbox" name="time" value="중세">중세</label> 
			<label><input type="checkbox" name="time" value="1980년대">1980년대</label>
			<br>
			<br> 
			<label><input type="checkbox" name="time" value="기타">기타 </label>

			<hr>
		</div>
		<div class="Next_Button15">
			<button onclick="goToScroll('section6')" class="Next">다음 ></button>
			<button onclick="goToScroll('section4')" class="Before3"><
				이전</button>
		</div>
	</div>
<!-- 	공간적배경 -->
<div class="section6" id="section6">
		<div class="Select_genre3">
			<h5 class="sub_title">글쓰기</h5>
			<h4 class="sub_title">내작품</h4>
		</div>
		<hr>
		<div class=retangle></div>
		<progress id="progress" max="100" value="30"> 10% </progress>
		<div class="Pro">
			<button onclick="goToScroll('section1')" class="select_G">✔</button>
			<button onclick="goToScroll('section3')" class="G3">✔</button>
			<button class="K5">3</button>
			<button class="Plane">4</button>
			<button class="B">5</button>
			<button class="P">6</button>
			<button class="I">7</button>
		</div>
		<div class="Pro_name">
			<h2 class="p1">장르</h2>
			<h2 class="p23">키워드</h2>
			<h2 class="p35">배경</h2>
			<h2 class="p4">인물</h2>
			<h2 class="p5">사건</h2>
			<h2 class="p6">집필하기</h2>
			<h2 class="p7">퇴고하기</h2>
		</div>
		<div class="Title_genre5">
			<h5 class="GS">배경선택<span style="font-size:16px; margin-left : 6px;"><공간적배경></span></h5>
			<hr>
			<h6 class="GS_etc">※ 2개 이상 선택 가능</h6>
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
			  <label><input type="checkbox" name="space" value="마트">마트</label> 
			  <label><input type="checkbox" name="space" value="강">강</label> 
			  <br><br> 
			  <label><input type="checkbox" name="space" value="호수">호수</label> 
			  <label><input type="checkbox" name="space" value="기타">기타</label>

			<hr>
		</div>
		<div class="Next_Button15">
			<button onclick="goToScroll('section7')" class="Next">다음 ></button>
			<button onclick="goToScroll('section5')" class="Before3"><
				이전</button>
		</div>
	</div>
<!-- 	배경정리 -->
<div class="section7" id="section7">
		<div class="Select_genre7">
			<h5 class="sub_title">글쓰기</h5>
			<h4 class="sub_title">내작품</h4>
		</div>
		<hr>
		<div class=retangle></div>
		<progress id="progress" max="100" value="30"> 10% </progress>
		<div class="Pro">
			<button onclick="goToScroll('section1')" class="select_G">✔</button>
			<button onclick="goToScroll('section3')" class="G3">✔</button>
			<button class="K5">3</button>
			<button class="Plane">4</button>
			<button class="B">5</button>
			<button class="P">6</button>
			<button class="I">7</button>
		</div>
		<div class="Pro_name">
			<h2 class="p1">장르</h2>
			<h2 class="p23">키워드</h2>
			<h2 class="p35">배경</h2>
			<h2 class="p4">인물</h2>
			<h2 class="p5">사건</h2>
			<h2 class="p6">집필하기</h2>
			<h2 class="p7">퇴고하기</h2>
		</div>
		<hr class = "hr1">
		<div class="Title_genre2">
			<h5 class="GS">배경정리</h5>
			<hr>
		</div>
		<div  class=retangle3 style= "overflow: auto;">
		<h5 class="background_1">1. 배경요소</h5>
		<h5 class="background_2">(1) 시간 : 소설에서 인물이 행동하고 사건이 일어나는 시간적 상황으로 시대적 요소나 계절적 요소가 여기에 포함</h5>
			<div id="checkbox-container_71">
				<textarea name="opinion" id="time_opinion" cols="90" rows="5" oninput="update_time()"></textarea>
			</div>
			<h5 class="background_3">(2) 공간 : 인물이 활동하고 사건이 일어나는 공간적인 무대로, 자연 환경이나 생활 환경 등을 의미하며 국가나 지역 등이 포함</h5>
			<div id="checkbox-container_71">
				<textarea name="opinion" id="space_opinion" cols="90" rows="5" oninput="update_space()"></textarea>
			</div>
		<h5 class="background_1">2. 배경의종류</h5>
		<h5 class="background_3">(1) 자연적 배경 : 주로 사건이 일어나는 구체적 시간과 공간</h5>
			<div id="checkbox-container_71">
				<textarea name="opinion" id="natural_opinion" cols="90" rows="5" oninput="update_natural()"></textarea>
			</div>
			<h5 class="background_3">(2) 사회적 배경 : 자연적 배경과 구별하여 소설 속에 나타난 사회 현실과 역사적 상황을 의미</h5>
			<div id="checkbox-container_71">
				<textarea name="opinion" id="social_opinion" cols="90" rows="5" oninput="update_social()"></textarea>
			</div>
			<h5 class="background_3">(3) 심리적 배경 : 인물의 심리 상황이나 독특한 내면 세계를 의미</h5>
			<div id="checkbox-container_71">
				<textarea name="opinion" id="psychological_opinion" cols="90" rows="5" oninput="update_psychological()"></textarea>
			</div>
			<h5 class="background_3">(4) 상황적 배경 : 인간의 실존적인 상황을 배경으로 설정하는 것</h5>
			<div id="checkbox-container_71">
				<textarea name="opinion" id="situational_opinion" cols="90" rows="5" oninput="update_situational()"></textarea>
			</div>
			<h5 class="background_1">3.기타</h5>
				<div id="checkbox-container_71">
					<textarea name="opinion" id="other_opinion" cols="90" rows="5" oninput="update_other()"></textarea>
				</div>
		</div>
		<div class="Next_Button16">
			<button onclick="goToScroll('section8')" class="Next">다음 ></button>
			<button onclick="goToScroll('section6')" class="Before3"><
				이전</button>
		</div>		
	</div>
<!-- 	인물정리 -->
<div class="section8" id="section8">
		<div class="Select_genre7">
			<h5 class="sub_title">글쓰기</h5>
			<h4 class="sub_title">내작품</h4>
		</div>
		<hr>
		<div class=retangle></div>
		<progress id="progress" max="100" value="45"> 10% </progress>
		<div class="Pro">
			<button onclick="goToScroll('section1')" class="select_G">✔</button>
			<button onclick="goToScroll('section3')" class="G3">✔</button>
			<button onclick="goToScroll('section5')" class="K5">✔</button>
			<button class="Plane8">4</button>
			<button class="B">5</button>
			<button class="P">6</button>
			<button class="I">7</button>
		</div>
		<div class="Pro_name">
			<h2 class="p1">장르</h2>
			<h2 class="p23">키워드</h2>
			<h2 class="p35">배경</h2>
			<h2 class="p48">인물</h2>
			<h2 class="p5">사건</h2>
			<h2 class="p6">집필하기</h2>
			<h2 class="p7">퇴고하기</h2>
		</div>
		<hr class = "hr1">
		<div class="Title_genre2">
			<h5 class="GS">인물목록</h5>
			<hr>
		</div>
		<button class="add" onclick="openPopup()" >추가</button>
		<div class=retangle4 style= "overflow: auto;">
		<ul id="nameList">
		</ul>
		</div>
		<div class="Next_Button16">
			<button onclick="goToScroll('section9')" class="Next">다음 ></button>
			<button onclick="goToScroll('section7')" class="Before3"><
				이전</button>
		</div>	
		<div id="popup" style="display: none;" "overflow: auto;">
		  <div  class=retangle5 style= "overflow: auto;">
		    <input type="text" id="nameInput" placeholder="이름을 입력하세요">
		    <input type="text" id="hobbyInput" placeholder="취미를 입력하세요">
		    <input type="text" id="birthdayInput" placeholder="생일을 입력하세요">
		    <button onclick="addPerson()">추가</button>
		    <button onclick="closePopup()">취소</button>
		  </div>
		 </div>
		 <div  class=retangle6 style= "overflow: auto;">
		  <div id="infoPopup" style="display: none;">
			    <h2 id="personName"></h2>
			    <p id="personHobby"></p>
			    <p id="personBirthday"></p>
			    <button onclick="closeInfoPopup()">닫기</button>
		  	</div>
		  </div>
		<script>
  var people = [];

  function openPopup() {
    document.getElementById("popup").style.display = "block";
  }

  function closePopup() {
    document.getElementById("popup").style.display = "none";
  }

  function addPerson() {
    var name = document.getElementById("nameInput").value;
    var hobby = document.getElementById("hobbyInput").value;
    var birthday = document.getElementById("birthdayInput").value;
    if (name !== "") {
      var person = {
        name: name,
        hobby: hobby,
        birthday: birthday
      };
      people.push(person);
      createPersonListItem(person);
      closePopup();
    }
  }

  function createPersonListItem(person) {
    var nameList = document.getElementById("nameList");
    var listItem = document.createElement("li");
    listItem.textContent = person.name;
    listItem.onclick = function () {
      showPersonInfo(person);
    };
    nameList.appendChild(listItem);
  }

  function showPersonInfo(person) {
    document.getElementById("personName").textContent = person.name;
    document.getElementById("personHobby").textContent = "취미: " + person.hobby;
    document.getElementById("personBirthday").textContent = "생일: " + person.birthday;
    document.getElementById("infoPopup").style.display = "block";
  }

  function closeInfoPopup() {
    document.getElementById("infoPopup").style.display = "none";
  }
  </script>	
	</div>
<!-- 사건설정 -->
<div class="section9" id="section9">
		<div class="Select_genre7">
			<h5 class="sub_title">글쓰기</h5>
			<h4 class="sub_title">내작품</h4>
		</div>
		<hr>
		<div class=retangle></div>
		<progress id="progress" max="100" value="65"> 10% </progress>
		<div class="Pro">
			<button onclick="goToScroll('section1')" class="select_G">✔</button>
			<button onclick="goToScroll('section3')" class="G3">✔</button>
			<button onclick="goToScroll('section5')" class="K5">✔</button>
			<button onclick="goToScroll('section8')" class="Plane8">✔</button>
			<button class="B9">5</button>
			<button class="P">6</button>
			<button class="I">7</button>
		</div>
		<div class="Pro_name">
			<h2 class="p1">장르</h2>
			<h2 class="p23">키워드</h2>
			<h2 class="p35">배경</h2>
			<h2 class="p48">인물</h2>
			<h2 class="p59">사건</h2>
			<h2 class="p6">집필하기</h2>
			<h2 class="p7">퇴고하기</h2>
		</div>
		<hr class = "hr1">
		<div class="Title_genre2">
			<h5 class="GS">사건설정</h5>
			<hr>
		</div>
		<div  class=retangle3 style= "overflow: auto;">
		<h5 class="background_1">1. 내면적사건</h5>
			<div id="checkbox-container_91">
				<textarea name="opinion" id="internal_opinion" cols="130" rows="5" oninput="update_internal()"></textarea><br>
			</div>
		<h5 class="background_1">2. 외면적사건</h5>
			<div id="checkbox-container_91">
				<textarea name="opinion" id="external_opinion" cols="130" rows="5" oninput="update_external()"></textarea>
			</div>
			<h5 class="background_1">3.복선</h5>
				<div id="checkbox-container_91">
					<textarea name="opinion" id="track_opinion" cols="130" rows="5" oninput="update_track()"></textarea>
				</div>
		</div>
		<div class="Next_Button16">
			<button onclick="goToScroll('section10')" class="Next">다음 ></button>
			<button onclick="goToScroll('section8')" class="Before3"><
				이전</button>
		</div>		
	</div>
<!-- 	집필하기 -->
	<div class="section10" id="section10">
		<div class="Select_genre7">
			<h5 class="sub_title">글쓰기</h5>
			<h4 class="sub_title">내작품</h4>
		</div>
		<hr>
		<div class=retangle></div>
		<progress id="progress" max="100" value="80"> 10% </progress>
		<div class="Pro">
			<button onclick="goToScroll('section1')" class="select_G">✔</button>
			<button onclick="goToScroll('section3')" class="G3">✔</button>
			<button onclick="goToScroll('section5')" class="K5">✔</button>
			<button onclick="goToScroll('section8')" class="Plane8">✔</button>
			<button onclick="goToScroll('section9')" class="B9">✔</button>
			<button class="P10">6</button>
			<button class="I">7</button>
		</div>
		<div class="Pro_name">
			<h2 class="p1">장르</h2>
			<h2 class="p23">키워드</h2>
			<h2 class="p35">배경</h2>
			<h2 class="p48">인물</h2>
			<h2 class="p59">사건</h2>
			<h2 class="p610">집필하기</h2>
			<h2 class="p7">퇴고하기</h2>
		</div>
		<hr class = "hr1">
		<div class="Title_genre2">
			<h5 class="GS">집필하기</h5>
			<hr>
		</div>
		<div  class=retangle3 style= "overflow: auto;">
		<h5 class="background_1">부재목</h5>
			<div id="checkbox-container_101">
				<textarea name="opinion" id="sub_opinion" cols="130" rows="5" oninput="update_sub()"></textarea>
			</div>
		<h5 class="background_1">사건요약</h5>
			<div id="checkbox-container_101">
				<textarea name="opinion" id="story_opinion" cols="130" rows="5" oninput="update_story()"></textarea>
			</div>
		</div>
		<div class="Next_Button16">
			<button onclick="goToScroll('section11')" class="Next">다음 ></button>
			<button onclick="goToScroll('section9')" class="Before3"><
				이전</button>
		</div>		
	</div>
		<div class="section11" id="section11">
		<div class="Select_genre7">
			<h5 class="sub_title">글쓰기</h5>
			<h4 class="sub_title">내작품</h4>
		</div>
		<hr>
		<div class=retangle></div>
		<progress id="progress" max="100" value="80"> 10% </progress>
		<div class="Pro">
			<button onclick="goToScroll('section1')" class="select_G">✔</button>
			<button onclick="goToScroll('section3')" class="G3">✔</button>
			<button onclick="goToScroll('section5')" class="K5">✔</button>
			<button onclick="goToScroll('section8')" class="Plane8">✔</button>
			<button onclick="goToScroll('section9')" class="B9">✔</button>
			<button class="P10">6</button>
			<button class="I">7</button>
		</div>
		<div class="Pro_name">
			<h2 class="p1">장르</h2>
			<h2 class="p23">키워드</h2>
			<h2 class="p35">배경</h2>
			<h2 class="p48">인물</h2>
			<h2 class="p59">사건</h2>
			<h2 class="p610">집필하기</h2>
			<h2 class="p7">퇴고하기</h2>
		</div>
		<hr class = "hr1">
		<div class="Title_genre2">
			<h5 class="GS">집필하기</h5>
			<hr>
		</div>
		<div  class=retangle3 style= "overflow: auto;">
			<h5 class="background_1">집필하기</h5>
				<div id="checkbox-container_111">
					<textarea name="opinion" id="main_opinion" cols="130" rows="10" oninput="main_track()"></textarea>
				</div>
		</div>
		<div class="Next_Button16">
			<button onclick="goToScroll('section12')" class="Next">다음 ></button>
			<button onclick="goToScroll('section10')" class="Before3"><
				이전</button>
		</div>
			<div class = "treeview" id = "treeview" style= "overflow: auto;">
				 	<div id="sidebar">
      		<div id="treeview-container">
				<h3>&ensp;&ensp; 마법사 트리뷰</h3>	
      			<ul>
      				<li><a href="#section1" id="scroll_move">장르</a>
        				<ul id="genres" />
      				</li>
      			</ul>
      		</div>
      		<div id="treeview-container">
      			<ul>
      				<li><a href="#section2" id="scroll_move">장르세부내용</a>
        				<ul id="genre_opinion_node"/>
        			</li>
        		</ul>
     		</div>
     
     		<div id="treeview-container"> 	
     			<ul id="treeview">
      				<li><a href="#section3" id="scroll_move">키워드</a>
        				<ul id="keyword" />
      				</li>
      			</ul>
      			</div>
      			<div id="treeview-container"> 	
      			<ul>
      				<li><a href="#section4" id="scroll_move">키워드세부내용</a>
        				<ul id="keyword_opinion_node"/>
        			</li>	
      			</ul>
      		</div>
      
      		<div id="treeview-container">	
      			<ul id="treeview">
      				<li><a href="#section5" id="scroll_move">시간적배경</a>
        				<ul id="time" />
      				</li>
      			</ul>
      			</div>
      			<div id="treeview-container"> 		
      			<ul>	
      				<li><a href="#section7" id="scroll_move">시간적세부내용</a>
        				<ul id="time_opinion_node"/>
        			</li>
      			</ul>
      		</div>
      
      		<div id="treeview-container">	
      			<ul id="treeview">
      				<li><a href="#section6" id="scroll_move">공간적배경</a>
        				<ul id="space" />
        			</li>
        		</ul>
        		</div>
        	<div id="treeview-container">	
        		<ul>		
        			<li><a href="#section7" id="scroll_move">공간적세부내용</a>
        				<ul id="space_opinion_node"/>
        			</li>
        		</ul>
			</div>
       		<div id="treeview-container">	
        		<ul>		
        			<li><a href="#section7" id="scroll_move">자연적배경</a>
        				<ul id="natural_opinion_node"/>
        			</li>
        		</ul>
       		</div> 
       		<div id="treeview-container">
        		<ul>		
        			<li><a href="#section2" id="scroll_move">사회적배경</a>
        				<ul id="social_opinion_node"/>
        			</li>
        		</ul>
       		</div>
      	 	<div id="treeview-container"> 
        		<ul>		
        			<li>심리적 배경
        				<ul id="psychological_opinion_node"/>
        			</li>
        		</ul>
       		</div>
       		<div id="treeview-container">
        		<ul>		
        			<li>상황적 배경
        				<ul id="situational_opinion_node"/>
        			</li>
        		</ul>
       		</div> 
       		<div id="treeview-container"> 
        		<ul>
        			<li>기타
        				<ul id="other_opinion_node"/>
        			</li>
        		</ul>
      		</div>
      
      		<div id="treeview-container">	
      			<ul>
      				<li>등장인물
        				<ul id="character" />
      				</li>
      			</ul>
      		</div>
      		<div id="treeview-container">	
      			<ul>
      				<li>내면적 사건
        				<ul id="internal_opinion_node" />
      				</li>
    			</ul>
    		</div>	
    		<div id="treeview-container">	
      			<ul>
      				<li>외면적 사건
        				<ul id="external_opinion_node" />
      				</li>
    			</ul>
    		</div>	
    		<div id="treeview-container">	
      			<ul>
      				<li>복선
        				<ul id="track_opinion_node" />
      				</li>
    			</ul>
    		</div>	
			   	</div>
    
  <script>
    var box = document.getElementById("treeview");
    var isMouseDown = false;
    var isExpanded = false;
    var startX, startY, startLeft, startTop, startWidth, startHeight;

    box.addEventListener("mousedown", function(event) {
      if (event.button === 2) {
        // Right-click
        if (!isExpanded) {
          box.style.width = 600 + "px";
          isExpanded = true;
        } else {
          box.style.width = 300 + "px";
          isExpanded = false;
        }
      }

      isMouseDown = true;
      startX = event.clientX;
      startY = event.clientY;
      startLeft = box.offsetLeft;
      startTop = box.offsetTop;
      startWidth = box.offsetWidth;
      startHeight = box.offsetHeight;
    });

    document.addEventListener("mousemove", function(event) {
      if (isMouseDown) {
        var offsetX = event.clientX - startX;
        var offsetY = event.clientY - startY;

        var newLeft = startLeft + offsetX;
        var newTop = startTop + offsetY;

        box.style.left = newLeft + "px";
        box.style.top = newTop + "px";
      }
    });

    document.addEventListener("mouseup", function() {
      isMouseDown = false;
    });
  </script>
  	</div>
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