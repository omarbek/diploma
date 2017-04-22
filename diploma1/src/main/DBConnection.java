package main;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	public Connection getConnection() {
		Connection con;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://funnykazakh.cen8uooptsxi.us-west-2.rds.amazonaws.com:3306/funny_kazakh?useUnicode=true&characterEncoding=UTF-8", "root", "aqw123355");
			return con;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
}
