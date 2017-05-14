package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;

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
		String city = request.getParameter("city");
		String school = request.getParameter("school");
		String studentClass = request.getParameter("studentClass");
		String classLetter = request.getParameter("classLetter");
		String userStatus = request.getParameter("userStatus");
		String userID = "";
		String schoolID = " ";

		Connection con = (new DBConnection()).getConnection();
		ResultSet rs;
		ResultSet rs2;
		ResultSet rs3;
		String shaPassword = DigestUtils.sha1Hex(password);
		try {
			String sql = "SELECT email FROM users WHERE email = ?";
			PreparedStatement prepStmt = con.prepareStatement(sql);
			prepStmt.setString(1, email);
			rs = prepStmt.executeQuery();
			String msg2 = "already have";
			if (rs.next()) {
				if (userStatus.equals("1")) {
					response.sendRedirect("index.jsp?navPage=registration&message=" + msg2);
				} else if (userStatus.equals("3")) {
					response.sendRedirect("index.jsp?navPage=registrationTeacher&message=" + msg2);
				}
			}

			else {
				String msg = "done";
				String sql2 = "INSERT INTO `users`(`user_id`, `email`, `password`, `status`)" + " VALUES (0, '" + email
						+ "', '" + shaPassword + "', " + userStatus + ");";
				String sql3 = "";
				PreparedStatement prepStmt2 = con.prepareStatement(sql2);
				prepStmt2.executeUpdate();

				PreparedStatement prepStmt4 = con
						.prepareStatement("select user_id from users where email='" + email + "'");
				rs2 = prepStmt4.executeQuery();

				if (rs2.next()) {
					userID = rs2.getString(1);
				}
				if (userStatus.equals("1")) {
					sql3 = "INSERT INTO `students`(`student_id`, `user_id`, `studentClass`, `first_name`, `last_name`, `school_name`, `city`, `classLetter`)"
							+ " VALUES (0, '" + userID + "', '" + studentClass + "', '" + userFirstName + "', '"
							+ userLastName + "', '" + school + "' , '" + city + "', '" + classLetter + "');";
					int studClass = Integer.parseInt(studentClass);

					for (int i = 1; i <= studClass * 8; i++) {
						String sql6 = "INSERT INTO user_topic (user_id, topic_id) values (" + userID + ", " + i + ")";
						PreparedStatement prepStmt6 = con.prepareStatement(sql6);
						prepStmt6.executeUpdate();
					}

					for (int i = 1; i <= studClass; i++) {
						String sql6 = "insert into test (user_id, grade) values (" + userID + ", " + i + ")";
						PreparedStatement prepStmt6 = con.prepareStatement(sql6);
						prepStmt6.executeUpdate();
					}
				} else if (userStatus.equals("3")) {
					sql3 = "INSERT INTO `teachers`(`teacher_id`, `user_id`, `first_name`, `last_name`, `school_name`, `city`)"
							+ " VALUES (0, '" + userID + "', '" + userFirstName + "', '" + userLastName + "', '"
							+ school + "' , '" + city + "');";
				}

				PreparedStatement prepStmt3 = con.prepareStatement(sql3);
				prepStmt3.executeUpdate();

				response.sendRedirect("index.jsp?message=" + msg);
			}
		} catch (Exception e) {
			response.sendRedirect("index.jsp");
		} finally {
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
