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
    int magicID = Integer.parseInt(request.getParameter("magicID"));
    
    String userID = (String)session.getAttribute("userID");
    request.setCharacterEncoding("UTF-8");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = likeDAO.getConnection();
        if (conn != null) {
            int mlike_count = 0;

            String sql = "select mstarID from mstar where s_magicID = ?  and s_muserID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, magicID);
      
            pstmt.setString(2, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                // 중복 좋아요가 이미 존재하는 경우, 좋아요 취소
                sql = "update magic set mlike_count =  mlike_count - 1 where magicID = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, magicID);
                
                pstmt.executeUpdate();

                sql = "delete from mstar where s_magicID = ? and s_muserID = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, magicID);
                pstmt.setString(2, userID);
                
                pstmt.executeUpdate();
            } else {
                // 중복 좋아요가 없는 경우, 좋아요 추가
                sql = "update magic set mlike_count = mlike_count + 1 where magicID = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, magicID);
                
                pstmt.executeUpdate();

                sql = "insert into mstar(s_magicID, s_muserID) values (?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, magicID);
                pstmt.setString(2, userID);
               
                pstmt.executeUpdate();
            }

            sql = "select mlike_count from magic where magicID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, magicID);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
               /*  mlike_count = rs.getInt("mlike_count");
                out.println(mlike_count); */
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
