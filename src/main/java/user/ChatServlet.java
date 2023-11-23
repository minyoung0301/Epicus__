package user;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/user/ChatServlet")
public class ChatServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
    	String recipientUsername = request.getParameter("recipientUsername");
        String senderUsername = (String) request.getSession().getAttribute("userID");
        String message = request.getParameter("message");

        // 데이터베이스에 메시지 저장 및 처리
        saveMessage(senderUsername, recipientUsername, message);

        response.getWriter().write(message);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String recipientUsername = request.getParameter("recipientUsername");

        // 데이터베이스에서 현재 수신자에게 온 모든 채팅 메시지 가져오기
        List<String> messages = getChatMessages(recipientUsername);
        for (String message : messages) {
            out.println("<p>" + message + "</p>");
        }
    }

    // 데이터베이스에 메시지 저장
    private void saveMessage(String senderUsername, String recipientUsername, String message) {
        try {
            // JDBC 드라이버 로드
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 데이터베이스 연결 정보 설정
            String url = "jdbc:mysql://localhost:3306/epicus";
            String username = "root";
            String password = "root";

            // 데이터베이스 연결
            try (Connection connection = DriverManager.getConnection(url, username, password)) {
                // SQL 쿼리 작성
                String sql = "INSERT INTO chat_messages (sender_username, recipient_username, message_text) VALUES (?, ?, ?)";
                try (PreparedStatement statement = connection.prepareStatement(sql)) {
                    statement.setString(1, senderUsername);
                    statement.setString(2, recipientUsername);
                    statement.setString(3, message);

                    // 쿼리 실행
                    statement.executeUpdate();
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    // 데이터베이스에서 현재 수신자에게 온 모든 채팅 메시지 가져오기
    private List<String> getChatMessages(String recipientUsername) {
        List<String> messages = new ArrayList<>();

        try {
            // JDBC 드라이버 로드
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 데이터베이스 연결 정보 설정
            String url ="jdbc:mysql://localhost:3306/epicus";
            String username = "root";
            String password = "root";

            // 데이터베이스 연결
            try (Connection connection = DriverManager.getConnection(url, username, password)) {
                // SQL 쿼리 작성
                String sql = "SELECT sender_username, message_text FROM chat_messages WHERE recipient_username = ?";
                try (PreparedStatement statement = connection.prepareStatement(sql)) {
                    statement.setString(1, recipientUsername);

                    // 쿼리 실행
                    try (ResultSet resultSet = statement.executeQuery()) {
                        // 결과 처리
                        while (resultSet.next()) {
                            String senderUsername = resultSet.getString("sender_username");
                            String message = resultSet.getString("message_text");
                            messages.add(senderUsername + ": " + message);
                        }
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return messages;
    }
}
