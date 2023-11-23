<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="UTF-8"%>

    <%@ page import="freetest.freecontent" %>
    <%@ page import="test.free" %>
	<%@ page import ="java.text.ParseException"%>
	<%@ page import ="java.text.SimpleDateFormat"%>
	<%@ page import="java.sql.*, java.util.Date" %>
	    <%@ page import="java.util.ArrayList, java.util.List" %>

<%-- <%@ page import="test.freeDAO" %> --%>
    <%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter"%>

 <%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
%>   
    





<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- <%
	System.out.println(freetest);
%> --%>
</head>
<body>
	<%
	
		String userID = null;
		if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
			userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.
		}
	    int freeID = Integer.parseInt(request.getParameter("freeID"));

		
		 Connection conn = null;
		   PreparedStatement pstmt = null;
		   ResultSet rs = null;
		   String dbUrl ="jdbc:mysql://localhost:3306/epicus";
		   String dbUser = "root";
		   String dbPassword = "root";

			



		   try {
		       Class.forName("com.mysql.cj.jdbc.Driver");
		       conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

		       // 이미지 업로드 처리
		       Part filePart = request.getPart("image");
		       String fileName = filePart.getSubmittedFileName();
		       String image_path = "C:\\images" + File.separator + fileName;
		       filePart.write(image_path);

		       // 게시물 데이터베이스에 저장
		   

		       String subtitle  = request.getParameter("subtitle");
				String summary   = request.getParameter("summary");
				String story = request.getParameter("story");
				String fDateStr = request.getParameter("freeDate "); // 파라미터에서 문자열로 날짜 값을 가져옴
				int roundID = Integer.parseInt(request.getParameter("roundID"));
				Timestamp freeDate  = null; // Timestamp 변수 선언
			


				if (fDateStr != null && !fDateStr.isEmpty()) {
				    try {
				        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // 원하는 날짜 형식 지정
				        Date parsedDate = dateFormat.parse(fDateStr); // 문자열을 Date 객체로 파싱
				        freeDate = new Timestamp(parsedDate.getTime()); // Timestamp로 변환
				    } catch (ParseException e) {
				        // 날짜 파싱에 실패한 경우 예외 처리
				        e.printStackTrace(); // 예외 처리 코드 작성
				    }
				} else {
				    // fDate 파라미터가 없는 경우, 기본값을 설정하거나 다른 처리를 수행
				    // 여기서는 기본값을 null 대신 현재 시간으로 설정하는 예제
				    freeDate = new Timestamp(System.currentTimeMillis());
				}
					Date currentTime = new Date();
					String insertQuery = "INSERT INTO freecontent (freeID, roundID, subtitle, summary, story,like_count, userID, available,freecheck,freeDate,hit,image_path) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
					pstmt = conn.prepareStatement(insertQuery);
					pstmt.setInt(1,freeID);
					pstmt.setInt(2,roundID);
					pstmt.setString(3,subtitle);
					
					pstmt.setString(4,summary);
					pstmt.setString(5,story);
					pstmt.setInt(6,0);
					pstmt.setString(7,userID);
					pstmt.setInt(8,1);
					
					pstmt.setInt(9,1);
					pstmt.setTimestamp(10,freeDate);
					
					pstmt.setInt(11,0);
					pstmt.setString(12,image_path);
					

		       
		       
		       
		      
		       pstmt.executeUpdate();

		       // 성공 응답
		      
		   } catch (Exception e) {
		       e.printStackTrace();
		       // 실패 응답
		       response.getWriter().write("Error");
		   } finally {
		       // 리소스 해제
		       if (rs != null) rs.close();
		       if (pstmt != null) pstmt.close();
		       if (conn != null) conn.close();
		   } 
		 
		 





			%>
		
		

	
</body>
</html>