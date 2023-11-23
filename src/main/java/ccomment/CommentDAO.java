package ccomment;

import java.sql.Connection; 
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import test.free;

public class CommentDAO {
	private Connection conn;
	private ResultSet rs;
	
	
public CommentDAO() {
		
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
		String sql = "select commentID from comment order by commentID desc";
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
		  String SQL="SELECT * FROM comment WHERE commentID < ? AND cAvailable = 1 ORDER BY commentID DESC LIMIT 5";
	  
	  try { PreparedStatement pstmt = conn.prepareStatement(SQL);
	  pstmt.setInt(1,getCommentID() - (pageNumber -1) * 5); 
	  rs = pstmt.executeQuery();
	  if (rs.next()) { return true; } } catch(Exception e) { e.printStackTrace(); }
	  return false; }
	  
	  public Comment getcomment(int freeID,int commentID,int number){
		  
		  String SQL ="SELECT * FROM comment WHERE freeID = ?  AND number =? AND commentID=?"; 
		  try { PreparedStatement
		  pstmt = conn.prepareStatement(SQL); 
		  pstmt.setInt(1, freeID); 
		  pstmt.setInt(2,commentID);
		  pstmt.setInt(3,number);
		  rs = pstmt.executeQuery();
		  if (rs.next()) {
		  
			  Comment Comment = new Comment(); 
			  Comment.setFreeID(rs.getInt(1));
			  Comment.setCommentID(rs.getInt(2)); 
			  Comment.setUserID(rs.getString(3));
			  Comment.setCommentDate(rs.getString(4)); 
			  Comment.setCommentText(rs.getString(5));
			  Comment.setcAvailable(rs.getInt(6));
			  Comment.setNumber(rs.getInt(7));
	
		  
		  
		  
		  return Comment;
		  
		  } } catch (Exception e) { e.printStackTrace(); } return null; }
	  
	  public String getDate() {
			//이건 mysql에서 현재의 시간을 가져오는 하나의 문장
			String SQL = "SELECT NOW()";
			try {
				//각각 함수끼리 데이터 접근에 있어서 마찰방지용으로 내부 pstmt선언 (현재 연결된 객체를 이용해서 SQL문장을 실행 준비단계로 만들어준다.)
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				//rs내부에 실제로 실행했을때 나오는 결과를 가져온다
				rs = pstmt.executeQuery();
				//결과가 있는경우는 다음과 같이 getString 1을 해서 현재의 그 날짜를 반환할 수 있게 해준다.
				if(rs.next()) {
					return rs.getString(1);
				}
			} catch (Exception e) {
				//오류 발생 내용을 콘솔에 띄움
				e.printStackTrace();
			}
			//데이터베이스 오류인데 웬만해선 디비오류가 날 이유가없기때문에 빈문장으로 넣어준다.
			return ""; 
		}  
	public int commentwrite(int freeID,int number,String userID,String commentText) {
		String sql = "insert into comment values(?,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			 pstmt.setInt(1, freeID); 
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
	 public ArrayList<Comment> getList(int pageNumber,int freeID,int number) {
		  String SQL ="SELECT * FROM comment WHERE commentID < ? AND freeID=? AND number=? ORDER BY commentID DESC LIMIT 5";
		  ArrayList<Comment> list = new ArrayList<Comment>();
		  try {
			  PreparedStatement pstmt= conn.prepareStatement(SQL); 
			  pstmt.setInt(1, getCommentID() - (pageNumber-1)*5);
			  pstmt.setInt(2, freeID);

			  pstmt.setInt(3,number);
		
	
			  
	 
	  
	  rs = pstmt.executeQuery();
	  
	  while(rs.next()) { 
	  Comment Comment = new Comment(); 
	  Comment.setFreeID(rs.getInt(1));
	  Comment.setNumber(rs.getInt(2));
	  Comment.setCommentID(rs.getInt(3)); 
	  Comment.setUserID(rs.getString(4));
	  Comment.setCommentDate(rs.getString(5)); 
	  Comment.setCommentText(rs.getString(6));
	  Comment.setcAvailable(rs.getInt(7));
	 
	  
	  
	  list.add(Comment); 
	  } 
	  } catch(Exception e) {
			  e.printStackTrace(); 
			  } 
		  return list; 
		  }
}
