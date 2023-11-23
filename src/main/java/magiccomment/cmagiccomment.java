package magiccomment;

public class cmagiccomment {
	private int magicID;
	public int getMagicID() {
		return magicID;
	}
	public void setMagicID(int magicID) {
		this.magicID = magicID;
	}
	public int getMagiccommentID() {
		return magiccommentID;
	}
	public void setMagiccommentID(int magiccommentID) {
		this.magiccommentID = magiccommentID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getCommentDate() {
		return commentDate;
	}
	public void setCommentDate(String commentDate) {
		this.commentDate = commentDate;
	}
	public String getCommentText() {
		return commentText;
	}
	public cmagiccomment(int magicID, int magiccommentID, String userID, String commentDate, String commentText,
			int cAvailable, int number) {
		super();
		this.magicID = magicID;
		this.magiccommentID = magiccommentID;
		this.userID = userID;
		this.commentDate = commentDate;
		this.commentText = commentText;
		this.cAvailable = cAvailable;
		this.number = number;
	}
	public void setCommentText(String commentText) {
		this.commentText = commentText;
	}
	public int getcAvailable() {
		return cAvailable;
	}
	public void setcAvailable(int cAvailable) {
		this.cAvailable = cAvailable;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	private int magiccommentID;
	private String userID;
	private String commentDate;
	private String commentText;
	private int cAvailable;
	private int number;
	
}
