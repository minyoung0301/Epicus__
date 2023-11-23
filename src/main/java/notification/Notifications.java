package notification;

import java.sql.Timestamp;

public class Notifications {
	  public int getNotificationID() {
		return notificationID;
	}
	public void setNotificationID(int notificationID) {
		this.notificationID = notificationID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public boolean isRead() {
		return isRead;
	}
	public void setRead(boolean isRead) {
		this.isRead = isRead;
	}
	private int notificationID;
	    private String userID;
	    private String message;
	    private Timestamp createdAt;
	    private boolean isRead;
}