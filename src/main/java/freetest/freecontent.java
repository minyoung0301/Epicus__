package freetest;
import java.sql.Timestamp;
public class freecontent {
	private int freeID;
	private int roundID;
	private String subtitle;
	private String summary;
	private String story;
	private String userID;
	private int Available;
	private int freecheck;
	private Timestamp freeDate;
	private int number;
	private String image_path;
	public String getImage_path() {
		return image_path;
	}
	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}
	public freecontent(int freeID, int roundID,int number,String subtitle, String summary, String story,int like_count,String userID, Timestamp freeDate,
			int available, int freecheck, int hit,String image_path) {
		super();
		this.freeID = freeID;
		this.roundID = roundID;
		this.number = number;
		this.subtitle = subtitle;
		this.summary = summary;
		this.story = story;
		this.like_count = like_count;
		this.userID = userID;
		this.freeDate = freeDate;
		Available = available;
		this.freecheck = freecheck;
		
		
		this.hit = hit;
	
		this.image_path = image_path;
	}
	private int hit;
	private int like_count;
	public int getLike_count() {
		return like_count;
	}
	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public Timestamp getFreeDate() {
		return freeDate;
	}
	public void setFreeDate(Timestamp freeDate) {
		this.freeDate = freeDate;
	}
	public int getFreecheck() {
		return freecheck;
	}
	public void setFreecheck(int freecheck) {
		this.freecheck = freecheck;
	}
	public int getFreeID() {
		return freeID;
	}
	public void setFreeID(int freeID) {
		this.freeID = freeID;
	}
	public int getRoundID() {
		return roundID;
	}
	public void setRoundID(int roundID) {
		this.roundID = roundID;
	}
	public String getSubtitle() {
		return subtitle;
	}
	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getStory() {
		return story;
	}
	public void setStory(String story) {
		this.story = story;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getAvailable() {
		return Available;
	}
	public void setAvailable(int available) {
		Available = available;
	}
	

	

}
