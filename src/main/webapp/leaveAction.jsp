<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	  <%
        // MySQL 데이터베이스 연결 정보 설정
        String jdbcUrl = "jdbc:mysql://localhost:3306/epicus";
        String dbUser = "root";
        String dbPassword = "root";

        Connection connection = null;

        try {
            // MySQL 드라이버 로드
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 데이터베이스 연결
            connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // 회원 정보를 삭제하는 SQL 쿼리 작성 (예: users 테이블에서 회원 삭제)
            String deleteQuery = "DELETE FROM users WHERE userID = ?"; // 사용자명으로 삭제 예제

            // 쿼리를 실행하기 위한 PreparedStatement 생성
            PreparedStatement preparedStatement = connection.prepareStatement(deleteQuery);
            
            // 탈퇴할 사용자명을 받아옵니다. (예: 이 예제에서는 POST 방식으로 받아옵니다.)
            String usernameToDelete = request.getParameter("userID");

            // PreparedStatement에 파라미터 설정
            preparedStatement.setString(1, usernameToDelete);

            // 쿼리 실행
            int rowsDeleted = preparedStatement.executeUpdate();

            // 연결 종료
            preparedStatement.close();
            connection.close();

            // 삭제된 행이 있으면 회원 탈퇴 성공 메시지 표시
            if (rowsDeleted > 0) {
                out.println("<p>회원 탈퇴가 완료되었습니다.</p>");
            } else {
                out.println("<p>회원 탈퇴에 실패했습니다.</p>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    %>
</body>
</html>