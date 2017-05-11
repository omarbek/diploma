package main;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.FileItemIterator;
import org.apache.tomcat.util.http.fileupload.FileItemStream;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class AdminServlet
 */
@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		Connection con = (new DBConnection()).getConnection();

		String name = null;
		String classNumber = null;
		Long topicId = null;
		Long wordId = null;
		String page = null;
		String rus = null;
		String kaz = null;

		boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
		if (isMultiPart) {
			ServletFileUpload upload = new ServletFileUpload();
			try {
				FileItemIterator itr = upload.getItemIterator(request);

				while (itr.hasNext()) {
					FileItemStream item = itr.next();
					if (item.isFormField()) {
						String fieldName = item.getFieldName();
						InputStream is = item.openStream();
						byte[] b = new byte[is.available()];
						is.read(b);
						String value = new String(b);
						response.getWriter().println(fieldName + ":" + value + "<br/>");
						if (fieldName.equalsIgnoreCase("name")) {
							name = value;
						} else if (fieldName.equalsIgnoreCase("page")) {
							page = value;
						} else if (fieldName.equalsIgnoreCase("topic_id")) {
							topicId = Long.parseLong(value);
						} else if (fieldName.equalsIgnoreCase("word_id")) {
							wordId = Long.parseLong(value);
						} else if (fieldName.equalsIgnoreCase("rus")) {
							rus = value;
						} else if (fieldName.equalsIgnoreCase("kaz")) {
							kaz = value;
						} else {
							classNumber = value;
						}
					} else {
						if ("add_topic".equals(page)) {
							try {
								PreparedStatement ps = con.prepareStatement("");
								ps.executeUpdate("INSERT INTO `topics` (topic_name,grade) values ('" + name + "', "
										+ classNumber + ")");

								ResultSet rs = ps.executeQuery("select topic_id from topics where topic_name='" + name
										+ "' and grade=" + classNumber);
								if (rs.next()) {
									topicId = rs.getLong(1);
								}

							} catch (SQLException e) {
								e.printStackTrace();
							}

							String path = "C:/Users/Омарбек/git/kazakh/diploma1/WebContent";
							// String output =
							// item.getName().substring(item.getName().indexOf('.'),
							// item.getName().length());
							String nameOfImage = topicId + ".jpg";
							if (!item.getName().isEmpty()) {
								Word.processFile(path, item, nameOfImage, "img/subjects");
							}

							String grade = Word.getGrade(classNumber);
							response.sendRedirect(
									"admin.jsp?navPage=a_topics&grade=" + grade + "&classId=4&refresh=true");
						}
						if (page.equals("add_word")) {
							try {
								PreparedStatement insertWord = con.prepareStatement(
										"insert into words (word_rus, word_kaz) values ('" + rus + "', '" + kaz + "')");
								insertWord.executeUpdate();

								PreparedStatement selectWord = con.prepareStatement(
										"select * from words where word_rus='" + rus + "' and word_kaz='" + kaz + "'");
								ResultSet rs = selectWord.executeQuery();
								if (rs.next()) {
									wordId = rs.getLong("word_id");
									PreparedStatement insert = con
											.prepareStatement("insert into topic_word (word_id, topic_id) values ("
													+ wordId + ", " + topicId + ")");
									insert.executeUpdate();
								}

								PreparedStatement psUsers = con
										.prepareStatement("SELECT DISTINCT user_id FROM user_topic");
								ResultSet rsUsers = psUsers.executeQuery();
								while (rsUsers.next()) {
									PreparedStatement psGrade = con
											.prepareStatement("select grade from topics where topic_id=" + topicId);
									ResultSet rsGrade = psGrade.executeQuery();
									int grade = 0;
									if (rsGrade.next()) {
										grade = rsGrade.getInt(1);
									}

									PreparedStatement stGrade = con.prepareStatement(
											"select studentClass from students where user_id=" + rsUsers.getLong(1));
									ResultSet rsStGrade = stGrade.executeQuery();
									if (rsStGrade.next()) {
										if (rsStGrade.getInt(1) >= grade) {
											PreparedStatement insertPs = con.prepareStatement(
													"insert into user_topic (user_id, topic_id) values ("
															+ rsUsers.getLong(1) + ", " + topicId + ")");
											insertPs.executeUpdate();
										}
									}
								}

								String path = "C:/Users/Омарбек/git/kazakh/diploma1/WebContent";
								String nameOfImage = wordId + ".jpg";
								if (!item.getName().isEmpty()) {
									Word.processFile(path, item, nameOfImage, "img/questions");
								}

								response.sendRedirect("admin.jsp?navPage=words&topic_id=" + topicId);
							} catch (SQLException e) {
								e.printStackTrace();
							}
						}
						if ("edit_topic".equals(page)) {
							try {
								PreparedStatement updatePs = con.prepareStatement("update topics set topic_name='"
										+ name + "', grade=" + classNumber + " where topic_id=" + topicId);
								updatePs.executeUpdate();

								PreparedStatement psUsers = con
										.prepareStatement("SELECT DISTINCT user_id FROM user_topic");
								ResultSet rsUsers = psUsers.executeQuery();
								while (rsUsers.next()) {

									PreparedStatement stGrade = con.prepareStatement(
											"select studentClass from students where user_id=" + rsUsers.getLong(1));
									ResultSet rsStGrade = stGrade.executeQuery();
									if (rsStGrade.next()) {
										if (rsStGrade.getInt(1) < Integer.parseInt(classNumber)) {
											PreparedStatement deletePs = con
													.prepareStatement("delete from user_topic where user_id="
															+ rsUsers.getLong(1) + " and topic_id=" + topicId);
											deletePs.executeUpdate();
										} else {
											PreparedStatement deletePs = con
													.prepareStatement("insert into user_topic (user_id, topic_id)"
															+ " values (" + rsUsers.getLong(1) + ", " + topicId
															+ ") ON DUPLICATE KEY UPDATE user_id=" + rsUsers.getLong(1)
															+ ", topic_id=" + topicId);
											deletePs.executeUpdate();
										}
									}
								}
							} catch (SQLException e) {
								e.printStackTrace();
							}

							String path = "C:/Users/Омарбек/git/kazakh/diploma1/WebContent";
							String nameOfImage = topicId + ".jpg";

							try {
								File file = new File(
										"C:/Users/Омарбек/git/kazakh/diploma1/WebContent/img/subjects/" + nameOfImage);
								file.delete();
							} catch (Exception e) {
								e.printStackTrace();
							}
							if (!item.getName().isEmpty()) {
								Word.processFile(path, item, nameOfImage, "img/subjects");
							}

							String grade = Word.getGrade(classNumber);
							response.sendRedirect("admin.jsp?navPage=a_topics&grade=" + grade + "&classId=4");
						}
						if ("edit_word".equals(page)) {
							try {
								PreparedStatement updatePs = con.prepareStatement("update words set word_rus='" + rus
										+ "', word_kaz='" + kaz + "' where word_id=" + wordId);
								updatePs.executeUpdate();

								PreparedStatement topicWord = con.prepareStatement(
										"update topic_word set topic_id=" + topicId + " where word_id=" + wordId);
								topicWord.executeUpdate();
							} catch (SQLException e) {
								e.printStackTrace();
							}

							if (!item.getName().isEmpty()) {
								String path = "C:/Users/Омарбек/git/kazakh/diploma1/WebContent";
								String nameOfImage = wordId + ".jpg";

								try {
									File file = new File(
											"C:/Users/Омарбек/git/kazakh/diploma1/WebContent/img/questions/"
													+ nameOfImage);
									file.delete();
								} catch (Exception e) {
									e.printStackTrace();
								}
								if (!item.getName().isEmpty()) {
									Word.processFile(path, item, nameOfImage, "img/questions");
								}
							}

							response.sendRedirect("admin.jsp?navPage=words&topic_id=" + topicId);
						}
					}
				}
			} catch (FileUploadException e) {
				e.printStackTrace();
			}
		}
	}
}
