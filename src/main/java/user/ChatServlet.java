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

        // �����ͺ��̽��� �޽��� ���� �� ó��
        saveMessage(senderUsername, recipientUsername, message);

        response.getWriter().write(message);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String recipientUsername = request.getParameter("recipientUsername");

        // �����ͺ��̽����� ���� �����ڿ��� �� ��� ä�� �޽��� ��������
        List<String> messages = getChatMessages(recipientUsername);
        for (String message : messages) {
            out.println("<p>" + message + "</p>");
        }
    }

    // �����ͺ��̽��� �޽��� ����
    private void saveMessage(String senderUsername, String recipientUsername, String message) {
        try {
            // JDBC ����̹� �ε�
            Class.forName("com.mysql.cj.jdbc.Driver");

            // �����ͺ��̽� ���� ���� ����
            String url = "jdbc:mysql://localhost:3306/epicus";
            String username = "root";
            String password = "root";

            // �����ͺ��̽� ����
            try (Connection connection = DriverManager.getConnection(url, username, password)) {
                // SQL ���� �ۼ�
                String sql = "INSERT INTO chat_messages (sender_username, recipient_username, message_text) VALUES (?, ?, ?)";
                try (PreparedStatement statement = connection.prepareStatement(sql)) {
                    statement.setString(1, senderUsername);
                    statement.setString(2, recipientUsername);
                    statement.setString(3, message);

                    // ���� ����
                    statement.executeUpdate();
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    // �����ͺ��̽����� ���� �����ڿ��� �� ��� ä�� �޽��� ��������
    private List<String> getChatMessages(String recipientUsername) {
        List<String> messages = new ArrayList<>();

        try {
            // JDBC ����̹� �ε�
            Class.forName("com.mysql.cj.jdbc.Driver");

            // �����ͺ��̽� ���� ���� ����
            String url ="jdbc:mysql://localhost:3306/epicus";
            String username = "root";
            String password = "root";

            // �����ͺ��̽� ����
            try (Connection connection = DriverManager.getConnection(url, username, password)) {
                // SQL ���� �ۼ�
                String sql = "SELECT sender_username, message_text FROM chat_messages WHERE recipient_username = ?";
                try (PreparedStatement statement = connection.prepareStatement(sql)) {
                    statement.setString(1, recipientUsername);

                    // ���� ����
                    try (ResultSet resultSet = statement.executeQuery()) {
                        // ��� ó��
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
