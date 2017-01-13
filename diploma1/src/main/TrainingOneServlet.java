package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

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

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String topicID = request.getParameter("topic_id");
		String variant = request.getParameter("variant");
		int wordID = Integer.parseInt(request.getParameter("wordID"));
		//String wordID = request.getParameter("wordID");
		String task_type = request.getParameter("task_type");
		String questionId = request.getParameter("questionId");
		ResultSet rs;
		int j = Integer.parseInt(questionId);
		Connection con = (new DBConnection()).getConnection();
		HttpSession session=request.getSession();
		ArrayList<Word> wordsRusKaz = (ArrayList<Word>)session.getAttribute("wordsRusKaz");

		try {
			int score = 0;
			if(variant != null){
					if(variant.equals(wordsRusKaz.get(wordID-1).kaz)){
						score++;
						session.setAttribute("score", score);
						System.out.println(score);
					}
					else {
						String sql3 = "SELECT * FROM results WHERE word_id=" + wordID + " and topic_id=" + topicID;
						PreparedStatement prepStmt3 = con.prepareStatement(sql3);
						rs = prepStmt3.executeQuery();
						
						if(!rs.next()){
							String sql2 = "INSERT INTO `results`(`id`, `student_id`, `word_id`, `topic_id`, `task_type`)"
									+ " VALUES (0, '" + session.getAttribute("studentID") + "', '" + wordID 
									+ "', '" + topicID + "', '" + task_type + "');";
							PreparedStatement prepStmt2 = con.prepareStatement(sql2);
							prepStmt2.executeUpdate();
						}
						
					}
					response.sendRedirect("index.jsp?navPage=trainingOne&topic_id="+topicID+"&questionId="+(++j));
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

	}
}
