package magic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import freetest.freecontent;

public class magiccontentDAO {
	private Connection conn;
	private ResultSet rs;
	
	public magiccontentDAO() {
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
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; 
	}  
	
	 public int getnumber() {
		  String sql="SELECT number FROM magiccontent ORDER BY number DESC";
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
	
	public int write(int magicID,int roundID,String genres,String genre_opinion,String keyword,String keyword_opinion,
			String time,String space,String time_opinion,String space_opinion,String natural_opinion,String social_opinion,
			String psychological_opinion,String situational_opinion,String other_opinion,String explanationInput,String nameInput,
			String genderInput,
			String internal_opinion,String external_opinion,String track_opinion,
			 String sub_opinion,String story_opinion,String main_opinion,String userID,String characteristics ) {
		String sql = "insert into magiccontent values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, magicID); 
			pstmt.setInt(2, roundID);
			pstmt.setInt(3, getnumber());
			pstmt.setString(4, genres);
			pstmt.setString(5, genre_opinion);
			pstmt.setString(6,keyword);
			pstmt.setString(7, keyword_opinion); 
			pstmt.setString(8, time);
			pstmt.setString(9, space);
			pstmt.setString(10, time_opinion);
			
			pstmt.setString(11,space_opinion);	
			pstmt.setString(12, natural_opinion); 
			pstmt.setString(13, social_opinion);
			pstmt.setString(14, psychological_opinion);
			pstmt.setString(15, situational_opinion);
			pstmt.setString(16,other_opinion);
			pstmt.setString(17, explanationInput); 
			pstmt.setString(18, nameInput);
			pstmt.setString(19, genderInput); 
			pstmt.setString(20, internal_opinion); 
			pstmt.setString(21, external_opinion);
			pstmt.setString(22, track_opinion);
			pstmt.setString(23, sub_opinion);
			pstmt.setString(24,story_opinion);
			pstmt.setString(25, main_opinion); 
			pstmt.setString(26, userID);
			pstmt.setString(27, getDate());
			
			pstmt.setInt(28, 1);
			pstmt.setInt(29, 0);
			pstmt.setInt(30, 0);
			pstmt.setString(31,characteristics);
			
			
	
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	 public ArrayList<magiccontent> getList(int pageNumber,int magicID,String userID) { 
		 String SQL = "SELECT * FROM magiccontent WHERE roundID < ? AND magicID=? AND userID=? AND Available = 1 ORDER BY roundID DESC LIMIT 10";
			  ArrayList<magiccontent> list = new ArrayList<magiccontent>(); 
			  try { 
				  PreparedStatement pstmt= conn.prepareStatement(SQL); 
				  pstmt.setInt(1, getroundID() - (pageNumber-1)*10);
				  pstmt.setInt(2, magicID);
				  pstmt.setString(3,userID);
			  rs = pstmt.executeQuery();
			  
			  while(rs.next()) { 
				  magiccontent magiccontent = new magiccontent();
				  magiccontent.setMagicID(rs.getInt(1));
				  magiccontent.setRoundID(rs.getInt(2));
				  magiccontent.setNumber(rs.getInt(3));
				  magiccontent.setGenres(rs.getString(4));
				  magiccontent.setGenre_opinion(rs.getString(5));
				  magiccontent.setKeyword(rs.getString(6));
				  magiccontent.setKeyword_opinion(rs.getString(7));
				  magiccontent.setTime(rs.getString(8));
				  magiccontent.setSpace(rs.getString(9));
				  magiccontent.setTime_opinion(rs.getString(10));
				  
				  magiccontent.setSpace_opinion(rs.getString(11));
				  magiccontent.setNatural_opinion(rs.getString(12));
				  magiccontent.setSocial_opinion(rs.getString(13));
				  magiccontent.setPsychological_opinion(rs.getString(14));
				  magiccontent.setSituational_opinion(rs.getString(15));
				  magiccontent.setOther_opinion(rs.getString(16));
				  magiccontent.setExplanationInput(rs.getString(17));
				  magiccontent.setNameInput(rs.getString(18));
				  magiccontent.setGenderInput(rs.getString(19));

				  magiccontent.setInternal_opinion(rs.getString(20));
				  magiccontent.setExternal_opinion(rs.getString(21));
				  magiccontent.setTrack_opinion(rs.getString(22));
				  magiccontent.setSub_opinion(rs.getString(23));
				  magiccontent.setStory_opinion(rs.getString(24));
				  magiccontent.setMain_opinion(rs.getString(25));
				  magiccontent.setUserID(rs.getString(26));
				  magiccontent.setMagicDate(rs.getString(27));
				  
				  magiccontent.setAvailable(rs.getInt(28));
				  magiccontent.setMagiccheck(rs.getInt(29));
				  magiccontent.setHit(rs.getInt(30));
				  magiccontent.setCharacteristics(rs.getString(31));

			  list.add(magiccontent); 
			  
			  } }catch(Exception e) { e.printStackTrace(); } return list; }
			  
			  public int getroundID() {
				  String sql="SELECT roundID FROM magiccontent ORDER BY roundID DESC";
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
				  String SQL="SELECT * FROM magiccontent WHERE roundID < ? AND Available = 1 ORDER BY roundID DESC LIMIT 5";
			  
			  try { PreparedStatement pstmt = conn.prepareStatement(SQL);
			  pstmt.setInt(1, getroundID() - (pageNumber -1) * 10); 
			  rs = pstmt.executeQuery();
			  if (rs.next()) { return true; } } catch(Exception e) { e.printStackTrace(); }
			  return false; }
			  
			  public boolean nextcontent(int contentNumber) {
					 String SQL="SELECT * FROM magiccontent WHERE roundID < ? AND Available = 1 ORDER BY roundID DESC LIMIT 1";
					 try { PreparedStatement pstmt = conn.prepareStatement(SQL);
					  pstmt.setInt(1, getroundID() - (contentNumber -1) * 1); 
					  rs = pstmt.executeQuery();
					  if (rs.next()) { return true; } } catch(Exception e) { e.printStackTrace(); }
					  return false;
				 }
			  
			  public magiccontent getmagiccontent(int magicID,int number){
			  
			  String SQL ="SELECT * FROM magiccontent WHERE magicID = ? AND number= ? "; 
			  try { 
			 PreparedStatement pstmt = conn.prepareStatement(SQL); 
			  pstmt.setInt(1, magicID);
			  pstmt.setInt(2,number);
			  rs = pstmt.executeQuery();
			  if (rs.next()) {
			  
				  magiccontent magiccontent = new magiccontent();
				  magiccontent.setMagicID(rs.getInt(1));
				  magiccontent.setRoundID(rs.getInt(2));
				  magiccontent.setNumber(rs.getInt(3));
				  magiccontent.setGenres(rs.getString(4));
				  magiccontent.setGenre_opinion(rs.getString(5));
				  magiccontent.setKeyword(rs.getString(6));
				  magiccontent.setKeyword_opinion(rs.getString(7));
				  magiccontent.setTime(rs.getString(8));
				  magiccontent.setSpace(rs.getString(9));
				  magiccontent.setTime_opinion(rs.getString(10));
				  
				  magiccontent.setSpace_opinion(rs.getString(11));
				  magiccontent.setNatural_opinion(rs.getString(12));
				  magiccontent.setSocial_opinion(rs.getString(13));
				  magiccontent.setPsychological_opinion(rs.getString(14));
				  magiccontent.setSituational_opinion(rs.getString(15));
				  magiccontent.setOther_opinion(rs.getString(16));
				  magiccontent.setExplanationInput(rs.getString(17));
				  magiccontent.setNameInput(rs.getString(18));
				  magiccontent.setGenderInput(rs.getString(19));

				  magiccontent.setInternal_opinion(rs.getString(20));
				  magiccontent.setExternal_opinion(rs.getString(21));
				  magiccontent.setTrack_opinion(rs.getString(22));
				  magiccontent.setSub_opinion(rs.getString(23));
				  magiccontent.setStory_opinion(rs.getString(24));
				  magiccontent.setMain_opinion(rs.getString(25));
				  magiccontent.setUserID(rs.getString(26));
				  magiccontent.setMagicDate(rs.getString(27));
				  
				  magiccontent.setAvailable(rs.getInt(28));
				  magiccontent.setMagiccheck(rs.getInt(29));
				  magiccontent.setHit(rs.getInt(30));
				  magiccontent.setCharacteristics(rs.getString(31));
			  
			  return magiccontent;
			  
			  } } catch (Exception e) { e.printStackTrace(); } return null; }

			  public int delete(int roundID) {
					String SQL = "UPDATE magiccontent SET Available = 0 WHERE roundID = ?";
					try {
						PreparedStatement pstmt = conn.prepareStatement(SQL);
						
						pstmt.setInt(1, roundID);
						//占쏙옙占쏙옙占� 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쌩다몌옙 0占싱삼옙占쏙옙 占쏙옙占쏙옙 占쏙옙환占쏙옙 占싹기에
						return pstmt.executeUpdate();
					}catch(Exception e) {
						e.printStackTrace();
					}
					//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙
					return -1;
				}	
			  public int update(int magicID,int roundID,String genres,String genre_opinion,String keyword,String keyword_opinion,
						String time,String space,String time_opinion,String space_opinion,String natural_opinion,String social_opinion,
						String psychological_opinion,String situational_opinion,String other_opinion,String explanationInput,String nameInput,
						String ageyInput,String residenceInput,String genderInput,String jobInput,String internal_opinion,String external_opinion,String track_opinion,
						 String sub_opinion,String story_opinion,String main_opinion) {
					//Table 占쏙옙占싸울옙占쏙옙 WHERE bbs ID 특占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 ID占쏙옙占쏙옙 占쏙옙占쏙옙 Title占쏙옙 Content占쏙옙 占쌕뀐옙占쌍겠다댐옙 占쏙옙占쏙옙占쏙옙 占쌜쇽옙
					String SQL = "UPDATE magiccontent SET genres = ?, genre_opinion = ?, keyword =?,keyword_opinion = ?, time = ?, space =?,time_opinion = ?, space_opinion = ?, natural_opinion =?,social_opinion = ?, psychological_opinion = ?, situational_opinion =?,other_opinion = ?, explanationInput = ?, nameInput =?"
						+ "ageyInput = ?, residenceInput =?,genderInput = ?, jobInput = ?, ,internal_opinion = ?, external_opinion = ?, sub_opinion =?,main_opinion = ? WHERE roundID = ? AND magicID= ?";
					try {
						PreparedStatement pstmt = conn.prepareStatement(SQL);

						
						pstmt.setInt(1, magicID); 
						pstmt.setInt(2, roundID);
						pstmt.setString(3, genres);
						pstmt.setString(4, genre_opinion);
						pstmt.setString(5,keyword);
						pstmt.setString(6, keyword_opinion); 
						pstmt.setString(7, time);
						pstmt.setString(8, space);
						pstmt.setString(9, time_opinion);
						pstmt.setString(10,space_opinion);
						
						pstmt.setString(11, natural_opinion); 
						pstmt.setString(12, social_opinion);
						pstmt.setString(13, psychological_opinion);
						pstmt.setString(14, situational_opinion);
						pstmt.setString(15,other_opinion);
						pstmt.setString(16, explanationInput); 
						pstmt.setString(17, nameInput);
						pstmt.setString(18, ageyInput);
						pstmt.setString(19,residenceInput);
						pstmt.setString(20, genderInput); 
						pstmt.setString(21, jobInput);
						
						pstmt.setString(22, internal_opinion); 
						pstmt.setString(23, external_opinion);
						pstmt.setString(24, track_opinion);
						pstmt.setString(25, genre_opinion);
						pstmt.setString(26,sub_opinion);
						pstmt.setString(27, main_opinion); 
					

						//占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占실몌옙 0占싱삼옙占쏙옙 占쏙옙占쏙옙 占쏙옙환占실기때占쏙옙占쏙옙 占쌕로쏙옙占쏙옙
						return pstmt.executeUpdate();
					} catch (Exception e) {
						e.printStackTrace();
					}
					return -1; // 占쏙옙占쏙옙占싶븝옙占싱쏙옙 占쏙옙占쏙옙
				}


}
