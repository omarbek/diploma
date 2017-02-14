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

/**
 * Servlet implementation class TopicServlet
 */
@WebServlet("/TopicServlet")
public class TopicServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String page = request.getParameter("page");
		Connection con = (new DBConnection()).getConnection();

		if (page.equals("remove")) {
			Long topicId = Long.parseLong(request.getParameter("topic_id"));
			PreparedStatement removePs;
			try {
				PreparedStatement selectPs = con.prepareStatement("select grade from topics where topic_id=" + topicId);
				ResultSet rs = selectPs.executeQuery();
				String classNumber = null;
				if (rs.next()) {
					classNumber = rs.getString(1);
				}
				String grade = Word.getGrade(classNumber);

				removePs = con.prepareStatement("delete from topics where topic_id=" + topicId);
				removePs.executeUpdate();

				response.sendRedirect("admin.jsp?navPage=a_topics&grade=" + grade + "&classId=4");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
