package test;
import java.sql.Timestamp;
public class free {
	private int freeID;
	private String image_path;
	private String fTitle;
	private String userID;
	private String fInto;

	private int fAvailable;
	private int fopen;
	private int flike_count;
	public int getFlike_count() {
		return flike_count;
	}
	public void setFlike_count(int flike_count) {
		this.flike_count = flike_count;
	}
	public int getFreeID() {
		return freeID;
	}
	public void setFreeID(int freeID) {
		this.freeID = freeID;
	}
	public String getImage_path() {
		return image_path;
	}
	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}
	public String getfTitle() {
		return fTitle;
	}
	public void setfTitle(String fTitle) {
		this.fTitle = fTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getfInto() {
		return fInto;
	}
	public void setfInto(String fInto) {
		this.fInto = fInto;
	}
	
	public int getfAvailable() {
		return fAvailable;
	}
	public void setfAvailable(int fAvailable) {
		this.fAvailable = fAvailable;
	}
	public int getFopen() {
		return fopen;
	}
	public void setFopen(int fopen) {
		this.fopen = fopen;
	}
	public free(int freeID, String image_path, String fTitle, String userID, String fInto,Timestamp fDate, int fAvailable,
			int fopen,int flike_count) {
		super();
		this.freeID = freeID;
		this.image_path = image_path;
		this.fTitle = fTitle;
		this.userID = userID;
		this.fInto = fInto;
		
		this.fAvailable = fAvailable;
		this.fopen = fopen;
		this.flike_count = flike_count;
	}
	public Timestamp getfDate() {
		return fDate;
	}
	public void setfDate(Timestamp fDate) {
		this.fDate = fDate;
	}
	private Timestamp fDate;

	

}
