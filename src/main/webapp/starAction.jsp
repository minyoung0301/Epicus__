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
    
    String userID = (String)session.getAttribute("userID");
    request.setCharacterEncoding("UTF-8");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = likeDAO.getConnection();
        if (conn != null) {
            int flike_count = 0;

            String sql = "select starID from star where s_freeID = ?  and s_userID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, freeID);
      
            pstmt.setString(2, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                // 중복 좋아요가 이미 존재하는 경우, 좋아요 취소
                sql = "update free set flike_count = flike_count - 1 where freeID = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, freeID);
                
                pstmt.executeUpdate();

                sql = "delete from star where s_freeID = ? and s_userID = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, freeID);
                pstmt.setString(2, userID);
                
                pstmt.executeUpdate();
            } else {
                // 중복 좋아요가 없는 경우, 좋아요 추가
                sql = "update free set flike_count = flike_count + 1 where freeID = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, freeID);
                
                pstmt.executeUpdate();

                sql = "insert into star(s_freeID, s_userID) values (?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, freeID);
                pstmt.setString(2, userID);
               
                pstmt.executeUpdate();
            }

            sql = "select flike_count from free where freeID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, freeID);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                flike_count = rs.getInt("flike_count");
                out.println(flike_count);
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
