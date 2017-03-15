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
 * Servlet implementation class DeleteEditProfileServlet
 */
@WebServlet("/DeleteEditProfileServlet")
public class DeleteEditProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		Connection con = (new DBConnection()).getConnection();
		String function_type = request.getParameter("function_type");
		String userLastName = request.getParameter("lastName");
		String userFirstName = request.getParameter("firstName");
		String email = request.getParameter("email");
		String password = request.getParameter("pwd");
		String city = request.getParameter("city");
		String school = request.getParameter("school");
		String studentClass = request.getParameter("studentClass");
		String user_id = (String) session.getAttribute("userId");
		String studentSchoolId = (String) session.getAttribute("studentSchoolId");
		String shaPassword = DigestUtils.sha1Hex(password);
		
		try{
			if (function_type.equals("deleteProfile")){
				String deleteFromUsers = "UPDATE `users` SET `status`=? WHERE user_id=?";
				PreparedStatement prepStmt = con.prepareStatement(deleteFromUsers);
				prepStmt.setString(1, "0");
				prepStmt.setString(2, user_id);
				prepStmt.executeUpdate();
				request.getRequestDispatcher("LogoutServlet").forward(request,response);
			}
			else if (function_type.equals("editProfile")){
				if (email != null && email != ""){
					String updateUserProfile = "UPDATE `users` SET `email`='"+email+"' WHERE user_id="+user_id;
					PreparedStatement prepStmt2 = con.prepareStatement(updateUserProfile);
					prepStmt2.executeUpdate();
				}
				if (password != null && password != ""){
					String updateUserProfile = "UPDATE `users` SET `password`='"+shaPassword+"' WHERE user_id="+user_id;
					PreparedStatement prepStmt2 = con.prepareStatement(updateUserProfile);
					prepStmt2.executeUpdate();
				}
				if (userLastName != null && userLastName != ""){
					String updateUserProfile = "UPDATE `students` SET `last_name`='"+userLastName+"' WHERE user_id="+user_id;
					PreparedStatement prepStmt2 = con.prepareStatement(updateUserProfile);
					prepStmt2.executeUpdate();
				}
				if (userFirstName != null && userFirstName != ""){
					String updateUserProfile = "UPDATE `students` SET `first_name`='"+userFirstName+"' WHERE user_id="+user_id;
					PreparedStatement prepStmt2 = con.prepareStatement(updateUserProfile);
					prepStmt2.executeUpdate();
				}
				if (studentClass != null && studentClass != ""){
					String updateUserProfile = "UPDATE `students` SET `studentClass`='"+studentClass+"' WHERE user_id="+user_id;
					PreparedStatement prepStmt2 = con.prepareStatement(updateUserProfile);
					prepStmt2.executeUpdate();
				}
				if (school != null && school != ""){
					if (city == null || city == ""){
						String studentSchoolCity = "select city from schools where school_id="+studentSchoolId;
						PreparedStatement prepStmtStudentSchoolCity = con.prepareStatement(studentSchoolCity);
						ResultSet rsStudentSchoolCity = prepStmtStudentSchoolCity.executeQuery();
						if (rsStudentSchoolCity.next()){
							String schoolExist = "select * from schools where school_name='"+school+"' and city='"+rsStudentSchoolCity.getString(1)+"'";
							PreparedStatement prepStmtSchoolExist = con.prepareStatement(schoolExist);
							ResultSet rsSchoolExist = prepStmtSchoolExist.executeQuery();				
							if(rsSchoolExist.next()){
								String updateUserProfile = "UPDATE `students` SET `school_id`='"+rsSchoolExist.getString(1)+"' WHERE user_id="+user_id;
								PreparedStatement prepStmt2 = con.prepareStatement(updateUserProfile);
								prepStmt2.executeUpdate();
							}
							else {
								String insertNewSchool = "INSERT INTO `schools`(`school_id`, `school_name`, `city`) VALUES (0,'" + school
										+ "','" + rsStudentSchoolCity.getString(1) + "');";
								PreparedStatement prepStmtInsertNewSchool = con.prepareStatement(insertNewSchool);
								prepStmtInsertNewSchool.executeUpdate();
								rsSchoolExist = prepStmtSchoolExist.executeQuery();
								if(rsSchoolExist.next()){
									String updateUserProfile = "UPDATE `students` SET `school_id`='"+rsSchoolExist.getString(1)+"' WHERE user_id="+user_id;
									PreparedStatement prepStmt2 = con.prepareStatement(updateUserProfile);
									prepStmt2.executeUpdate();
								}
							}	
						}
					}	
					else {
						String schoolExist = "select * from schools where school_name='"+school+"' and city='"+city+"'";
						PreparedStatement prepStmtSchoolExist = con.prepareStatement(schoolExist);
						ResultSet rsSchoolExist = prepStmtSchoolExist.executeQuery();
						if (rsSchoolExist.next()){
							String updateUserProfile = "UPDATE `students` SET `school_id`='"+rsSchoolExist.getString(1)+"' WHERE user_id="+user_id;
							PreparedStatement prepStmt2 = con.prepareStatement(updateUserProfile);
							prepStmt2.executeUpdate();
						}
						else {
							String insertNewSchool = "INSERT INTO `schools`(`school_id`, `school_name`, `city`) VALUES (0,'" + school
									+ "','" + city + "');";
							PreparedStatement prepStmtInsertNewSchool = con.prepareStatement(insertNewSchool);
							prepStmtInsertNewSchool.executeUpdate();
							rsSchoolExist = prepStmtSchoolExist.executeQuery();
							if (rsSchoolExist.next()){
								String updateUserProfile = "UPDATE `students` SET `school_id`='"+rsSchoolExist.getString(1)+"' WHERE user_id="+user_id;
								PreparedStatement prepStmt2 = con.prepareStatement(updateUserProfile);
								prepStmt2.executeUpdate();
							}
						}
					}
				}
				if (school == null || school == ""){
					String studentSchoolName = "select school_name from schools where school_id="+studentSchoolId;
					PreparedStatement prepStmtStudentSchoolName = con.prepareStatement(studentSchoolName);
					ResultSet rsStudentSchoolName = prepStmtStudentSchoolName.executeQuery();
					if (rsStudentSchoolName.next()){
						if (city != null && city != ""){
							String schoolExist = "select * from schools where school_name='"+rsStudentSchoolName.getString(1)+"' and city='"+city+"'";
							PreparedStatement prepStmtSchoolExist = con.prepareStatement(schoolExist);
							ResultSet rsSchoolExist = prepStmtSchoolExist.executeQuery();
							if (rsSchoolExist.next()){
								String updateUserProfile = "UPDATE `students` SET `school_id`='"+rsSchoolExist.getString(1)+"' WHERE user_id="+user_id;
								PreparedStatement prepStmt2 = con.prepareStatement(updateUserProfile);
								prepStmt2.executeUpdate();
							}
							else {
								String insertNewSchool = "INSERT INTO `schools`(`school_id`, `school_name`, `city`) VALUES (0,'" + rsStudentSchoolName.getString(1)
										+ "','" + city + "');";
								PreparedStatement prepStmtInsertNewSchool = con.prepareStatement(insertNewSchool);
								prepStmtInsertNewSchool.executeUpdate();
								rsSchoolExist = prepStmtSchoolExist.executeQuery();
								if (rsSchoolExist.next()){
									String updateUserProfile = "UPDATE `students` SET `school_id`='"+rsSchoolExist.getString(1)+"' WHERE user_id="+user_id;
									PreparedStatement prepStmt2 = con.prepareStatement(updateUserProfile);
									prepStmt2.executeUpdate();
								}
							}
						}
					}			
				}
				response.sendRedirect("index.jsp?navPage=profile");
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}

}
