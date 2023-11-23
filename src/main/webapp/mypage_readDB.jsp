<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>최근 본 게시물</title>
</head>
<body>

   <%--  <ul>
        <% 
            try {
                // JDBC 연결 코드
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3305/epicus", "root", "root");

                // 사용자 ID 및 최근 본 게시물 목록 조회 쿼리 작성
                int userId = 1; // 사용자 ID를 여기에 설정
                String recentPostsQuery = "SELECT recent_post_id, timestamp FROM recent_posts WHERE user_id = ? ORDER BY timestamp DESC";
                PreparedStatement recentPostsStatement = conn.prepareStatement(recentPostsQuery);
                recentPostsStatement.setInt(1, userId);
                ResultSet recentPostsResultSet = recentPostsStatement.executeQuery();

                request.setAttribute("recentPostsResultSet", recentPostsResultSet);
                recentPostsStatement.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </ul> --%>
</body>
</html>
