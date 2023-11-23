package user;

import java.sql.Connection;  
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private ResultSet rs2;

	public UserDAO() {

		try {
			String dbURL =  "jdbc:mysql://localhost:3306/epicus?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public User getUserByID(String userID) {
        String SQL = "SELECT * FROM USER WHERE userID = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserName(rs.getString("userName"));
                user.setUserID(rs.getString("userID"));
                user.setUserPwd(rs.getString("userPwd"));
                user.setUserEmail(rs.getString("userEmail"));
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
	
	public int login(String userID, String userPwd) {
		String SQL = "SELECT userPwd FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL); 

			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(userPwd))
					return 1;
			 else 
				return 0;
			}
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1, user.getUserName());
			pstmt.setString(2, user.getUserID());
			pstmt.setString(3, user.getUserPwd());
			pstmt.setString(4, user.getUserEmail());
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	  public ArrayList<User> getAllUsers() {
		  ArrayList<User> userList = new ArrayList<>();
	        String SQL = "SELECT * FROM USER WHERE userID <> 'admin' ";
	        try {
	            pstmt = conn.prepareStatement(SQL);
	            rs = pstmt.executeQuery();
	            
	            while (rs.next()) {
	                User user = new User();
	                user.setUserName(rs.getString("userName"));
	                user.setUserID(rs.getString("userID"));
	                user.setUserPwd(rs.getString("userPwd"));
	                user.setUserEmail(rs.getString("userEmail"));
	                userList.add(user);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return userList;
	    }
	  
	  public int followUser(String followerID, String followingID) {
		    String SQL = "INSERT INTO follow (followerID, followingID) VALUES (?, ?)";
		    try {
		        pstmt = conn.prepareStatement(SQL);
		        pstmt.setString(1, followerID);
		        pstmt.setString(2, followingID);
		        return pstmt.executeUpdate();
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return -1;
		}
	  
	  public List<User> getFollowingList(String followerID) {
	        List<User> followingList = new ArrayList<>();
	        String SQL = "SELECT u.* FROM follow f INNER JOIN user u ON f.followingID = u.userID  WHERE f.followerID = ? ";
	        try {
	            pstmt = conn.prepareStatement(SQL);
	            pstmt.setString(1, followerID);
	            
	            rs = pstmt.executeQuery();
	            while (rs.next()) {
	                User user = new User();
	                
	                user.setUserName(rs.getString("userName"));
	                user.setUserID(rs.getString("userID"));
	                user.setUserEmail(rs.getString("userEmail"));
	                followingList.add(user);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return followingList;
	    }
	  public List<User> getFollowingList2(String followerID) {
	        List<User> followingList2= new ArrayList<>();
	        String SQL = "SELECT u.* FROM follow f INNER JOIN user u ON f.followingID = u.userID  WHERE f.followerID = ? ";
	        try {
	            pstmt = conn.prepareStatement(SQL);
	            pstmt.setString(1, followerID);
	            
	            rs2 = pstmt.executeQuery();
	            while (rs2.next()) {
	                User user = new User();
	                
	                user.setUserName(rs2.getString("userName"));
	                user.setUserID(rs2.getString("userID"));
	                user.setUserEmail(rs2.getString("userEmail"));
	                followingList2.add(user);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return followingList2;
	    }
}

