package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
		String variant = request.getParameter("variant");
		String wordID = request.getParameter("wordID");
		String task_type = request.getParameter("task_type");
		String questionId = request.getParameter("questionId");
		String correctAns = request.getParameter("correctAns");
		List<String> wordIdList = new ArrayList<String>();
		wordIdList.add(wordID);
		String variant2 = null;
		String correctAns2 = null;
		String wordID2 = null;
		if (page != null) {
			if (page.equals("trainingThreeForm")) {
				variant = request.getParameter("demo");
			}
			if (page.equals("trainingFiveForm")) {
				variant2 = request.getParameter("variant2");
				correctAns2 = request.getParameter("correctAns2");
				wordID2 = request.getParameter("wordID2");
				wordIdList.add(wordID2);
			}

		}

		ResultSet rs;
		int j = Integer.parseInt(questionId);
		Connection con = (new DBConnection()).getConnection();
		HttpSession session = request.getSession();
		try {
			int score = 0;
			if (variant != null && correctAns != null) {
				if ((!"trainingFiveForm".equals(page))
						|| (("trainingFiveForm").equals(page) && variant2 != null && correctAns2 != null)) {
					if (variant.equals(correctAns)) {
						if ((!"trainingFiveForm".equals(page))
								|| (("trainingFiveForm").equals(page) && variant2.equals(correctAns2))) {
							score++;
							session.setAttribute("score", score);
							System.out.println(score);
						} else {
							String sql3 = "SELECT * FROM results WHERE word_id=" + wordID2 + " and topic_id=" + topicID;
							PreparedStatement prepStmt3 = con.prepareStatement(sql3);
							rs = prepStmt3.executeQuery();

							if (!rs.next()) {
								String sql2 = "INSERT INTO `results`(`id`, `student_id`, `word_id`, `topic_id`, `task_type`)"
										+ " VALUES (0, '" + session.getAttribute("studentID") + "', '" + wordID2
										+ "', '" + topicID + "', '" + task_type + "');";
								PreparedStatement prepStmt2 = con.prepareStatement(sql2);
								prepStmt2.executeUpdate();
							}
						}
					} else {
						if (("trainingFiveForm").equals(page) && variant2.equals(correctAns2)) {
							wordIdList.remove(wordID2);
						}
						for (String wordId : wordIdList) {
							String sql3 = "SELECT * FROM results WHERE word_id=" + wordId + " and topic_id=" + topicID;
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
						wordIdList.clear();
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
						response.sendRedirect(
								"index.jsp?navPage=trainingOne&topic_id=" + topicID + "&questionId=" + (++j));
					}
				}
			}

		} catch (

		SQLException e) {
			e.printStackTrace();
		}

	}
}
