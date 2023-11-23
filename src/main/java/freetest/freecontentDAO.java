package freetest;

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


public class freecontentDAO {
	private Connection conn;
	private ResultSet rs;

	public freecontentDAO() {

		try {
			String dbURL = "jdbc:mysql://localhost:3306/epicus?characterEncoding=utf8&serverTimezone=UTC&useSSL=false";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getDate() {
		// 이건 mysql에서 현재의 시간을 가져오는 하나의 문장
		String SQL = "SELECT NOW()";
		try {
			// 각각 함수끼리 데이터 접근에 있어서 마찰방지용으로 내부 pstmt선언 (현재 연결된 객체를 이용해서 SQL문장을 실행 준비단계로
			// 만들어준다.)
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			// rs내부에 실제로 실행했을때 나오는 결과를 가져온다
			rs = pstmt.executeQuery();
			// 결과가 있는경우는 다음과 같이 getString 1을 해서 현재의 그 날짜를 반환할 수 있게 해준다.
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			// 오류 발생 내용을 콘솔에 띄움
			e.printStackTrace();
		}
		// 데이터베이스 오류인데 웬만해선 디비오류가 날 이유가없기때문에 빈문장으로 넣어준다.
		return "";
	}
	 
	public int write(int freeID, int roundID, String subtitle, String summary, String story, String userID) {
		String sql = "insert into freecontent values(?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, freeID);

			pstmt.setInt(2, roundID);
			pstmt.setInt(3, getnumber());
			pstmt.setString(4, subtitle);
			pstmt.setString(5, summary);
			pstmt.setString(6, story);
			pstmt.setString(7, userID);
			pstmt.setString(8, getDate());
			pstmt.setInt(9, 1);
			pstmt.setInt(10, 0);
			pstmt.setInt(11, 0);
			pstmt.setInt(12, 0);

			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public ArrayList<freecontent> getList2(int pageNumber, int freeID, String userID) {
		String SQL = "SELECT * FROM freecontent WHERE roundID < ? AND freeID=? AND userID=? AND Available = 1 ORDER BY  LIMIT 5";
		ArrayList<freecontent> list = new ArrayList<freecontent>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getroundID() - (pageNumber - 1) * 5);
			pstmt.setInt(2, freeID);
			pstmt.setString(3, userID);
			rs = pstmt.executeQuery();

			while (rs.next()) {
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
				freecontent.setHit(rs.getInt(11));
				freecontent.setLike_count(rs.getInt(12));

				list.add(freecontent);

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<freecontent> getList(int pageNumber, int freeID, String userID) {
		String SQL = "SELECT * FROM freecontent WHERE roundID < ? AND freeID=? AND userID=? AND Available = 1 ORDER BY roundID LIMIT 5";
		ArrayList<freecontent> list = new ArrayList<freecontent>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getroundID() - (pageNumber - 1) * 5);
			pstmt.setInt(2, freeID);
			pstmt.setString(3, userID);
			rs = pstmt.executeQuery();

			while (rs.next()) {
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
				freecontent.setHit(rs.getInt(11));
				freecontent.setLike_count(rs.getInt(12));

				list.add(freecontent);

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public int getroundID() {
		String sql = "SELECT roundID FROM freecontent ORDER BY roundID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;

	}

	public int getnumber() {
		String sql = "SELECT number FROM freecontent ORDER BY number DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;

	}

	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM freecontent WHERE roundID < ? AND Available = 1 ORDER BY roundID DESC LIMIT 5";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getroundID() - (pageNumber - 1) * 5);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean nextcontent(int contentNumber) {
		String SQL = "SELECT * FROM freecontent WHERE roundID < ? AND Available = 1 ORDER BY roundID DESC LIMIT 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getroundID() - (contentNumber - 1) * 1);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public freecontent getfreecontent(int freeID, int number) {

		String SQL = "SELECT * FROM freecontent WHERE freeID = ? AND number=?";
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
				freecontent.setHit(rs.getInt(11));
				freecontent.setLike_count(rs.getInt(12));
				return freecontent;

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public int delete(int number) {
		// db내부에 bbsAvailable을 0으로 바꿈으로써 사용자 입장에서는 삭제가 되었다고 볼 수있다.
		// 하지만 db내부에는 삭제된 글도 남아있다.
		String SQL = "UPDATE freecontent SET Available = 0 WHERE nu = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			// bbsID값에 글을 Avaliable값을 0으로 바꿔주면서 글을 삭제시키고
			pstmt.setInt(1, number);
			// 결과가 무사히 성공을 했다면 0이상의 값이 반환을 하기에
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 나머지는 디비오류
		return -1;
	}

	public int update(int freeID, int number, int roundID, String subtitle, String summary, String story) {
		
		String SQL = "UPDATE freecontent SET roundID=?, subtitle = ?, summary = ?, story =? WHERE number = ? AND freeID= ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, roundID);
			pstmt.setString(2, subtitle);
			pstmt.setString(3, summary);
			pstmt.setString(4, story);
			pstmt.setInt(5, number);
			pstmt.setInt(6, freeID);

			// 성공적 실행이 되면 0이상의 값이 반환되기때문에 바로실행
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

}
