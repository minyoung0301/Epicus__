package star;

public class bookmark {
	private int starID;
	private String s_freeID;
	private String s_userID;
	public int getStarID() {
		return starID;
	}
	public void setStarID(int starID) {
		this.starID = starID;
	}
	public String getS_freeID() {
		return s_freeID;
	}
	public void setS_freeID(String s_freeID) {
		this.s_freeID = s_freeID;
	}
	public String getS_userID() {
		return s_userID;
	}
	public void setS_userID(String s_userID) {
		this.s_userID = s_userID;
	}
	public bookmark(int starID, String s_freeID, String s_userID) {
		super();
		this.starID = starID;
		this.s_freeID = s_freeID;
		this.s_userID = s_userID;
	}
	
}
