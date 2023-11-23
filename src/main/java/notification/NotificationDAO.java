package notification;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {
	 private Connection conn;

	    public NotificationDAO() {
	        try {
	            String dbURL = "jdbc:mysql://localhost:3306/epicus?serverTimezone=UTC";
	            String dbID = "root";
	            String dbPassword = "root";
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    

	    // �깉濡쒖슫 �븣由쇱쓣 異붽�
	    public int addNotification(String followingID, String message) {
	        String sql = "INSERT INTO notifications (userID, message, created_at) VALUES (?, ?, NOW())";
	        try {
	            PreparedStatement pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, followingID);
	            pstmt.setString(2, message);
	            return pstmt.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return -1; // �궫�엯 �떎�뙣
	        }
	    }
	    public int addlikeNotification(String likeuser, String message) {
	        String sql = "INSERT INTO notifications (userID, message, created_at) VALUES (?, ?, NOW())";
	        try {
	            PreparedStatement pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, likeuser);
	            pstmt.setString(2, message);
	            return pstmt.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return -1; // �궫�엯 �떎�뙣
	        }
	    }

	    // �궗�슜�옄�쓽 紐⑤뱺 �븣由� 遺덈윭�삤湲�
	    public List<Notifications> getNotifications(String userID) {
	        List<Notifications> notifications = new ArrayList<>();
	        String sql = "SELECT * FROM notifications WHERE userID = ? ORDER BY created_at DESC";
	        try {
	            PreparedStatement pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, userID);
	            ResultSet rs = pstmt.executeQuery();
	            while (rs.next()) {
	                int notificationID = rs.getInt("notificationID");
	                String message = rs.getString("message");
	                Timestamp createdAt = rs.getTimestamp("created_at");
	                //boolean isRead = rs.getBoolean("isRead");

	                Notifications notification = new Notifications();
	                notification.setNotificationID(notificationID);
	                notification.setUserID(userID);
	                notification.setMessage(message);
	                notification.setCreatedAt(createdAt);
	                //notification.setRead(isRead);

	                notifications.add(notification);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return notifications;
	    }
	}