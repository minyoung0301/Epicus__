<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="test.free" %>
<%@ page import="java.util.ArrayList, java.util.List" %>

 <%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse" %> 
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	List<free> posts = new ArrayList<>();
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

		 Connection conn = null;
		    PreparedStatement stmt = null;
		    ResultSet rs = null;

		    //String image_path = "";

		    try {
		        Class.forName("com.mysql.cj.jdbc.Driver");
		        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/epicus", "root", "root");

		        String sql ="UPDATE free SET fopen = 0 WHERE freeID = ?";
		        stmt = conn.prepareStatement(sql);
		      
		        stmt.setString(1, userID);
		        rs = stmt.executeQuery();

		        while (rs.next()) {
		        	
		        	int freeID = rs.getInt("freeID");
		        	String fTitle = rs.getString("fTitle");
		        	String image_path = rs.getString("image_path");
		        	//String userID = rs.getString("userID");
		        	String fInto = rs.getString("fInto");
		        	Timestamp fDate =rs.getTimestamp("fDate");
					//String fDate= rs.getString("fDate");
		        	int fAvailable = rs.getInt("fAvailable");
		        	int fopen = rs.getInt("fopen");
		        	int flike_count = rs.getInt("flike_count");
		        	free post = new free(freeID,image_path,fTitle,userID,fInto,fDate,fAvailable,fopen,flike_count);
		        	posts.add(post);
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        if (rs != null) {
		            rs.close();
		        }
		        if (stmt != null) {
		            stmt.close();
		        }
		        if (conn != null) {
		            conn.close();
		        }
		    }
	%>
</body>
</html>