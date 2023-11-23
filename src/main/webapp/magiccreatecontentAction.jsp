<!-- 실제로 글쓰기를 눌러서 글을 작성해 주는 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 게시글을 작성할 수 있는 데이터베이스는 BbsDAO객체를 이용해서 다룰수 있기때문에 참조 -->	
<%@ page import="magic.magic"%>
<%@ page import ="java.text.ParseException"%>
	<%@ page import ="java.text.SimpleDateFormat"%>
	<%@ page import="java.sql.*, java.util.Date" %>

<%-- <%@ page import="test.freeDAO" %> --%>
    <%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter"%>
<!-- 자바 클래스 사용 -->

<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
%>

<%-- <jsp:useBean id="magic" class="magic.magic" scope="page" /> --%>
<%-- <jsp:setProperty name="magic" property ="magicID"/> --%>
<%-- <jsp:setProperty name="magic" property="mTitle" /> --%>
<%-- <jsp:setProperty name="magic" property="mInto" /> --%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jsp 게시판 웹사이트</title>

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

   // 이미지 업로드 처리C:\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\project_02\resources
  /*   Part filePart = request.getPart("image");
   String fileName = filePart.getSubmittedFileName();
   String image_path = "C:/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/webapps/testtest/images" + File.separator + fileName;
   filePart.write(image_path);  */
  	Part filePart = request.getPart("image");
   String fileName = filePart.getSubmittedFileName();

   // 프로젝트 내부의 디렉토리 경로 설정
   String projectPath = getServletContext().getRealPath("");
   String imagesDirectory = projectPath + File.separator + "images"; // 이미지를 저장할 디렉토리

   // 디렉토리가 존재하지 않으면 생성
   File directory = new File(imagesDirectory);
   if (!directory.exists()) {
       directory.mkdirs();
   }

   // 이미지 파일을 디렉토리에 저장
   String image_path = imagesDirectory + File.separator + fileName;
   filePart.write(image_path);


   // 게시물 데이터베이스에 저장
   String mTitle = request.getParameter("mTitle");
String mInto = request.getParameter("mInto");
String mDateStr = request.getParameter("mDate"); // 파라미터에서 문자열로 날짜 값을 가져옴

Timestamp mDate = null; // Timestamp 변수 선언

if (mDateStr != null && !mDateStr.isEmpty()) {
try {
   SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // 원하는 날짜 형식 지정
   Date parsedDate = dateFormat.parse(mDateStr); // 문자열을 Date 객체로 파싱
   mDate = new Timestamp(parsedDate.getTime()); // Timestamp로 변환
} catch (ParseException e) {
   // 날짜 파싱에 실패한 경우 예외 처리
   e.printStackTrace(); // 예외 처리 코드 작성
}
}

Date currentTime = new Date();
String insertQuery = "INSERT INTO magic (image_path,mTitle, userID, mInto, mDate, mAvailable, mopen) VALUES (?,?,?,?,?,?,?)";
pstmt = conn.prepareStatement(insertQuery);
pstmt.setString(1, image_path);
pstmt.setString(2, mTitle);
pstmt.setString(3, userID);
pstmt.setString(4, mInto);
pstmt.setTimestamp(5, mDate);
pstmt.setInt(6, 1);
pstmt.setInt(7, 0);


   
   
   
  
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