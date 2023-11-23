package test;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;      
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.multipart.Part;

import java.sql.Timestamp;

public class freeDAO {
	private static final HttpServletRequest HttpServletRequest = null;
	private static final HttpServletResponse HttpServletResponse = null;
	private Connection conn;
	private ResultSet rs;
	
	public freeDAO() {
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
	public int write(String fTitle,String userID,String fInto,String image_path) {
		 try {
		 
		  
		String sql = "insert into free values(?,?,?,?,?,?,?,?)";
		
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, getNext());
			
			pstmt.setString(2, fTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, fInto);
			pstmt.setInt(5, 1);
			pstmt.setInt(6, 0);
			pstmt.setInt(7,0);
			String imagePath = getUploadedImagePath(HttpServletRequest, HttpServletResponse);
		        pstmt.setString(8, image_path);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	private String getUploadedImagePath(javax.servlet.http.HttpServletRequest httpservletrequest2,
			javax.servlet.http.HttpServletResponse httpservletresponse2) {
		// TODO Auto-generated method stub
		return null;
	}

	/*
	 * public String getUploadedImagePath(HttpServletRequest request,
	 * HttpServletResponse response) throws IOException, ServletException { String
	 * image_path = null; try { // 이미지 업로드 처리 Part filePart = (Part)
	 * request.getPart("image"); String fileName = ((javax.servlet.http.Part)
	 * filePart).getSubmittedFileName(); String savePath = "C:\\images" +
	 * File.separator + fileName; ((javax.servlet.http.Part)
	 * filePart).write(savePath);
	 * 
	 * // 이미지 파일 경로를 반환 image_path = savePath; } catch (Exception e) {
	 * e.printStackTrace(); } return image_path; }
	 */
	public String getImagePathFromDatabase(int freeID) {
	    // 데이터베이스에서 postID를 기반으로 이미지 경로를 조회하는 로직
	    // 조회한 이미지 경로를 문자열로 반환
	    String image_path = ""; // 실제로 데이터베이스에서 이미지 경로를 가져오는 코드 작성

	    return image_path;
	}
	  public ArrayList<free> getList(int pageNumber,String userID) {
		  String SQL ="SELECT * FROM free WHERE freeID < ? AND userID=? AND fAvailable = 1 ORDER BY freeID DESC LIMIT 8";
		  ArrayList<free> list1 = new ArrayList<free>(); 
		  try {
			  PreparedStatement pstmt= conn.prepareStatement(SQL); 
			  pstmt.setInt(1, getNext() - (pageNumber-1)*8);
	  pstmt.setString(2,userID);
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
	  free.setImage_path(rs.getString(9));
	  
	  
	  list1.add(free); 
	  } }catch(Exception e) { e.printStackTrace(); } return list1; }
	  
	  
	  
	  public boolean nextPage(int pageNumber) 
	  { 
		  String SQL="SELECT * FROM free WHERE freeID < ? AND fAvailable = 1 ORDER BY freeID DESC LIMIT 8";
	  
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
	  free.setImage_path(rs.getString(9));
	  
	  
	  return free;
	  
	  } } catch (Exception e) { e.printStackTrace(); } return null; }
	 
	  public int check(int freeID) {
			//db내부에 bbsAvailable을 0으로 바꿈으로써 사용자 입장에서는 삭제가 되었다고 볼 수있다.
			//하지만 db내부에는 삭제된 글도 남아있다.
			String SQL = "UPDATE free SET fcheck = 1 WHERE freeID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, freeID);
				//결과가 무사히 성공을 했다면 0이상의 값이 반환을 하기에
				return pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}
			//나머지는 디비오류
			return -1;
		}	
	  
	  public ArrayList<free> getSearch(String searchField, String searchText){//특정한 리스트를 받아서 반환
	      ArrayList<free> list1 = new ArrayList<free>();
	      String SQL ="select * from free WHERE "+searchField.trim();
	      try {
	            if(searchText != null && !searchText.equals("") ){//이거 빼면 안 나온다ㅜ 왜지?
	                SQL +=" LIKE '%"+searchText.trim()+"%' order by freeID desc limit 8";
	            }
	            PreparedStatement pstmt=conn.prepareStatement(SQL);
				rs=pstmt.executeQuery();//select
	         while(rs.next()) {
	        	free free = new free();
	            
	        	free.setFreeID(rs.getInt(1));
	        	 free.setFreeID(rs.getInt(1));
	       	  
	       	  free.setfTitle(rs.getString(2)); 
	       	  free.setUserID(rs.getString(3));
	       	  free.setfInto(rs.getString(4));
	       	  free.setfDate(rs.getString(5));
	       	  free.setfAvailable(rs.getInt(6));
	       	  free.setFcheck(rs.getInt(7));
	       	  free.setFopen(rs.getInt(8));
	       	  free.setImage_path(rs.getString(9));
	       	  list1.add(free);
	         }         
	      } catch(Exception e) {
	         e.printStackTrace();
	      }
	      return list1;//ㄱㅔ시글 리스트 반환
	   }
	  public int delete(int freeID) {
			// db내부에 bbsAvailable을 0으로 바꿈으로써 사용자 입장에서는 삭제가 되었다고 볼 수있다.
			// 하지만 db내부에는 삭제된 글도 남아있다.
			String SQL = "UPDATE free SET fAvailable = 0 WHERE freeID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				// bbsID값에 글을 Avaliable값을 0으로 바꿔주면서 글을 삭제시키고
				pstmt.setInt(1, freeID);
				// 결과가 무사히 성공을 했다면 0이상의 값이 반환을 하기에
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 나머지는 디비오류
			return -1;
		}

		public int update(int freeID, String fTitle, String fInto) {
			// Table 내부에서 WHERE bbs ID 특정한 내부의 ID값에 대한 Title과 Content를 바꿔주겠다는 쿼리를 작성
			String SQL = "UPDATE free SET fTitle= ?, fInto =? WHERE freeID= ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, fTitle);
				pstmt.setString(2, fInto);
				pstmt.setInt(3, freeID);

				// 성공적 실행이 되면 0이상의 값이 반환되기때문에 바로실행
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; // 데이터베이스 오류
		}
	  
}

