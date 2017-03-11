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
 * Servlet implementation class ProverSebyaServlet
 */
@WebServlet("/ProverSebyaServlet")
public class ProverSebyaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	double score = 0;
	double multiple = 2.5;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String page = request.getParameter("page");
		String test_grade = request.getParameter("test_grade");
		String topicID = request.getParameter("topic_id");
		String task_type = request.getParameter("task_type");
		String variant = request.getParameter("variant");
		String wordID = request.getParameter("wordID");
		String questionId = request.getParameter("questionId");
		String correctAns = request.getParameter("correctAns");
		HttpSession session = request.getSession();
		Connection con = (new DBConnection()).getConnection();
		int j = Integer.parseInt(questionId);

		if ("trainingThreeForm".equals(page)) {
			variant = request.getParameter("demo");
		}
		try {
			if (j == 0) {
				score = 0;
			}
			if (variant != null && correctAns != null) {
				if (variant.equals(correctAns)) {
					score += multiple;
				}
				else {
					String sql2 = "INSERT INTO `results_test`(`id`, `student_id`, `word_id`, `topic_id`, `task_type`, `test_grade`)"
							+ " VALUES (0, '" + session.getAttribute("studentID") + "', '" + wordID + "', '" + topicID
							+ "', '" + task_type + "', '" + test_grade + "');";
					PreparedStatement prepStmt2 = con.prepareStatement(sql2);
					prepStmt2.executeUpdate();
				}
				response.sendRedirect("index.jsp?navPage=prover_sebya&test_grade=" + test_grade + "&questionId=" + (++j)
						+ "&score=" + score);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
}
