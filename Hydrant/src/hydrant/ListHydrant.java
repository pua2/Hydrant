package hydrant;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.naming.Context;
import javax.naming.InitialContext;

public class ListHydrant {

	static final String url = "jdbc:mysql://localhost:3306/test";

	public static List GetHydrants() {

		List<String> list = new ArrayList<String>();

		try {

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			java.sql.Connection con;
			Statement stmt;
			ResultSet rs;

			Context ctx = new InitialContext();
			String connUrl = ("jdbc:mysql://localhost:3306/test");

			con = DriverManager.getConnection(connUrl, "root", "");
			stmt = con.createStatement();

			rs = stmt.executeQuery("SELECT LocationID, Latitude, Longitude FROM Location WHERE Approve = 0");

			while (rs.next()) {
				list.add(Double.toString(rs.getDouble("LocationID")));
				list.add(Double.toString(rs.getDouble("Latitude")));
				list.add(Double.toString(rs.getDouble("Longitude")));
			}

			con.close();

		} catch (Exception ex) {
			Logger.getLogger(ListHydrant.class.getName()).log(Level.SEVERE,
					null, ex);
		}
		return list;
	}

	public static void add(String id) {
		try {
			String add = "UPDATE Location SET Approve=1 WHERE LocationID = ?";

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			java.sql.Connection con;
			Statement stmt;
			ResultSet rs;

			Context ctx = new InitialContext();
			String connUrl = ("jdbc:mysql://localhost:3306/test");

			con = DriverManager.getConnection(connUrl, "root", "");
			stmt = con.createStatement();

			PreparedStatement ps = con.prepareStatement(add);

			ps.setString(1, id);
			ps.executeUpdate();
			con.close();

		} catch (Exception ex) {
			Logger.getLogger(ListHydrant.class.getName()).log(Level.SEVERE,
					null, ex);
		}
	}
}