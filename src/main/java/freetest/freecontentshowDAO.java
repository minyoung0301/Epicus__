package freetest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;



public class freecontentshowDAO {
	private Connection conn;
	private ResultSet rs;
	
	public freecontentshowDAO() {
		
		try {
			String dbURL = "jdbc:mysql://localhost:3306/epicus?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}		
	}



	

	
	  public ArrayList<freecontent> getList(int pageNumber,int freeID) { String SQL =
	  "SELECT * FROM freecontent WHERE roundID < ? AND freeID=? AND Available = 1 ORDER BY roundID LIMIT 10";
	  ArrayList<freecontent> list = new ArrayList<freecontent>(); 
	  try { 
		  PreparedStatement pstmt= conn.prepareStatement(SQL); 
		  pstmt.setInt(1, getroundID() - (pageNumber-1)*10);
		  pstmt.setInt(2, freeID);
	  rs = pstmt.executeQuery();
	  
	  while(rs.next()) { 
		  freecontent freecontent = new freecontent();
		  freecontent.setFreeID(rs.getInt(1));
		  freecontent.setRoundID(rs.getInt(2));
		  freecontent.setNumber(rs.getInt(3));
		  freecontent.setSubtitle(rs.getString(4));
		  freecontent.setSummary(rs.getString(5));
		  freecontent.setStory(rs.getString(6));
		  freecontent.setUserID(rs.getString(7));
		  freecontent.setFreeDate(rs.getString(8));
		  freecontent.setAvailable(rs.getInt(9));
		  freecontent.setFreecheck(rs.getInt(10));
	  
	  
	  
	  list.add(freecontent); 
	  
	  } }catch(Exception e) { e.printStackTrace(); } return list; }
	  
	  public int getroundID() {
		  String sql="SELECT roundID FROM freecontent ORDER BY roundID DESC";
		  try {
				PreparedStatement pstmt = conn.prepareStatement(sql);	
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getInt(1)+1;
				}
				return 1;  
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		  
	  }
	  
	  
	  public boolean nextPage(int pageNumber) { 
		  String SQL="SELECT * FROM freecontent WHERE roundID < ? AND Available = 1 ORDER BY roundID LIMIT 10";
	  
	  try { PreparedStatement pstmt = conn.prepareStatement(SQL);
	  pstmt.setInt(1, getroundID() - (pageNumber -1) * 10); 
	  rs = pstmt.executeQuery();
	  if (rs.next()) { return true; } } catch(Exception e) { e.printStackTrace(); }
	  return false; }
	  
	  
	  
	  public freecontent getfreecontent(int freeID,int number){
	  
	  String SQL ="SELECT * FROM freecontent WHERE freeID = ? AND number = ? "; 
	  try { 
	 PreparedStatement pstmt = conn.prepareStatement(SQL); 
	  pstmt.setInt(1, freeID);
	  pstmt.setInt(2, number);
	  rs = pstmt.executeQuery();
	  if (rs.next()) {
	  
		  freecontent freecontent = new freecontent(); 
		  freecontent.setFreeID(rs.getInt(1));
		  freecontent.setRoundID(rs.getInt(2));
		  freecontent.setNumber(rs.getInt(3));
		  freecontent.setSubtitle(rs.getString(4));
		  freecontent.setSummary(rs.getString(5));
		  freecontent.setStory(rs.getString(6));
		  freecontent.setUserID(rs.getString(7));
		  freecontent.setFreeDate(rs.getString(8));
		  freecontent.setAvailable(rs.getInt(9));
		  freecontent.setFreecheck(rs.getInt(10));
		  int hit=rs.getInt(11);
		  freecontent.setHit(hit);
		  hit++;
		  countUpdate(hit,freeID,number);
	  
	  
	  return freecontent;
	  
	  } } catch (Exception e) { e.printStackTrace(); } return null; }
	  public int countUpdate(int hit, int freeID, int number) {
		  String SQL= "update freecontent set hit= ? where freeID=? and number=?";
		  try {
			  PreparedStatement pstmt = conn.prepareStatement(SQL);
			  pstmt.setInt(1,hit);
			  pstmt.setInt(2, freeID);
			  pstmt.setInt(3, number);
		  return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		//�������� ������
		return -1;
	
	  }
	  public int delete(int roundID) {
			//db���ο� bbsAvailable�� 0���� �ٲ����ν� ����� ���忡���� ������ �Ǿ��ٰ� �� ���ִ�.
			//������ db���ο��� ������ �۵� �����ִ�.
			String SQL = "UPDATE freecontent SET Available = 0 WHERE roundID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				//bbsID���� ���� Avaliable���� 0���� �ٲ��ָ鼭 ���� ������Ű��
				pstmt.setInt(1, roundID);
				//����� ������ ������ �ߴٸ� 0�̻��� ���� ��ȯ�� �ϱ⿡
				return pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}
			//�������� ������
			return -1;
		}	

}
