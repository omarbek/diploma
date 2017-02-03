package main;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String userLastName = request.getParameter("lastName");
		String userFirstName = request.getParameter("firstName");
		String email = request.getParameter("email");
		String password = request.getParameter("pwd");
		//String password2 = request.getParameter("pwd2");
		//String city = request.getParameter("city");
		String school = request.getParameter("school");
		String studentClass = request.getParameter("studentClass");
		String userStatus = request.getParameter("statusRadios");
		String userID = "";
		Connection con = (new DBConnection()).getConnection();
		ResultSet rs;
		ResultSet rs2;
		
		try{
			String sql = "SELECT email FROM users WHERE email = ?";
			PreparedStatement prepStmt = con.prepareStatement(sql);
			prepStmt.setString(1,email);
			rs = prepStmt.executeQuery();
			
			if (rs.next()){
				//out.println("Указанный вами " + email + " уже используется!");
				response.sendRedirect("index.jsp?navPage=registration");
			}
			
			else{
				String sql2 = "INSERT INTO `users`(`user_id`, `email`, `password`, `status`)"
						+ " VALUES (0, '" + email + "', '" + password + "', '" + userStatus + "');";
				String sql3 = "";
				PreparedStatement prepStmt2 = con.prepareStatement(sql2);
				prepStmt2.executeUpdate();
				PreparedStatement prepStmt4 = con.prepareStatement("select user_id from users where email='"+email+"'");
				rs2 = prepStmt4.executeQuery();
				if(rs2.next()){
					userID = rs2.getString(1);
				}
				if(userStatus.equals("1")){
					sql3 = "INSERT INTO `teachers`(`teacher_id`, `user_id`, `school_id`, `first_name`, `last_name`)"
							+ " VALUES (0, '" + userID + "', '" + school + "', '" + userFirstName + "', '" + userLastName + "');";
				}
				else if (userStatus.equals("2")){
					sql3 = "INSERT INTO `students`(`student_id`, `user_id`, `class_id`, `first_name`, `last_name`)"
							+ " VALUES (0, '" + userID + "', '" + studentClass + "', '" + userFirstName + "', '" + userLastName + "');";
				}			
				PreparedStatement prepStmt3 = con.prepareStatement(sql3);
				prepStmt3.executeUpdate();
				response.sendRedirect("index.jsp");
			}
		}
		catch(Exception e){
			System.out.println(e.getMessage());
		}
	}
}
