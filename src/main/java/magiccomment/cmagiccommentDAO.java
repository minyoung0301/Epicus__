package magiccomment;

import java.sql.Connection; 
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import test.free;

public class cmagiccommentDAO {
	private Connection conn;
	private ResultSet rs;
	
	
public cmagiccommentDAO() {
		
		try {
			String dbURL = "jdbc:mysql://localhost:3306/epicus";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}		
	}
	public int getCommentID() {
		String sql = "select magiccommentID from magiccomment order by magiccommentID desc";
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

	  
	  public boolean nextPage(int pageNumber) 
	  { 
		  String SQL="SELECT * FROM comment WHERE magiccommentID < ? AND cAvailable = 1 ORDER BY magiccommentID DESC LIMIT 5";
	  
	  try { PreparedStatement pstmt = conn.prepareStatement(SQL);
	  pstmt.setInt(1,getCommentID() - (pageNumber -1) * 5); 
	  rs = pstmt.executeQuery();
	  if (rs.next()) { return true; } } catch(Exception e) { e.printStackTrace(); }
	  return false; }
	  
	  public cmagiccomment getmagiccomment(int magicID,int magiccommentID,int number){
		  
		  String SQL ="SELECT * FROM magiccomment WHERE magicID = ?  AND number =? AND magiccommentID=?"; 
		  try { PreparedStatement
		  pstmt = conn.prepareStatement(SQL); 
		  pstmt.setInt(1, magicID); 
		  pstmt.setInt(2,magiccommentID);
		  pstmt.setInt(3,number);
		  rs = pstmt.executeQuery();
		  if (rs.next()) {
		  
			  cmagiccomment cmagiccomment = new cmagiccomment(); 
			  cmagiccomment.setMagicID(rs.getInt(1));
			  cmagiccomment.setMagiccommentID(rs.getInt(2)); 
			  cmagiccomment.setUserID(rs.getString(3));
			  cmagiccomment.setCommentDate(rs.getString(4)); 
			  cmagiccomment.setCommentText(rs.getString(5));
			  cmagiccomment.setcAvailable(rs.getInt(6));
			  cmagiccomment.setNumber(rs.getInt(7));
	
		  
		  
		  
		  return cmagiccomment;
		  
		  } } catch (Exception e) { e.printStackTrace(); } return null; }
	  
	  public String getDate() {
			//占싱곤옙 mysql占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占시곤옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占싹놂옙占쏙옙 占쏙옙占쏙옙
			String SQL = "SELECT NOW()";
			try {
				//占쏙옙占쏙옙 占쌉쇽옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쌕울옙 占쌍어서 占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 pstmt占쏙옙占쏙옙 (占쏙옙占쏙옙 占쏙옙占쏙옙占� 占쏙옙체占쏙옙 占싱울옙占쌔쇽옙 SQL占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 占쌔븝옙丙占쏙옙 占쏙옙占쏙옙占쏙옙娩占�.)
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				//rs占쏙옙占싸울옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占� 占쏙옙占쏙옙占승댐옙
				rs = pstmt.executeQuery();
				//占쏙옙占쏙옙占� 占쌍는곤옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 getString 1占쏙옙 占쌔쇽옙 占쏙옙占쏙옙占쏙옙 占쏙옙 占쏙옙짜占쏙옙 占쏙옙환占쏙옙 占쏙옙 占쌍곤옙 占쏙옙占쌔댐옙.
				if(rs.next()) {
					return rs.getString(1);
				}
			} catch (Exception e) {
				//占쏙옙占쏙옙 占쌩삼옙 占쏙옙占쏙옙占쏙옙 占쌤솔울옙 占쏙옙占�
				e.printStackTrace();
			}
			//占쏙옙占쏙옙占싶븝옙占싱쏙옙 占쏙옙占쏙옙占싸듸옙 占쏙옙占쏙옙占쌔쇽옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙占썩때占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쌍억옙占쌔댐옙.
			return ""; 
		}  
	public int commentwrite(int magicID,int number,String userID,String commentText) {
		String sql = "insert into magiccomment values(?,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			 pstmt.setInt(1, magicID); 
			 pstmt.setInt(2,number);
			pstmt.setInt(3, getCommentID());
			pstmt.setString(4, userID);
			pstmt.setString(5, getDate());
			pstmt.setString(6,commentText);
			pstmt.setInt(7, 1);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	 public ArrayList<cmagiccomment> getList(int pageNumber,int magicID,int number) {
		  String SQL ="SELECT * FROM magiccomment WHERE magiccommentID < ? AND magicID=? AND number=? ORDER BY magiccommentID DESC LIMIT 5";
		  ArrayList<cmagiccomment> list = new ArrayList<cmagiccomment>();
		  try {
			  PreparedStatement pstmt= conn.prepareStatement(SQL); 
			  pstmt.setInt(1, getCommentID() - (pageNumber-1)*5);
			  pstmt.setInt(2, magicID);

			  pstmt.setInt(3,number);
		
	
			  
	 
	  
	  rs = pstmt.executeQuery();
	  
	  while(rs.next()) { 
		  cmagiccomment cmagiccomment = new cmagiccomment(); 
		  cmagiccomment.setMagicID(rs.getInt(1));
		  cmagiccomment.setMagiccommentID(rs.getInt(2)); 
		  cmagiccomment.setUserID(rs.getString(3));
		  cmagiccomment.setCommentDate(rs.getString(4)); 
		  cmagiccomment.setCommentText(rs.getString(5));
		  cmagiccomment.setcAvailable(rs.getInt(6));
		  cmagiccomment.setNumber(rs.getInt(7));

	 
	  
	  
	  list.add(cmagiccomment); 
	  } 
	  } catch(Exception e) {
			  e.printStackTrace(); 
			  } 
		  return list; 
		  }
}
