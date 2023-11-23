<%@page import="user.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 우리가 만든 페이지를 사용하기 위한 임폴트 -->
<%@ page import="user.UserDAO"%>
<!-- 자바스크립트 문장을 사용하기 위해 사용 -->
<%@ page import="java.io.PrintWriter"%>
<!-- 건너오는 데이터를 UTF-8로 받기위해 가져오는것 -->
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- 현재 페이지에서만 bean이 사용가능하게 해주는태그 -->
<jsp:useBean id="user" class="user.User" scope="page" />
<!-- 회원가입에는 javaBeans에 작성된 5가지 변수를 다 박아야 하기때문에 선언해준다.-->
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPwd" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userEmail" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP Web Site</title>
</head>
<body>
	<%
//로그인이 된 유저는 회원가입페이지를 들어 갈 수없게 만드는 소스를 작성한다.
	String userID = null;
	//세션을 확인해서 userID에 세션이 존재하는 회원들은
	if (session.getAttribute("userID") != null) {
		//userID에 해당 세션ID를 넣어준다.
		userID = (String) session.getAttribute("userID");
	}
	//이미 로그인이 된사람은 또 다시 로그인을 할수없게 막아주는 부분
	if (userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href = 'createcontent2.jsp'");
		script.println("</script>");
	}
	//입력 안된 부분이 있을 시 회원가입 시에 사용자가 입력을 안한 모든 경우의 수를 입력해서 조건을 걸어주고,
	if (user.getUserID() == null || user.getUserPwd() == null || user.getUserName() == null|| user.getUserEmail() == null) {
		//PrintWriter를 이용해서
		PrintWriter script = response.getWriter();
		script.println("<script>");
		//팝업을 띄워주고,
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		//다시 돌려보낸다.
		script.println("history.back()");
		script.println("</script>");
		//입력이 다 되었다면?
	} else {
		//UserDAO에서 만들었던 함수를 사용하기 위해서 인스턴스 생성
		UserDAO userDAO = new UserDAO();
		//userDAO에 있는 join함수 내의 각각의 변수들을 다입력 받아서 만들어진 user인스턴스가 join함수를 실행하도록 명령으로 넣어준것이다.
		int result = userDAO.join(user);
		//이 경우는 이미 해당아이디가 존재하는 경우밖에 없다. PRIMARY KEY로 userID를 줬기때문에,
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.');");
			script.println("history.back()");
			script.println("</script>");
			//정상적인 실행이 되었을때.
		} else {
			//*2.여기도 회원가입이 성공적으로 이루어진 해당사용자를 세션부여 해준다.
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			//메인페이지로 이동.
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
	}
	%>
</body>
</html>
