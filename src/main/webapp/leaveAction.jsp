<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	  <%
        // MySQL �����ͺ��̽� ���� ���� ����
        String jdbcUrl = "jdbc:mysql://localhost:3306/epicus";
        String dbUser = "root";
        String dbPassword = "root";

        Connection connection = null;

        try {
            // MySQL ����̹� �ε�
            Class.forName("com.mysql.cj.jdbc.Driver");

            // �����ͺ��̽� ����
            connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // ȸ�� ������ �����ϴ� SQL ���� �ۼ� (��: users ���̺��� ȸ�� ����)
            String deleteQuery = "DELETE FROM users WHERE userID = ?"; // ����ڸ����� ���� ����

            // ������ �����ϱ� ���� PreparedStatement ����
            PreparedStatement preparedStatement = connection.prepareStatement(deleteQuery);
            
            // Ż���� ����ڸ��� �޾ƿɴϴ�. (��: �� ���������� POST ������� �޾ƿɴϴ�.)
            String usernameToDelete = request.getParameter("userID");

            // PreparedStatement�� �Ķ���� ����
            preparedStatement.setString(1, usernameToDelete);

            // ���� ����
            int rowsDeleted = preparedStatement.executeUpdate();

            // ���� ����
            preparedStatement.close();
            connection.close();

            // ������ ���� ������ ȸ�� Ż�� ���� �޽��� ǥ��
            if (rowsDeleted > 0) {
                out.println("<p>ȸ�� Ż�� �Ϸ�Ǿ����ϴ�.</p>");
            } else {
                out.println("<p>ȸ�� Ż�� �����߽��ϴ�.</p>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    %>
</body>
</html>