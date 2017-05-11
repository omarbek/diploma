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
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;//

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		String user = request.getParameter("username");
		String pwd = request.getParameter("password");
		String shaPwd = DigestUtils.sha1Hex(pwd);

		Connection con = (new DBConnection()).getConnection();
		ResultSet rs;
		ResultSet rs2;
		HttpSession session = request.getSession();

		try {
			String sql = "SELECT * FROM users WHERE email = ? and password = ?";
			PreparedStatement prepStmt = con.prepareStatement(sql);
			prepStmt.setString(1, user);
			prepStmt.setString(2, shaPwd);
			rs = prepStmt.executeQuery();
			if (rs.next()) {
				String userState = rs.getString(4);
				if (userState.equals("1") || userState.equals("2") || userState.equals("3")) {
					session.setAttribute("userId", rs.getString(1));
					session.setAttribute("userEmail", rs.getString(2));
					session.setAttribute("userStatus", rs.getString(4));
					if (userState.equals("1")) {
						PreparedStatement prepStmt2 = con
								.prepareStatement("SELECT * FROM students WHERE user_id = " + rs.getString(1));
						rs2 = prepStmt2.executeQuery();
						if (rs2.next()) {
							session.setAttribute("studentID", rs2.getString(1));
							session.setAttribute("studentClass", rs2.getString(3));
						}
						response.sendRedirect("index.jsp");
					} else if (userState.equals("2")) {
						response.sendRedirect("admin.jsp");
					} else {// 3
						PreparedStatement prepStmt2 = con
								.prepareStatement("SELECT * FROM teachers WHERE user_id = " + rs.getString(1));
						rs2 = prepStmt2.executeQuery();

						if (rs2.next()) {
							session.setAttribute("teacherID", rs2.getString(1));
						}
						response.sendRedirect("teacher.jsp");
					}
				} else {
					response.sendRedirect("index.jsp");
				}

			} else {
				response.sendRedirect("index.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}