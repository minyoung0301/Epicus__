package magic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import magic.magic;
import test.free;

public class magicDAO {
	private Connection conn;
	private ResultSet rs;
	
	public magicDAO() {
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
	public int getNext() { 
		String sql = "select magicID from magic order by magicID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int write(String mTitle,String userID,String mInto) {
		String sql = "insert into magic values(?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, getNext());
			pstmt.setString(2, mTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, mInto);
			pstmt.setString(5,getDate());
			pstmt.setInt(6, 1);
			pstmt.setInt(7, 0);
			pstmt.setInt(8, 1);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	  public ArrayList<magic> getList(int pageNumber,String userID) {
		  String SQL ="SELECT * FROM magic WHERE magicID < ? AND userID=? AND mAvailable = 1 ORDER BY magicID DESC LIMIT 10";
		  ArrayList<magic> list = new ArrayList<magic>(); 
		  try {
			  PreparedStatement pstmt= conn.prepareStatement(SQL); 
			  pstmt.setInt(1, getNext() - (pageNumber-1)*8);
	  pstmt.setString(2,userID);
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
	  } }catch(Exception e) { e.printStackTrace(); } return list; }
	  
	  
	  
	  public boolean nextPage(int pageNumber) { String
	  SQL="SELECT * FROM magic WHERE magicID < ? AND mAvailable = 1 ORDER BY magicID DESC LIMIT 10"
	  ;
	  
	  try { PreparedStatement pstmt = conn.prepareStatement(SQL);
	  pstmt.setInt(1,getNext() - (pageNumber -1) * 10); 
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
	  
	  public int check(int magicID) {
			//db내부에 bbsAvailable을 0으로 바꿈으로써 사용자 입장에서는 삭제가 되었다고 볼 수있다.
			//하지만 db내부에는 삭제된 글도 남아있다.
			String SQL = "UPDATE magic SET mcheck = 1 WHERE magicID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, magicID);
				//결과가 무사히 성공을 했다면 0이상의 값이 반환을 하기에
				return pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}
			//나머지는 디비오류
			return -1;
		}	
	  public ArrayList<magic> getSearch(String searchField, String searchText){//특정한 리스트를 받아서 반환
	      ArrayList<magic> list = new ArrayList<magic>();
	      String SQL ="select * from free WHERE "+searchField.trim();
	      try {
	            if(searchText != null && !searchText.equals("") ){//이거 빼면 안 나온다ㅜ 왜지?
	                SQL +=" LIKE '%"+searchText.trim()+"%' order by freeID desc limit 8";
	            }
	            PreparedStatement pstmt=conn.prepareStatement(SQL);
				rs=pstmt.executeQuery();//select
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
	         }         
	      } catch(Exception e) {
	         e.printStackTrace();
	      }
	      return list;//ㄱㅔ시글 리스트 반환
	   }
	 


}
