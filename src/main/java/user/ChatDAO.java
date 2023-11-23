package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ChatDAO {
	DataSource dataSource;
	//DB접근
	public ChatDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/chat");
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//함수 생성
	public ArrayList<ChatDTO> getChatListByID(String fromID, String toID, String chatID){
		ArrayList<ChatDTO> chatList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM CHAT WHERE ((fromID = ? AND toID =?) OR (toID = ? AND fromID = ?)) AND chatID > ? ORDER BY chatTime";
		
		try {
			//db연결
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  fromID);
			pstmt.setString(2,  toID);
			pstmt.setString(3,  toID);
			pstmt.setString(4,  fromID);
			pstmt.setInt(5, Integer.parseInt(chatID));
			rs = pstmt.executeQuery();
			chatList = new ArrayList<ChatDTO>();
			while(rs.next()) {
				ChatDTO chat = new ChatDTO();
				chat.setChatID(rs.getInt("chatID"));
				chat.setFromID(rs.getString("fromID").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				chat.setToID(rs.getString("toID").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				chat.setChatContent(rs.getString("ChatContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11, 13));
				String timeType = "오전";
				if(chatTime > 12) {
					timeType = "오후";
					chatTime -= 12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0, 11) + " " + timeType + " " + chatTime + ":" + rs.getString("chatTime").substring(14, 16)+ "");
				chatList.add(chat);
						
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return chatList; //리스트 반환 
		
	}
	
		//대화 내역 중 최근 몇개만 가져옴
			public ArrayList<ChatDTO> getChatListByRecent(String fromID, String toID, int number){
				ArrayList<ChatDTO> chatList = null;
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String SQL = "SELECT * FROM CHAT WHERE ((fromID = ? AND toID =?) OR (fromID = ? and toID = ?)) AND chatID > (SELECT MAX(cahtID) - ? FROM CHAT) ORDER BY chatTime";
				
				try {
					//db연결
					conn = dataSource.getConnection();
					pstmt = conn.prepareStatement(SQL);
					pstmt.setString(1,  fromID);
					pstmt.setString(2,  toID);
					pstmt.setString(3,  toID);
					pstmt.setString(4,  fromID);
					pstmt.setInt(5, number);
					rs = pstmt.executeQuery();
					chatList = new ArrayList<ChatDTO>();
					while(rs.next()) {
						ChatDTO chat = new ChatDTO();
						chat.setChatID(rs.getInt("chatID"));
						chat.setFromID(rs.getString("fromID").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
						chat.setToID(rs.getString("toID").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
						chat.setChatContent(rs.getString("ChatContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
						int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11, 13));
						String timeType = "오전";
						if(chatTime > 12) {
							timeType = "오후";
							chatTime -= 12;
						}
						chat.setChatTime(rs.getString("chatTime").substring(0, 11) + " " + timeType + " " + chatTime + ":" + rs.getString("chatTime").substring(14, 16)+ "");
						chatList.add(chat);
								
					}
				} catch(Exception e) {
					e.printStackTrace();
				} finally {
					try {
						if(rs != null) rs.close();
						if(pstmt != null) pstmt.close();
						if(conn != null) conn.close();
					}catch(Exception e) {
						e.printStackTrace();
					}
				}
				return chatList; //리스트 반환 
				
			}
			
			// 채팅을 상대방에게 보내는 기능
			// fromID로부터 toID에게 어떠한 chatContent를 보내는지.
			public int submit(String fromID, String toID, String chatContent){
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String SQL = "INSERT INTO CHAT VALUES (NULL, ?, ?, ?, NOW())";
				try {
					//db연결
					conn = dataSource.getConnection();
					pstmt = conn.prepareStatement(SQL);
					pstmt.setString(1,  fromID);
					pstmt.setString(2,  toID);
					pstmt.setString(3,  chatContent);
					//성공적으로 채팅을 보냈다면  1개의 데이터에 삽입이 되서 1이라는 값이 반환
					return pstmt.executeUpdate();
				} catch(Exception e) {
					e.printStackTrace();
				} finally {
					try {
						if(rs != null) rs.close();
						if(pstmt != null) pstmt.close();
						if(conn != null) conn.close();
					}catch(Exception e) {
						e.printStackTrace();
					}
				}
				return -1; //데이터베이스 오류
				
			}
}
