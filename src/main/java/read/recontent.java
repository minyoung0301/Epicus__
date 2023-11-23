package read;

public class recontent {
	private int readID;
	private String re_userID;
	private int re_freeID;
	private int re_number;
	public int getReadID() {
		return readID;
	}
	public void setReadID(int readID) {
		this.readID = readID;
	}
	public String getRe_userID() {
		return re_userID;
	}
	public void setRe_userID(String re_userID) {
		this.re_userID = re_userID;
	}
	public int getRe_freeID() {
		return re_freeID;
	}
	public void setRe_freeID(int re_freeID) {
		this.re_freeID = re_freeID;
	}
	public int getRe_number() {
		return re_number;
	}
	public void setRe_number(int re_number) {
		this.re_number = re_number;
	}
	public recontent(int readID, String re_userID, int re_freeID, int re_number) {
		super();
		this.readID = readID;
		this.re_userID = re_userID;
		this.re_freeID = re_freeID;
		this.re_number = re_number;
	}
	
}
