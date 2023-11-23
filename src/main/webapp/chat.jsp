<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>간단한 채팅</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            // 채팅 메시지 업데이트를 주기적으로 요청
            function updateChat() {
                $.get("chatController.jsp", function (data) {
                    $("#chatMessages").html(data);
                });
            }

            // 초기화 및 주기적 업데이트 시작
            updateChat();
            setInterval(updateChat, 1000);

            // 메시지 전송
            $("#sendMessage").click(function () {
                var message = $("#messageInput").val();
                $.post("chatController.jsp", { message: message }, function () {
                    $("#messageInput").val("");
                    updateChat();
                });
            });
        });
    </script>
</head>
<body>
    <h1>chat</h1>
    <div id="chatMessages"></div>
    <input type="text" id="messageInput" placeholder="메시지 입력">
    <button id="sendMessage">전송</button>
</body>
</html>
