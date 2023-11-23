<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int id=Integer.parseInt(request.getParameter("character_id"));
int character_id=Integer.parseInt(request.getParameter("character_id"));
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
			String magicDate = request.getParameter("magicDate");
			int roundID = Integer.parseInt(request.getParameter("roundID"));
			//int character_id = Integer.parseInt(request.getParameter("id"));
%>
<%=id %>
<%=character_id %>
<%=genres %>
<%=genre_opinion %>
<%= keyword%>
<%=keyword_opinion %>
<%= time%>
<%=space %>
<%=time_opinion%>
<%=space_opinion%>
<%=natural_opinion %>
<%=social_opinion %>
<%= psychological_opinion%>
<%= situational_opinion%>
<%= other_opinion%>
<%=internal_opinion %>
<%=external_opinion %>
<%=track_opinion %>
<%= sub_opinion%>
<%= story_opinion%>
<%=main_opinion %>
<%=roundID %>
<%=magicDate %>

</body>
</html>