package contest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import test.free;

public class contestDAO {
	private Connection conn;
	private ResultSet rs;
	
	public contestDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/epicus";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}		
	}
	public int getNext() {
		String sql = "select contestID from contest order by contestID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);	
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;  
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int writecontest(String userID,String cTitle,String field,String object,String host, String period, String link, String detail) {
		String sql = "insert into contest values(?,?,?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setInt(2, getNext());
			pstmt.setString(3, cTitle);
			pstmt.setString(4, field);
			pstmt.setString(5, object);
			pstmt.setString(6, host);
			pstmt.setString(7, period);
			pstmt.setString(8, link);
			pstmt.setString(9, detail);
			pstmt.setInt(10,0);
		
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int countUpdate(int cHit,int contestID) {
		  String SQL= "update  contest set cHit= ? where contestID=?";
		  try {
			  PreparedStatement pstmt = conn.prepareStatement(SQL);
			  pstmt.setInt(1,cHit);
			  pstmt.setInt(2, contestID);
			  
			  
		  return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		//나머지는 디비오류
		return -1;
	
	  }
	  public ArrayList<contest2> getList(int pageNumber) {
		  String SQL ="SELECT * FROM contest WHERE contestID < ? ORDER BY contestID LIMIT 10";
		  ArrayList<contest2> list = new ArrayList<contest2>(); 
		  try {
			  PreparedStatement pstmt= conn.prepareStatement(SQL); 
			  pstmt.setInt(1, getNext() - (pageNumber-1)*8);
	 
	  rs = pstmt.executeQuery();
	  
	  while(rs.next()) { 
	  contest2 contest2 = new contest2();
	  contest2.setUserID(rs.getString(1));
	  contest2.setContestID(rs.getInt(2));
	  contest2.setcTitle(rs.getString(3));
	  contest2.setField(rs.getString(4));
	  contest2.setObject(rs.getString(5));
	  contest2.setHost(rs.getString(6));
	  
	  contest2.setPeriod(rs.getString(7));
	  contest2.setLink(rs.getString(8));
	  contest2.setDetail(rs.getString(9));
	 contest2.setcHit(rs.getInt(10));
	
	  
	  
	  list.add(contest2); 
	  } }catch(Exception e) { e.printStackTrace(); } return list; }
	  
	  
	  public boolean nextPage(int pageNumber) 
	  { 
		  String SQL="SELECT * FROM contest WHERE contestID < ? ORDER BY contestID DESC LIMIT 8";
	  
	  try { PreparedStatement pstmt = conn.prepareStatement(SQL);
	  pstmt.setInt(1,getNext() - (pageNumber -1) * 10); 
	  rs = pstmt.executeQuery();
	  if (rs.next()) { return true; } } catch(Exception e) { e.printStackTrace(); }
	  return false; }
	  
	  
	  public contest2 getcontest(int contestID){
	  
	  String SQL ="SELECT * FROM contest WHERE contestID = ?"; 
	  try { PreparedStatement
	  pstmt = conn.prepareStatement(SQL); 
	  pstmt.setInt(1, contestID); 
	  rs = pstmt.executeQuery();
	  if (rs.next()) {
		  contest2 contest2 = new contest2();
		  contest2.setUserID(rs.getString(1));
		  contest2.setContestID(rs.getInt(2));
		  contest2.setcTitle(rs.getString(3));
		  contest2.setField(rs.getString(4));
		  contest2.setObject(rs.getString(5));
		  contest2.setHost(rs.getString(6));
		  
		  contest2.setPeriod(rs.getString(7));
		  contest2.setLink(rs.getString(8));
		  contest2.setDetail(rs.getString(9));
		  int cHit=rs.getInt(10);
			 contest2.setcHit(cHit);
			 cHit++;
			 countUpdate(cHit,contestID);
	  
	  return contest2;
	  
	  } } catch (Exception e) { e.printStackTrace(); } return null; }
}