package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		String userLastName = request.getParameter("lastName");
		String userFirstName = request.getParameter("firstName");
		String email = request.getParameter("email");
		String password = request.getParameter("pwd");
		// String password2 = request.getParameter("pwd2");
		String city = request.getParameter("city");
		String school = request.getParameter("school");
		String studentClass = request.getParameter("studentClass");
		String userID = "";
		String schoolID = " ";
		Connection con = (new DBConnection()).getConnection();
		ResultSet rs;
		ResultSet rs2;
		ResultSet rs3;

		try {
			String sql = "SELECT email FROM users WHERE email = ?";
			PreparedStatement prepStmt = con.prepareStatement(sql);
			prepStmt.setString(1, email);
			rs = prepStmt.executeQuery();

			if (rs.next()) {
				response.sendRedirect("index.jsp?navPage=registration");
			}

			else {
				String sql2 = "INSERT INTO `users`(`user_id`, `email`, `password`, `status`)" + " VALUES (0, '" + email
						+ "', '" + password + "', '2');";
				String sql3 = "";
				PreparedStatement prepStmt2 = con.prepareStatement(sql2);
				prepStmt2.executeUpdate();

				String sql4 = "select * from schools where school_name='" + school + "' and city='" + city + "'";
				PreparedStatement prepStmt5 = con.prepareStatement(sql4);
				rs3 = prepStmt5.executeQuery();
				if (rs3.next()) {
					schoolID = rs3.getString(1);
				} else {
					String sql5 = "INSERT INTO `schools`(`school_id`, `school_name`, `city`) VALUES (0,'" + school
							+ "','" + city + "');";
					PreparedStatement prepStmt6 = con.prepareStatement(sql5);
					prepStmt6.executeUpdate();
					rs3 = prepStmt5.executeQuery();
					if (rs3.next()) {
						schoolID = rs3.getString(1);
					}
				}

				PreparedStatement prepStmt4 = con
						.prepareStatement("select user_id from users where email='" + email + "'");
				rs2 = prepStmt4.executeQuery();

				if (rs2.next()) {
					userID = rs2.getString(1);
				}
				sql3 = "INSERT INTO `students`(`student_id`, `user_id`, `studentClass`, `first_name`, `last_name`, `school_id`)"
							+ " VALUES (0, '" + userID + "', '" + studentClass + "', '" + userFirstName + "', '"
							+ userLastName + "', '" + schoolID + "');";
				PreparedStatement prepStmt3 = con.prepareStatement(sql3);
				prepStmt3.executeUpdate();

				int studClass = Integer.parseInt(studentClass);

				for (int i = 1; i <= studClass * 8; i++) {
					String sql6 = "INSERT INTO user_topic (user_id, topic_id) values (" + userID + ", " + i + ")";
					PreparedStatement prepStmt6 = con.prepareStatement(sql6);
					prepStmt6.executeUpdate();
				}

				response.sendRedirect("index.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
