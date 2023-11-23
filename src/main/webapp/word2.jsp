<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" --%>
<%--     pageEncoding="UTF-8"%> --%>
        <%@ page import="test.free" %>

<%@ page import="freetest.freecontent" %>
<%@ page import="java.util.ArrayList, java.util.List" %>

 <%@ page import="java.sql.*" %>    
    <%@ page language="java" contentType="application/vnd.word;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	response.setHeader("Content-Disposition", "attachment;filename=member.doc");
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setContentType("application/vnd.ms-word");

	List<free> posts = new ArrayList<>();
	List<freecontent> posts2 = new ArrayList<>();
	int freeID = Integer.parseInt(request.getParameter("freeID"));
	int number = 0;
	//만약에 매개변수로 넘어온 bbsID라는 매개변수가 존재 할 시 
	//(이 매개변수는 bbs.jsp에서 view로 이동하는 a태그에서 넘겨준 값이다.)
	if (request.getParameter("number") != null) {
		//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다. 다음과 같이 정수형으로 변환시켜준다.
		number = Integer.parseInt(request.getParameter("number"));
	}
	String userID = null;
	if (session.getAttribute("userID") != null)
	{
	    userID = (String)session.getAttribute("userID");
	}


Connection conn = null;
PreparedStatement stmt1 = null;
PreparedStatement stmt2 = null;
ResultSet rs = null;
ResultSet rs2 = null;


try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/epicus", "root", "root");

    // 첫 번째 SQL 문장
    String sql1 = "SELECT image_path,fTitle,fInto,fDate,fAvailable, fopen,flike_count FROM free WHERE userID = ? and freeID=?";
    stmt1 = conn.prepareStatement(sql1);
    stmt1.setString(1, userID);
    stmt1.setInt(2,freeID);
   

    rs = stmt1.executeQuery();

    while (rs.next()) {
     	//int freeID = rs.getInt("freeID");
    	String fTitle = rs.getString("fTitle");
    	String image_path = rs.getString("image_path");
    	
    	//String userID = rs.getString("userID");
    	String fInto = rs.getString("fInto");
		//String fDate= rs.getString("fDate");
    	int fAvailable = rs.getInt("fAvailable");
    	int fopen = rs.getInt("fopen");
		Timestamp fDate =rs.getTimestamp("fDate");
    	int flike_count = rs.getInt("flike_count");
    	free post = new free(freeID,image_path,fTitle,userID,fInto,fDate,fAvailable,fopen,flike_count);
     	posts.add(post);
    }

    // 두 번째 SQL 문장
    String sql2 = "SELECT roundID,subtitle,summary,story,like_count,freeDate,Available,freecheck,hit,image_path FROM freecontent WHERE freeID=? and number=?";
    stmt2 = conn.prepareStatement(sql2);
    
    stmt2.setInt(1, freeID);
    stmt2.setInt(2, number);
    

    rs2 = stmt2.executeQuery();

    while (rs2.next()) {
    	int roundID = rs2.getInt("roundID");
    	String subtitle = rs2.getString("subtitle");
    	String summary = rs2.getString("summary");
    	String story = rs2.getString("story");
    	Timestamp freeDate =rs2.getTimestamp("freeDate");
    	int available = rs2.getInt("available");
    	int freecheck = rs2.getInt("freecheck");
   		//int number = rs2.getInt("number");
    	int hit = rs2.getInt("hit");
    	int like_count = rs2.getInt("like_count");
    	String image_path = rs2.getString("image_path");
    	freecontent post2 = new freecontent(freeID,roundID,number,subtitle,summary,story,like_count,userID,freeDate,available,freecheck,hit,image_path);
        
    	posts2.add(post2);
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    // 리소스 해제
    if (rs != null) {
        rs.close();
    }
    if (rs2 != null) {
        rs2.close();
    }
    if (stmt1 != null) {
        stmt1.close();
    }
    if (stmt2 != null) {
        stmt2.close();
    }
    if (conn != null) {
        conn.close();
    }

}
%>
<%	
	

for(free post: posts){
	//int freeID = post.getFreeID();
    String fTitle = post.getfTitle();
    String fInto = post.getfInto();
    String image_path = post.getImage_path();
    
    for(freecontent post2: posts2){
		//int number = post2.getNumber();
		int roundID= post2.getRoundID();
		String subtitle =post2.getSubtitle();
		String summary =post2.getSummary();
		String story =post2.getStory();
		%>
<%=roundID%>화<br><br>	
 제목 : <%=fTitle%>

부제목 : <%=subtitle%><br><br>
사건 요약(줄거리) : <%=summary %><br><br>
스토리<br><br> <%=story %><br><br><br>

<%
			}}
			%>
</body>
</html>