<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="test.free" %>
<%@ page import="test.freeDAO" %>
 <%@ page import="java.util.ArrayList" %>   
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel ="stylesheet" href ="./css/popup.css">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");
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
	int magicID=0;
	if(request.getParameter("magicID") !=null){
		magicID= Integer.parseInt(request.getParameter("magicID"));
		
	}
	int freeID=0;
	if(request.getParameter("freeID") !=null){
		freeID = Integer.parseInt(request.getParameter("freeID"));
		
	}
	free free = new freeDAO().getfree(freeID);
	 
%>
<script type="text/javascript">
function modal(){
opener.location.href='openAction2.jsp?magicID=<%=magicID%>'; 
window.close();
}
function modal2(){
	opener.location.href='closeAction2.jsp?magicID=<%=magicID%>'; 
	window.close();
}
</script>
<div class="txtdiv">
<h2 class="opentxt">작품을 공개하시겠습니까?</h2>

</div>
<div class="btndiv">
<input type="button" class="open" value="공개" onclick="modal();">
<input type="button" class="close" value="비공개" onclick="modal2();">
</div>
</body>
</html>