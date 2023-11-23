<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="freetest.freecontent" %>
 <%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	 Connection conn = null;
    PreparedStatement stmt = null;
    try {
        // 데이터베이스 연결 코드
        String url = "jdbc:mysql://localhost:3306/epicus";
        String user = "root";
        String password = "root";
        conn = DriverManager.getConnection(url, user, password);

        // 삭제할 글 ID를 파라미터로 받음
        int freeID = Integer.parseInt(request.getParameter("freeID"));
        int number = Integer.parseInt(request.getParameter("number"));

        // SQL 쿼리를 작성
        String sql = "DELETE FROM freecontent WHERE freeID = ? and number =?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, freeID);
        stmt.setInt(2, number);

        // 쿼리 실행
        int rowsAffected = stmt.executeUpdate();

        // 삭제 결과에 따라 메시지 출력
        if (rowsAffected > 0) {
            out.println("글이 삭제되었습니다.");
        } else {
            out.println("글 삭제 실패.");
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