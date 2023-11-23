<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>

<%
    String message = request.getParameter("message");
    List<String> chatHistory = (List<String>) application.getAttribute("chatHistory");

    if (chatHistory == null) {
        chatHistory = new LinkedList<>();
        application.setAttribute("chatHistory", chatHistory);
    }

    if (message != null && !message.isEmpty()) {
        chatHistory.add(message);
    }

    // 채팅 기록을 HTML로 렌더링하여 반환
    StringBuilder chatHtml = new StringBuilder();
    for (String chatMessage : chatHistory) {
        chatHtml.append("<p>").append(chatMessage).append("</p>");
    }

    out.println(chatHtml.toString());
%>
