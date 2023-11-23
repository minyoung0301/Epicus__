<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" --%>
<%--     pageEncoding="UTF-8"%> --%>
        <%@ page import="test.free" %>
    <%@ page import="test.freeDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="freetest.freecontent" %>

<%@ page import="freetest.freecontentDAO" %>
    
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

String summary =request.getParameter("summary");
 String subtitle =request.getParameter("subtitle");
String story = request.getParameter("story");

int freeID = 0;
//만약에 매개변수로 넘어온 bbsID라는 매개변수가 존재 할 시 
//(이 매개변수는 bbs.jsp에서 view로 이동하는 a태그에서 넘겨준 값이다.)
if (request.getParameter("freeID") != null) {
	//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다. 다음과 같이 정수형으로 변환시켜준다.
	freeID = Integer.parseInt(request.getParameter("freeID"));
}
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






 int pageNumber = 1; 
 //만약에 파라미터로 pageNumber가 넘어왔다면 해당 파라미터의 값을 넣어주도록 한다.
if (request.getParameter("pageNumber") != null)
{
	//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다.
    pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
} 

int roundID = 0;
//만약에 매개변수로 넘어온 bbsID라는 매개변수가 존재 할 시 
//(이 매개변수는 bbs.jsp에서 view로 이동하는 a태그에서 넘겨준 값이다.)
if (request.getParameter("roundID") != null) {
	//파라미터는 항상 정수형으로 바꿔주는 parseInt를 사용해야 한다. 다음과 같이 정수형으로 변환시켜준다.
	roundID = Integer.parseInt(request.getParameter("roundID"));
}
free free= new freeDAO().getfree(freeID);
freecontent freecontent= new freecontentDAO().getfreecontent(freeID,number);

%>
<%	
	
			freecontentDAO freecontentDAO = new freecontentDAO();
	
			ArrayList<freecontent> list = freecontentDAO.getList(pageNumber,freeID,userID);
			
			for ( int i= 0; i<list.size(); i++)
			{
		%>
<%=list.get(i).getRoundID() %>화<br><br>	
 제목 : <%=free.getfTitle()%>

부제목 : <%=list.get(i).getSubtitle()%><br><br>
사건 요약(줄거리) : <%=list.get(i).getSummary() %><br><br>
스토리<br><br> <%=list.get(i).getStory() %><br><br><br>

<%
			}
			%>
</body>
</html>