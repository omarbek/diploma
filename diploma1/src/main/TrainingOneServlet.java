package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class TrainingOneServlet
 */
@WebServlet("/TrainingOneServlet")
public class TrainingOneServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String page = request.getParameter("page");
		String topicID = request.getParameter("topic_id");
		String task_type = request.getParameter("task_type");
		String variant = request.getParameter("variant");
		String wordID = null;
		String questionId = null;
		int j = 0;
		String correctAns = null;
		List<Long> wrongIds = new ArrayList<Long>();
		if ("trainingThreeForm".equals(page)) {
			variant = request.getParameter("demo");
		}
		if (!"trainingSixForm".equals(page)) {
			wordID = request.getParameter("wordID");
			questionId = request.getParameter("questionId");
			correctAns = request.getParameter("correctAns");
			j = Integer.parseInt(questionId);
		} else {
			StringTokenizer st = new StringTokenizer(variant, ",");
			while (st.hasMoreElements()) {
				String nextElement = st.nextElement().toString();
				wrongIds.add(Long.parseLong(nextElement));
			}
			j = 9;
		}

		ResultSet rs;
		Connection con = (new DBConnection()).getConnection();
		HttpSession session = request.getSession();
		try {
			int score = 0;
			if ((variant != null && correctAns != null && !"trainingSixForm".equals(page))
					|| "trainingSixForm".equals(page)) {
				if (variant.equals(correctAns) && !"trainingSixForm".equals(page)
						|| (wrongIds.isEmpty() && "trainingSixForm".equals(page))) {
					score++;// how many points to add if user answered to
					// 6-training?
					session.setAttribute("score", score);
					System.out.println(score);
				} else if ("trainingSixForm".equals(page)) {
					for (Long wordId : wrongIds) {
						String sql3 = "SELECT * FROM results WHERE word_id=" + wordID + " and topic_id=" + topicID;
						PreparedStatement prepStmt3 = con.prepareStatement(sql3);
						rs = prepStmt3.executeQuery();

						if (!rs.next()) {
							String sql2 = "INSERT INTO `results`(`id`, `student_id`, `word_id`, `topic_id`, `task_type`)"
									+ " VALUES (0, '" + session.getAttribute("studentID") + "', '" + wordId + "', '"
									+ topicID + "', '" + task_type + "');";
							PreparedStatement prepStmt2 = con.prepareStatement(sql2);
							prepStmt2.executeUpdate();
						}
					}
				} else {
					String sql3 = "SELECT * FROM results WHERE word_id=" + wordID + " and topic_id=" + topicID;
					PreparedStatement prepStmt3 = con.prepareStatement(sql3);
					rs = prepStmt3.executeQuery();

					if (!rs.next()) {
						String sql2 = "INSERT INTO `results`(`id`, `student_id`, `word_id`, `topic_id`, `task_type`)"
								+ " VALUES (0, '" + session.getAttribute("studentID") + "', '" + wordID + "', '"
								+ topicID + "', '" + task_type + "');";
						PreparedStatement prepStmt2 = con.prepareStatement(sql2);
						prepStmt2.executeUpdate();
					}
				}

				if (page != null) {
					if (page.equals("trainingTwoForm")) {
						response.sendRedirect(
								"index.jsp?navPage=trainingTwo&topic_id=" + topicID + "&questionId=" + (++j));
					} else if (page.equals("trainingThreeForm")) {
						response.sendRedirect(
								"index.jsp?navPage=trainingThree&topic_id=" + topicID + "&questionId=" + (++j));
					} else if (page.equals("trainingFourForm")) {
						response.sendRedirect(
								"index.jsp?navPage=trainingFour&topic_id=" + topicID + "&questionId=" + (++j));
					} else if (page.equals("trainingFiveForm")) {
						response.sendRedirect(
								"index.jsp?navPage=trainingFive&topic_id=" + topicID + "&questionId=" + (++j));
					} else if (page.equals("trainingSixForm")) {
						response.sendRedirect(
								"index.jsp?navPage=trainingSix&topic_id=" + topicID + "&questionId=" + (++j));
					}
				} else {
					response.sendRedirect("index.jsp?navPage=trainingOne&topic_id=" + topicID + "&questionId=" + (++j));
				}
			}
		} catch (

		SQLException e) {
			e.printStackTrace();
		}

	}
}
