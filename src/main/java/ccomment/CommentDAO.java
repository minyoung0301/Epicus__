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
			//�̰� mysql���� ������ �ð��� �������� �ϳ��� ����
			String SQL = "SELECT NOW()";
			try {
				//���� �Լ����� ������ ���ٿ� �־ �������������� ���� pstmt���� (���� ����� ��ü�� �̿��ؼ� SQL������ ���� �غ�ܰ�� ������ش�.)
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				//rs���ο� ������ ���������� ������ ����� �����´�
				rs = pstmt.executeQuery();
				//����� �ִ°��� ������ ���� getString 1�� �ؼ� ������ �� ��¥�� ��ȯ�� �� �ְ� ���ش�.
				if(rs.next()) {
					return rs.getString(1);
				}
			} catch (Exception e) {
				//���� �߻� ������ �ֿܼ� ���
				e.printStackTrace();
			}
			//�����ͺ��̽� �����ε� �����ؼ� �������� �� ���������⶧���� �������� �־��ش�.
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
