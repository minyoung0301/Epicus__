<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="test.free" %>

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
	
	

	
	
	
	int magicID=0;
	if(request.getParameter("magicID") !=null){
		magicID= Integer.parseInt(request.getParameter("magicID"));
		
	}
	int freeID=0;
	if(request.getParameter("freeID") !=null){
		freeID = Integer.parseInt(request.getParameter("freeID"));
		
	}

%>
			<script>
	$(document).ready(function() {
	    $("#frm").submit(function(e) {
	        e.preventDefault();

	        var formData = new FormData(this);

	        $.ajax({
	            url: "openAction.jsp?freeID="+<%=freeID%>, // 이미지와 게시물을 처리할 서버 스크립트 페이지
	            type: "POST",
	            data: formData,
	            processData: false,
	            contentType: false,
	            success: function(response) {
	                // 업로드 성공 시 처리
	                alert("게시물이 성공적으로 업로드되었습니다.");
	                window.location.href="board.jsp";
	            },
	            error: function(xhr, status, error) {
	                // 업로드 실패 시 처리
	                alert("업로드 중 오류가 발생했습니다.");
	            }
	        });
	    });
	});
	</script>
<script type="text/javascript">
function modal(){
opener.location.href='openAction.jsp?freeID=<%=freeID%>'; 
window.close();
}
function modal2(){
	opener.location.href='closeAction.jsp?freeID=<%=freeID%>'; 
	window.close();
}
</script>
<div class="txtdiv">
<h2 class="opentxt">작품을 공개하시겠습니까?</h2>

</div>
<div class="btndiv">
<form id="frm" method="post" action ="openAction.jsp">
<input type="submit" class="open" value="공개" onclick="modal();">
</form>
<form method="post" action ="closeAction.jsp">
<input type="submit" class="close" value="비공개" onclick="modal2();">
</form>
</div>
</body>
</html>