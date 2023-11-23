<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="like.likeDAO" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <%
    int freeID = Integer.parseInt(request.getParameter("freeID"));
    int number = Integer.parseInt(request.getParameter("number"));
    String userID = (String)session.getAttribute("userID");
    request.setCharacterEncoding("UTF-8");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = likeDAO.getConnection();
        if (conn != null) {
            int like_count = 0;

            String sql = "select likeID from likes where li_freeID = ? and li_number = ? and li_userID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, freeID);
            pstmt.setInt(2, number);
            pstmt.setString(3, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                // 중복 좋아요가 이미 존재하는 경우, 좋아요 취소
                sql = "update freecontent set like_count = like_count - 1 where freeID = ? and number = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, freeID);
                pstmt.setInt(2, number);
                pstmt.executeUpdate();

                sql = "delete from likes where li_freeID = ? and li_userID = ? and li_number = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, freeID);
                pstmt.setString(2, userID);
                pstmt.setInt(3, number);
                pstmt.executeUpdate();
            } else {
                // 중복 좋아요가 없는 경우, 좋아요 추가
                sql = "update freecontent set like_count = like_count + 1 where freeID = ? and number = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, freeID);
                pstmt.setInt(2, number);
                pstmt.executeUpdate();

                sql = "insert into likes(li_freeID, li_userID, li_number) values (?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, freeID);
                pstmt.setString(2, userID);
                pstmt.setInt(3, number);
                pstmt.executeUpdate();
            }

            sql = "select like_count from freecontent where freeID = ? and number = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, freeID);
            pstmt.setInt(2, number);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                like_count = rs.getInt("like_count");
                out.println(like_count);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            // ResultSet, PreparedStatement, Connection 닫기
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    %>
</body>
</html>
