package magic;

import java.sql.Timestamp;

public class magic {
	public magic(int magicID, String image_path, String mTitle, String userID, String mInto, Timestamp mDate, int mAvailable, int mopen, int mlike_count) {
	    // 생성자 내부에서 필드 초기화 및 다른 작업 수행
	    this.magicID = magicID;
	    this.image_path = image_path;
	    this.mTitle = mTitle;
	    this.userID = userID;
	    this.mInto = mInto;
	    this.mAvailable = mAvailable;
	    this.mopen = mopen;
	    this.mlike_count = mlike_count;
	}
	private int magicID;
	public int getMagicID() {
		return magicID;
	}
	public void setMagicID(int magicID) {
		this.magicID = magicID;
	}
	public String getImage_path() {
		return image_path;
	}
	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}
	public String getmTitle() {
		return mTitle;
	}
	public void setmTitle(String mTitle) {
		this.mTitle = mTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getmInto() {
		return mInto;
	}
	public void setmInto(String mInto) {
		this.mInto = mInto;
	}
	public Timestamp getmDate() {
		return mDate;
	}
	public void setmDate(Timestamp mDate) {
		this.mDate = mDate;
	}
	public int getmAvailable() {
		return mAvailable;
	}
	public void setmAvailable(int mAvailable) {
		this.mAvailable = mAvailable;
	}
	public int getMopen() {
		return mopen;
	}
	public void setMopen(int mopen) {
		this.mopen = mopen;
	}
	
	private String image_path;
	private String mTitle;
	private String userID;
	private String mInto;
	private Timestamp mDate;
	private int mAvailable;
	private int mopen;
	private int mlike_count;
	public int getMlike_count() {
		return mlike_count;
	}
	public void setMlike_count(int mlike_count) {
		this.mlike_count = mlike_count;
	}
	

}
