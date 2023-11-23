package test;
import java.sql.Connection;    
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class freeshowDAO {
	private Connection conn;
	private ResultSet rs;
	
	public freeshowDAO() {
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
			String sql = "select freeID from free order by freeID desc";
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
		 public ArrayList<free> getList(int pageNumber,String userID) {
			  String SQL ="SELECT * FROM free WHERE freeID < ? AND userID=? AND fAvailable = 1 AND fcheck=1 ORDER BY freeID DESC LIMIT 8";
			  ArrayList<free> list = new ArrayList<free>(); 
			  try {
				  PreparedStatement pstmt= conn.prepareStatement(SQL); 
				  pstmt.setInt(1, getNext() - (pageNumber-1)*8);
				  pstmt.setString(2,userID );
				 
				 
		  rs = pstmt.executeQuery();
		  
		  while(rs.next()) { 
		  free free = new free(); 
		  free.setFreeID(rs.getInt(1));
		  free.setfTitle(rs.getString(2)); 
		  free.setUserID(rs.getString(3));
		  free.setfInto(rs.getString(4));
		  free.setfDate(rs.getString(5));
		  free.setfAvailable(rs.getInt(6));
		  free.setFcheck(rs.getInt(7));
		  free.setFopen(rs.getInt(8));
		  
		  
		  list.add(free); 
		  } }catch(Exception e) { e.printStackTrace(); } return list; 
	}
		 public boolean nextPage(int pageNumber) { String
			  SQL="SELECT * FROM free WHERE freeID < ? AND fAvailable = 1 AND fcheck=1 ORDER BY freeID DESC LIMIT 8"
			  ;
			  
			  try { PreparedStatement pstmt = conn.prepareStatement(SQL);
			  pstmt.setInt(1,getNext() - (pageNumber -1) * 8); 
			  rs = pstmt.executeQuery();
			  if (rs.next()) { return true; } } catch(Exception e) { e.printStackTrace(); }
			  return false; }
			  
			  
			  
			  public free getfree(int freeID){
			  
			  String SQL ="SELECT * FROM free WHERE freeID = ?"; 
			  try { PreparedStatement
			  pstmt = conn.prepareStatement(SQL); 
			  pstmt.setInt(1, freeID); 
			  rs = pstmt.executeQuery();
			  if (rs.next()) {
			  
			  free free = new free(); 
			  free.setFreeID(rs.getInt(1));
			  free.setfTitle(rs.getString(2)); 
			  free.setUserID(rs.getString(3));
			  free.setfInto(rs.getString(4));
			  free.setfDate(rs.getString(5));
			  free.setfAvailable(rs.getInt(6));
			  free.setFcheck(rs.getInt(7));
			  free.setFopen(rs.getInt(8));
			  
			  
			  return free;
			  
			  } } catch (Exception e) { e.printStackTrace(); } return null; }
			  public int open(int freeID) {
					//db���ο� bbsAvailable�� 0���� �ٲ����ν� ����� ���忡���� ������ �Ǿ��ٰ� �� ���ִ�.
					//������ db���ο��� ������ �۵� �����ִ�.
					String SQL = "UPDATE free SET fopen = 1 WHERE freeID = ?";
					try {
						PreparedStatement pstmt = conn.prepareStatement(SQL);
						pstmt.setInt(1, freeID);
						//����� ������ ������ �ߴٸ� 0�̻��� ���� ��ȯ�� �ϱ⿡
						return pstmt.executeUpdate();
					}catch(Exception e) {
						e.printStackTrace();
					}
					//�������� ������
					return -1;
				}
			  public int close(int freeID) {
					//db���ο� bbsAvailable�� 0���� �ٲ����ν� ����� ���忡���� ������ �Ǿ��ٰ� �� ���ִ�.
					//������ db���ο��� ������ �۵� �����ִ�.
					String SQL = "UPDATE free SET fopen = 0 WHERE freeID = ?";
					try {
						PreparedStatement pstmt = conn.prepareStatement(SQL);
						pstmt.setInt(1, freeID);
						//����� ������ ������ �ߴٸ� 0�̻��� ���� ��ȯ�� �ϱ⿡
						return pstmt.executeUpdate();
					}catch(Exception e) {
						e.printStackTrace();
					}
					//�������� ������
					return -1;
				}
			  
}