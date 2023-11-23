<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import ="magic.characters" %>
	<%@ page import ="java.text.ParseException"%>
	<%@ page import ="java.text.SimpleDateFormat"%>
	<%@ page import="java.sql.*, java.util.Date" %>
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
// 데이터베이스 연결 설정
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String dbUrl ="jdbc:mysql://localhost:3306/epicus";
String dbUser = "root";
String dbPassword = "root";

String userID = null;
if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
	userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.
}
try {
	   Class.forName("com.mysql.cj.jdbc.Driver");
	   conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
	   Part filePart = request.getPart("image");
	   String fileName = filePart.getSubmittedFileName();
	   //절대경로로 잡기
	   String imagesDirectory ="C:/Users/sms07/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/Epicus__//image";
	/*    String imagesDirectory = "C:/Users/sms07/eclipse-workspace/Epicus__/src/main/webapp/image";  */// 프로젝트 내의 images 디렉토리 경로 얻기

	   // 디렉토리가 존재하지 않으면 생성
	   File directory = new File(imagesDirectory);
	   if (!directory.exists()) {
	       directory.mkdirs();
	   }

	   // 이미지 파일을 디렉토리에 저장
	   String image_path = imagesDirectory + File.separator + fileName;
	   filePart.write(image_path);


   // 게시물 데이터베이스에 저장
   //String image_path = request.getParameter("image_path");
   String explanationInput = request.getParameter("explanationInput");
   	String name = request.getParameter("name");
	String placeInput = request.getParameter("placeInput");
	String ageInput = request.getParameter("ageInput");
	String residenceInput = request.getParameter("residenceInput");
	
	String genderInput = request.getParameter("genderInput");
	String jobInput = request.getParameter("jobInput");
	String birthdayInput = request.getParameter("birthdayInput");
	String nicknameInput = request.getParameter("nicknameInput");
	String personalityInput = request.getParameter("personalityInput");
	
	String appearanceInput = request.getParameter("appearanceInput");
	String talentInput = request.getParameter("talentInput");
	String advantageInput = request.getParameter("advantageInput");
	String roleInput = request.getParameter("roleInput");
	String hobbyInput = request.getParameter("hobbyInput");
	
	String etcInput = request.getParameter("etcInput");

String insertQuery = "INSERT INTO characters (userID, image_path, explanationInput,name, placeInput,ageInput,residenceInput,genderInput,jobInput,birthdayInput,nicknameInput,personalityInput,appearanceInput,talentInput,advantageInput,roleInput,hobbyInput,etcInput) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	pstmt = conn.prepareStatement(insertQuery);
	pstmt.setString(1, userID);
	pstmt.setString(2, image_path);
	pstmt.setString(3, explanationInput);
	pstmt.setString(4, name);
	pstmt.setString(5, placeInput);
	pstmt.setString(6, ageInput);
	pstmt.setString(7, residenceInput);
	pstmt.setString(8, genderInput);
	pstmt.setString(9, jobInput);
	pstmt.setString(10, birthdayInput);
	pstmt.setString(11, nicknameInput);
	pstmt.setString(12, personalityInput);
	pstmt.setString(13, appearanceInput);
	pstmt.setString(14, talentInput);
	pstmt.setString(15, advantageInput);
	pstmt.setString(16, roleInput);
	pstmt.setString(17, hobbyInput);
	pstmt.setString(18, etcInput);

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