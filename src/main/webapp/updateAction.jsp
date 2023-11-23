<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="freetest.freecontent" %>

<%@ page import="java.io.PrintWriter"%>
 <%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse" %> 
<%@ page import="java.util.ArrayList, java.util.List" %>
<%@ page import="test.free"%>
 <%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
%>   


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
		
			
		Connection conn = null;
        PreparedStatement stmt = null;
        try {
            // 데이터베이스 연결 코드
            String url = "jdbc:mysql://localhost:3306/epicus";
            String user = "root";
            String password = "root";
            conn = DriverManager.getConnection(url, user, password);

            // 수정할 글의 ID 및 새로운 제목과 내용을 파라미터로 받음
            int freeID = Integer.parseInt(request.getParameter("freeID"));
            int number = Integer.parseInt(request.getParameter("number"));
            String summary = request.getParameter("summary");
            String story = request.getParameter("story");
            String subtitle = request.getParameter("subtitle");
            // SQL 쿼리를 작성하여 글 정보 업데이트
            String sql = "UPDATE freecontent SET subtitle=?, summary= ?, story = ? WHERE freeID = ? and number=?";
            stmt = conn.prepareStatement(sql);
           
            stmt.setString(1, subtitle);
            stmt.setString(2, summary);
            stmt.setString(3, story);
            stmt.setInt(4, freeID);
            stmt.setInt(5, number);

            // 쿼리 실행
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                out.println("글이 수정되었습니다.");
            } else {
                out.println("글 수정 실패.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 연결 및 리소스 닫기
            try { stmt.close(); } catch (Exception e) { }
            try { conn.close(); } catch (Exception e) { }
        }
	%>

</body>
</html>