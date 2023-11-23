package like;

import java.sql.Connection;
import java.sql.DriverManager;

import java.sql.SQLException;

public class likeDAO {
	private static Connection conn;
	
	public static Connection getConnection() throws SQLException, ClassNotFoundException{

		String dbURL = "jdbc:mysql://localhost:3306/epicus";

		String dbID = "root";

		String dbPassword = "root";

		Class.forName("com.mysql.jdbc.Driver");

		return conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
	}
	
	
	
	
}
