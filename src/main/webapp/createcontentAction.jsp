<!-- 실제로 글쓰기를 눌러서 글을 작성해 주는 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import ="test.free" %>
	<%@ page import ="java.text.ParseException"%>
	<%@ page import ="java.text.SimpleDateFormat"%>
	<%@ page import="java.sql.*, java.util.Date" %>

    <%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter"%>
<!-- 자바 클래스 사용 -->

<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jsp 게시판 웹사이트</title>
<%-- <%
	System.out.println(test);
%> --%> 
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

  	/* Part filePart = request.getPart("image");
   String fileName = filePart.getSubmittedFileName();
   String projectPath = getServletContext().getRealPath("");
   String imagesDirectory = projectPath + File.separator + "images"; // 이미지를 저장할 디렉토리

   // 디렉토리가 존재하지 않으면 생성
   File directory = new File(imagesDirectory);
   if (!directory.exists()) {
       directory.mkdirs();
   }

   // 이미지 파일을 디렉토리에 저장
   String image_path = imagesDirectory + File.separator + fileName;
   filePart.write(image_path); */
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
    String fTitle = request.getParameter("fTitle");
	String fInto = request.getParameter("fInto");
	String fDateStr = request.getParameter("fDate"); // 파라미터에서 문자열로 날짜 값을 가져옴
	Timestamp fDate = null; // Timestamp 변수 선언

if (fDateStr != null && !fDateStr.isEmpty()) {
    try {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // 원하는 날짜 형식 지정
        Date parsedDate = dateFormat.parse(fDateStr); // 문자열을 Date 객체로 파싱
        fDate = new Timestamp(parsedDate.getTime()); // Timestamp로 변환
    } catch (ParseException e) {
        // 날짜 파싱에 실패한 경우 예외 처리
        e.printStackTrace(); // 예외 처리 코드 작성
    }
} else {
    // fDate 파라미터가 없는 경우, 기본값을 설정하거나 다른 처리를 수행
    // 여기서는 기본값을 null 대신 현재 시간으로 설정하는 예제
    fDate = new Timestamp(System.currentTimeMillis());
}

Date currentTime = new Date();
String insertQuery = "INSERT INTO free (image_path,fTitle, userID, fInto, fDate, fAvailable, fopen,flike_count) VALUES (?,?,?,?,?,?,?,?)";
pstmt = conn.prepareStatement(insertQuery);
pstmt.setString(1, image_path);
pstmt.setString(2, fTitle);
pstmt.setString(3, userID);
pstmt.setString(4, fInto);
pstmt.setTimestamp(5, fDate);
pstmt.setInt(6, 1);
pstmt.setInt(7, 0);
pstmt.setInt(8,0);


   
   
   
  
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