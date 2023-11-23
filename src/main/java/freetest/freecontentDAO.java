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
		// �̰� mysql���� ������ �ð��� �������� �ϳ��� ����
		String SQL = "SELECT NOW()";
		try {
			// ���� �Լ����� ������ ���ٿ� �־ �������������� ���� pstmt���� (���� ����� ��ü�� �̿��ؼ� SQL������ ���� �غ�ܰ��
			// ������ش�.)
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			// rs���ο� ������ ���������� ������ ����� �����´�
			rs = pstmt.executeQuery();
			// ����� �ִ°��� ������ ���� getString 1�� �ؼ� ������ �� ��¥�� ��ȯ�� �� �ְ� ���ش�.
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			// ���� �߻� ������ �ֿܼ� ���
			e.printStackTrace();
		}
		// �����ͺ��̽� �����ε� �����ؼ� �������� �� ���������⶧���� �������� �־��ش�.
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
		// db���ο� bbsAvailable�� 0���� �ٲ����ν� ����� ���忡���� ������ �Ǿ��ٰ� �� ���ִ�.
		// ������ db���ο��� ������ �۵� �����ִ�.
		String SQL = "UPDATE freecontent SET Available = 0 WHERE nu = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			// bbsID���� ���� Avaliable���� 0���� �ٲ��ָ鼭 ���� ������Ű��
			pstmt.setInt(1, number);
			// ����� ������ ������ �ߴٸ� 0�̻��� ���� ��ȯ�� �ϱ⿡
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		// �������� ������
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

			// ������ ������ �Ǹ� 0�̻��� ���� ��ȯ�Ǳ⶧���� �ٷν���
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}

}
