package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;

/**
 * Servlet implementation class DeleteEditProfileServlet
 */
@WebServlet("/DeleteEditProfileServlet")
public class DeleteEditProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		Connection con = (new DBConnection()).getConnection();
		String function_type = request.getParameter("function_type");

		String user_id = (String) session.getAttribute("userId");
		try {
			if (function_type.equals("deleteProfile")) {
				String deleteFromUsers = "UPDATE `users` SET `status`=? WHERE user_id=?";
				PreparedStatement prepStmt = con
						.prepareStatement(deleteFromUsers);
				prepStmt.setString(1, "0");
				prepStmt.setString(2, user_id);
				prepStmt.executeUpdate();
				request.getRequestDispatcher("LogoutServlet").forward(request,
						response);
			} else if (function_type.equals("editProfile")) {
				String userLastName = request.getParameter("lastName");
				String userFirstName = request.getParameter("firstName");
				String email = request.getParameter("email");
				String password = request.getParameter("pwd");
				String city = request.getParameter("city");
				String school = request.getParameter("school");
				String studentClass = request.getParameter("studentClass");

				if (email != null && email != "") {
					String updateUserProfile = "UPDATE `users` SET `email`='"
							+ email + "' WHERE user_id=" + user_id;
					PreparedStatement prepStmt2 = con
							.prepareStatement(updateUserProfile);
					prepStmt2.executeUpdate();
				}
				if (password != null && password != "") {
					String shaPassword = DigestUtils.sha1Hex(password);
					String updateUserProfile = "UPDATE `users` SET `password`='"
							+ shaPassword + "' WHERE user_id=" + user_id;
					PreparedStatement prepStmt2 = con
							.prepareStatement(updateUserProfile);
					prepStmt2.executeUpdate();
				}
				if (userLastName != null && userLastName != "") {
					String updateUserProfile = "UPDATE `students` SET `last_name`='"
							+ userLastName + "' WHERE user_id=" + user_id;
					PreparedStatement prepStmt2 = con
							.prepareStatement(updateUserProfile);
					prepStmt2.executeUpdate();
				}
				if (userFirstName != null && userFirstName != "") {
					String updateUserProfile = "UPDATE `students` SET `first_name`='"
							+ userFirstName + "' WHERE user_id=" + user_id;
					PreparedStatement prepStmt2 = con
							.prepareStatement(updateUserProfile);
					prepStmt2.executeUpdate();
				}
				if (studentClass != null && studentClass != "") {
					String updateUserProfile = "UPDATE `students` SET `studentClass`='"
							+ studentClass + "' WHERE user_id=" + user_id;
					PreparedStatement prepStmt2 = con
							.prepareStatement(updateUserProfile);
					prepStmt2.executeUpdate();
				}
				if (school != null && school != "") {
					String updateUserProfile = "UPDATE `students` SET `school_name`='"
							+ school + "' WHERE user_id=" + user_id;
					PreparedStatement prepStmt2 = con
							.prepareStatement(updateUserProfile);
					prepStmt2.executeUpdate();

				}
				if (city != null && city != "") {
					String updateUserProfile = "UPDATE `students` SET `city`='"
							+ city + "' WHERE user_id=" + user_id;
					PreparedStatement prepStmt2 = con
							.prepareStatement(updateUserProfile);
					prepStmt2.executeUpdate();
				}
				response.sendRedirect("index.jsp?navPage=profile");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
