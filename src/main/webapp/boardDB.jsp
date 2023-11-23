<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
    <%@ page import="java.sql.*" %>
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
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/epicus", "root", "root");

        String sql = "SELECT freeID, image_path, fTitle, userID, fInto, fDate, fAvailable,flike_count FROM free WHERE fopen=1";
        stmt = conn.prepareStatement(sql);
        
		
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