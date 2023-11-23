<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="magic.magiccontent" %>

<%@ page import="magic.magiccontentDAO" %>
    <%@ page import="magic.magic" %>
<%@ page import="magic.magicshowDAO" %>
<%@ page import="magic.magicDAO" %>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<%
	String userID = null;
			if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
		userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.
			}
			if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
			} 
			int freeID = 0;
			//view페이지에서 넘겨준 bbsID를 들고오는 소스 코드
			if (request.getParameter("freeID") != null) {
		//받은 bbsID를 정수형으로 반환해서 bbsID 인스턴스에 저장
		freeID = Integer.parseInt(request.getParameter("freeID"));
			}
			int magicID = 0;
			//view페이지에서 넘겨준 bbsID를 들고오는 소스 코드
			if (request.getParameter("magicID") != null) {
		//받은 bbsID를 정수형으로 반환해서 bbsID 인스턴스에 저장
		magicID = Integer.parseInt(request.getParameter("magicID"));
			}
			
			//bbsID가 제대로 들어오지 않았다면,
			if (freeID == 0) {
		//다시 게시판 메인 페이지로 돌려보낸다.
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글 입니다.')");
		script.println("location.href = 'magicmycontent.jsp'");
		script.println("</script>");
			}
			//현재 작성한 글이 작성자가 일치하는지 확인해주는 소스코드 작성
			//만약 userID와 뷰페이지에서 넘겨받은 bbsID값을 가지고 해당 글을 가져온 후
			magic magic  = new magicshowDAO().getmagic(magicID);
			//실제로 이 글의 작성자가 일치하는지 비교해준다. userID는 세션에 있는 값이고, bbs.getUserID는 이글을 작성한 사람의 값이다.
			if (!userID.equals(magic.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		//동일하지 않다면 오류를 출력해 돌려보내준다.
		script.println("location.href = 'magicmycontent'.jsp'");
		script.println("</script>");				
			//성공적으로 권한이 있는사람이라면 넘어간다.
			}else {
		//*글을 삭제하는 소스코드를 작성하는 부분!!!
		magicshowDAO freeshowDAO = new magicshowDAO();
		//삭제의 경우 간단하게 해당 bbsID만 delete함수에 매개변수로 넣어주면 된다.
		int result = freeshowDAO.open(freeID);
		//삭제 실패시.
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 공개에 실패했습니다')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			//성공한경우 다시 게시판 메인화면으로 돌아갈 수 있게 해준다.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 공개에 성공했습니다')");
			script.println("location.href='board.jsp'");
			//script.println("history.back()");
			script.println("</script>");
			}
		}
	%>
	
</body>
</html>