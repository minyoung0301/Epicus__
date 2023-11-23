<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
    <%@ page import="ccomment.Comment" %>
  <%@ page import="java.sql.*" %>   
<%@page import="java.sql.Timestamp"%>
<%@ page import="java.io.PrintWriter"%>
	<%@ page import ="java.text.ParseException"%>
	<%@ page import ="java.text.SimpleDateFormat"%>
	<%@ page import="java.sql.*, java.util.Date" %>

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
	int freeID = 0;
	if (request.getParameter("freeID") != null) {

freeID = Integer.parseInt(request.getParameter("freeID"));
	} 
	int number = 0;

	if (request.getParameter("number") != null) {
//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다. 다음과 같이 정수형으로 변환시켜준다.
number = Integer.parseInt(request.getParameter("number"));
	}
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String commentText = request.getParameter("commentText");
	String jdbcUrl = "jdbc:mysql://localhost:3306/epicus";
	String jdbcUser = "root";
	String jdbcPassword = "root";
	String userID = null;
	if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
		userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.
	}

	
	try {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);
	    String commentDateStr = request.getParameter("commentDate"); // 파라미터에서 문자열로 날짜 값을 가져옴
		Timestamp commentDate = null; // Timestamp 변수 선언

	if (commentDateStr != null && !commentDateStr.isEmpty()) {
	    try {
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // 원하는 날짜 형식 지정
	        Date parsedDate = dateFormat.parse(commentDateStr); // 문자열을 Date 객체로 파싱
	        commentDate = new Timestamp(parsedDate.getTime()); // Timestamp로 변환
	    } catch (ParseException e) {
	        // 날짜 파싱에 실패한 경우 예외 처리
	        e.printStackTrace(); // 예외 처리 코드 작성
	    }
	} else {
	    // fDate 파라미터가 없는 경우, 기본값을 설정하거나 다른 처리를 수행
	    // 여기서는 기본값을 null 대신 현재 시간으로 설정하는 예제
	    commentDate = new Timestamp(System.currentTimeMillis());
	}

	Date currentTime = new Date();
	    String insertQuery = "INSERT INTO comment(freeID,number,userID,commentDate,commentText,cAvailable) VALUES (?,?,?,?,?,?)";
	    pstmt = conn.prepareStatement(insertQuery);
	    pstmt.setInt(1, freeID);
	    pstmt.setInt(2,number);
	    pstmt.setString(3,userID);
	    pstmt.setTimestamp(4, commentDate);
	    pstmt.setString(5, commentText);
	    pstmt.setInt(6,1);
	    pstmt.executeUpdate();
	    
	    conn.close();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		   // 리소스 해제
		   if (rs != null) rs.close();
		   if (pstmt != null) pstmt.close();
		   if (conn != null) conn.close();
		} 
	
	%>
		
		

	
</body>
</html>