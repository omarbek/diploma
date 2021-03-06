package main;

import java.io.File;
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

/**
 * Servlet implementation class TopicServlet
 */
@WebServlet("/TopicServlet")
public class TopicServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
			IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		Connection con = (new DBConnection()).getConnection();
		try {
			String page = request.getParameter("page");
			if (page.equals("remove")) {
				Long topicId = Long.parseLong(request.getParameter("topic_id"));
				PreparedStatement removePs;
				PreparedStatement results = con.prepareStatement("delete from results where topic_id=" + topicId);
				results.executeUpdate();

				PreparedStatement resultTest = con.prepareStatement("delete from results_test where topic_id="
						+ topicId);
				resultTest.executeUpdate();

				PreparedStatement userTopic = con.prepareStatement("delete from user_topic where topic_id=" + topicId);
				userTopic.executeUpdate();

				PreparedStatement selectPs = con.prepareStatement("select grade from topics where topic_id=" + topicId);
				ResultSet rs = selectPs.executeQuery();
				String classNumber = null;
				if (rs.next()) {
					classNumber = rs.getString(1);
				}
				String grade = Word.getGrade(classNumber);

				removePs = con.prepareStatement("delete from topics where topic_id=" + topicId);
				removePs.executeUpdate();

				try {
					File file = new File("C:/Users/Сымбат/git/diploma/diploma1/WebContent/img/subjects/" + topicId
							+ ".jpg");
					file.delete();
				} catch (Exception e) {
					e.printStackTrace();
				}

				response.sendRedirect("admin.jsp?navPage=a_topics&grade=" + grade + "&classId=4&refresh=false");
			}
			if (page.equals("remove_word")) {
				Long wordId = Long.parseLong(request.getParameter("word_id"));
				Long topicId = Long.parseLong(request.getParameter("topic_id"));
				PreparedStatement results = con.prepareStatement("delete from results where word_id=" + wordId);
				results.executeUpdate();

				PreparedStatement resultTest = con.prepareStatement("delete from results_test where word_id=" + wordId);
				resultTest.executeUpdate();

				PreparedStatement topicWord = con.prepareStatement("delete from topic_word where word_id=" + wordId);
				topicWord.executeUpdate();

				PreparedStatement words = con.prepareStatement("delete from words where word_id=" + wordId);
				words.executeUpdate();

				try {
					File file = new File("C:/Users/Сымбат/git/diploma/diploma1/WebContent/img/questions/" + wordId
							+ ".jpg");
					file.delete();
				} catch (Exception e) {
					e.printStackTrace();
				}

				response.sendRedirect("admin.jsp?navPage=words&topic_id=" + topicId);
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
