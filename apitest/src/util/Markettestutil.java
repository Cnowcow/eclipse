package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class Markettestutil {
	
	public Connection getConnection() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/school";
			String dbid = "root";
			String dbpw = "mysql";
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection(dbURL, dbid, dbpw);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
