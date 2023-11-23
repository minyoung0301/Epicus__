<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
    <%@ page import="java.sql.*" %>
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
	String followerID=request.getParameter("userID");
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/epicus?useUnicode=yes&characterEncoding=UTF-8", "root", "root");

        String sql = "SELECT followingID FROM follow where followerID=?";
        stmt = conn.prepareStatement(sql);
		stmt.setString(1,followerID);
        rs = stmt.executeQuery();
        request.setAttribute("resultSet", rs);
        
      
     
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 리소스 해제 코드
    }
%>
	
</body>
</html>