package magic;
import java.sql.Connection;    
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class magicshowDAO {
	private Connection conn;
	private ResultSet rs;
	
	public magicshowDAO() {
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
			String sql = "select magicID from magic order by magicID desc";
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
		 public ArrayList<magic> getList(int pageNumber,String userID) {
			  String SQL ="SELECT * FROM magic WHERE magicID < ? AND userID=? AND Available = 1 AND mcheck=1 ORDER BY magicID DESC LIMIT 8";
			  ArrayList<magic> list = new ArrayList<magic>(); 
			  try {
				  PreparedStatement pstmt= conn.prepareStatement(SQL); 
				  pstmt.setInt(1, getNext() - (pageNumber-1)*8);
				  pstmt.setString(2,userID );
				 
				 
		  rs = pstmt.executeQuery();
		  
		  while(rs.next()) { 
			  magic magic = new magic(); 
			  magic.setMagicID(rs.getInt(1));
			  magic.setmTitle(rs.getString(2)); 
			  magic.setUserID(rs.getString(3));
			  magic.setmInto(rs.getString(4)); 
			  magic.setmDate(rs.getString(5));
			  magic.setmAvailable(rs.getInt(6));
			  magic.setMcheck(rs.getInt(7));
			  magic.setMopen(rs.getInt(8));
		  
		  
		  list.add(magic); 
		  } }catch(Exception e) { e.printStackTrace(); } return list; 
	}
		 public boolean nextPage(int pageNumber) { String
			  SQL="SELECT * FROM magic WHERE magicID < ? AND mAvailable = 1 AND mcheck=1 ORDER BY magicID DESC LIMIT 8"
			  ;
			  
			  try { PreparedStatement pstmt = conn.prepareStatement(SQL);
			  pstmt.setInt(1,getNext() - (pageNumber -1) * 8); 
			  rs = pstmt.executeQuery();
			  if (rs.next()) { return true; } } catch(Exception e) { e.printStackTrace(); }
			  return false; }
			  
			  
			  
			  public magic getmagic(int magicID){
			  
			  String SQL ="SELECT * FROM magic WHERE magicID = ?"; 
			  try { PreparedStatement
			  pstmt = conn.prepareStatement(SQL); 
			  pstmt.setInt(1, magicID); 
			  rs = pstmt.executeQuery();
			  if (rs.next()) {
			  
				  magic magic = new magic(); 
				  magic.setMagicID(rs.getInt(1));
				  magic.setmTitle(rs.getString(2)); 
				  magic.setUserID(rs.getString(3));
				  magic.setmInto(rs.getString(4)); 
				  magic.setmDate(rs.getString(5));
				  magic.setmAvailable(rs.getInt(6));
				  magic.setMcheck(rs.getInt(7));
				  magic.setMopen(rs.getInt(8));
			  
			  
	
			  
			  return magic;
			  
			  } } catch (Exception e) { e.printStackTrace(); } return null; }
			  public int open(int magicID) {
					//db���ο� bbsAvailable�� 0���� �ٲ����ν� ����� ���忡���� ������ �Ǿ��ٰ� �� ���ִ�.
					//������ db���ο��� ������ �۵� �����ִ�.
					String SQL = "UPDATE magic SET mopen = 1 WHERE magicID = ?";
					try {
						PreparedStatement pstmt = conn.prepareStatement(SQL);
						pstmt.setInt(1, magicID);
						//����� ������ ������ �ߴٸ� 0�̻��� ���� ��ȯ�� �ϱ⿡
						return pstmt.executeUpdate();
					}catch(Exception e) {
						e.printStackTrace();
					}
					//�������� ������
					return -1;
				}
			  public int close(int magicID) {
					//db���ο� bbsAvailable�� 0���� �ٲ����ν� ����� ���忡���� ������ �Ǿ��ٰ� �� ���ִ�.
					//������ db���ο��� ������ �۵� �����ִ�.
					String SQL = "UPDATE magic SET mopen = 0 WHERE magicID = ?";
					try {
						PreparedStatement pstmt = conn.prepareStatement(SQL);
						pstmt.setInt(1, magicID);
						//����� ������ ������ �ߴٸ� 0�̻��� ���� ��ȯ�� �ϱ⿡
						return pstmt.executeUpdate();
					}catch(Exception e) {
						e.printStackTrace();
					}
					//�������� ������
					return -1;
				}
			  
}