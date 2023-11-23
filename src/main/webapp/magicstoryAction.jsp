<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <%@ page import="magic.magiccontent" %>
    <%@ page import="magic.magic" %>
    <%@ page import="magic.characters" %>
   <%@ page import ="java.text.ParseException"%>
   <%@ page import ="java.text.SimpleDateFormat"%>
   <%@ page import="java.sql.*, java.util.Date" %>
       <%@ page import="java.util.ArrayList, java.util.List" %>

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
</head>
<body>
   <% 
      String userID = null;
      if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
         userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.
      }
      
      int magicID = Integer.parseInt(request.getParameter("magicID"));
      
      Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;

         
         try {
              Class.forName("com.mysql.cj.jdbc.Driver");
             conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/epicus", "root", "root");

             // 이미지 업로드 처리
//               Part filePart = request.getPart("image");
//                String fileName = filePart.getSubmittedFileName();
//                String image_path = "C:\\images" + File.separator + fileName;
//                filePart.write(image_path);

             // 게시물 데이터베이스에 저장
         

             String genres  = request.getParameter("genres");
            String genre_opinion   = request.getParameter("genre_opinion");
            String keyword = request.getParameter("keyword");
            String keyword_opinion = request.getParameter("keyword_opinion");
            String time = request.getParameter("time");
            String space = request.getParameter("space");
            String time_opinion = request.getParameter("time_opinion");
            String space_opinion = request.getParameter("space_opinion");
            String natural_opinion = request.getParameter("natural_opinion");
            String social_opinion = request.getParameter("social_opinion");
            String psychological_opinion = request.getParameter("psychological_opinion");
            String situational_opinion = request.getParameter("situational_opinion");
            String other_opinion = request.getParameter("other_opinion");
            
            String internal_opinion = request.getParameter("internal_opinion");
            String external_opinion = request.getParameter("external_opinion");
            String track_opinion = request.getParameter("track_opinion");
            String sub_opinion = request.getParameter("sub_opinion");
            String story_opinion = request.getParameter("story_opinion");
            String main_opinion = request.getParameter("main_opinion");
            String mDateStr = request.getParameter("magicDate");
            int roundID = Integer.parseInt(request.getParameter("roundID"));
            int character_id = Integer.parseInt(request.getParameter("character_id"));
            Timestamp magicDate  = null; // Timestamp 변수 선언
            
            if (mDateStr != null && !mDateStr.isEmpty()) {
                      try {
                          SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // 원하는 날짜 형식 지정
                          Date parsedDate = dateFormat.parse(mDateStr); // 문자열을 Date 객체로 파싱
                          magicDate  = new Timestamp(parsedDate.getTime()); // Timestamp로 변환
                      } catch (ParseException e) {
                          // 날짜 파싱에 실패한 경우 예외 처리
                          e.printStackTrace(); // 예외 처리 코드 작성
                      }

                   }else{
                       magicDate= new Timestamp(System.currentTimeMillis());
                   }
            
            Date currentTime = new Date();
            String insertQuery = "INSERT INTO magiccontent (magicID, roundID, genres, genre_opinion, keyword,keyword_opinion, time, space,time_opinion,space_opinion,natural_opinion,social_opinion,psychological_opinion,situational_opinion,other_opinion,internal_opinion,external_opinion,track_opinion,sub_opinion,story_opinion,main_opinion,like_count,userID,magicDate,Available,magiccheck,hit,character_id) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                  pstmt = conn.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
                  pstmt.setInt(1,magicID);
                  pstmt.setInt(2,roundID);
                  pstmt.setString(3,genres);
                  pstmt.setString(4,genre_opinion);
                  pstmt.setString(5,keyword);
                  
                  pstmt.setString(6,keyword_opinion);
                  pstmt.setString(7,time);
                  pstmt.setString(8,space);
                  pstmt.setString(9,time_opinion);
                  pstmt.setString(10,space_opinion);
            
                  pstmt.setString(11,natural_opinion);
                  pstmt.setString(12,social_opinion);
                  pstmt.setString(13,psychological_opinion);
                  pstmt.setString(14,situational_opinion);
                  pstmt.setString(15,other_opinion);
                  
                  pstmt.setString(16,internal_opinion);
                  pstmt.setString(17,external_opinion);
                  pstmt.setString(18,track_opinion);
                  pstmt.setString(19,sub_opinion);
                  pstmt.setString(20,story_opinion);
                  
                  pstmt.setString(21,main_opinion);
                  pstmt.setInt(22,0);
                  pstmt.setString(23,userID);
                  pstmt.setTimestamp(24,magicDate);
                  pstmt.setInt(25,1);
                  
                  pstmt.setInt(26,1);
                  pstmt.setInt(27,0);
                  pstmt.setInt(28,character_id);

                pstmt.executeUpdate();
                
                
            
               
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