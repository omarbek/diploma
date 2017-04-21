<%@page import="com.mysql.jdbc.exceptions.MySQLNonTransientConnectionException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@page import="main.Word"%>
<%@include file="mysql.jsp" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%  
if(con==null){
		con = (new DBConnection()).getConnection();
	}
try{
String test_grade = null;
	test_grade = request.getParameter("test_grade");
	
	String questionId = null;
	questionId = request.getParameter("questionId");
	ArrayList<Word> wordsRusKaz = null;
	wordsRusKaz = (ArrayList<Word>)session.getAttribute("wordsRusKaz");
	ArrayList<String> wordsRusKazTemp = new ArrayList<String>();
	ArrayList<Integer> topicIds = null;
	topicIds = (ArrayList<Integer>)session.getAttribute("topicIds");
	ArrayList<Integer> randomWords = new ArrayList<Integer>();
	Random myRandomizer = new Random();
	int randomWord = 0;
	String score=request.getParameter("score");
	
	if(questionId.equals("0")){
		String sql1 = "SELECT topic_id FROM topics WHERE grade="+test_grade;
		String sql2 = null;
		String sql3 = null;
		PreparedStatement prepStmt1 = con.prepareStatement(sql1);
		PreparedStatement prepStmt2, prepStmt3;
		ResultSet rs1 = prepStmt1.executeQuery();
		ResultSet rs2, rs3; 
		wordsRusKaz = new ArrayList<Word>();
		topicIds = new ArrayList<Integer>();
		while(rs1.next()){
			sql2 = "SELECT word_id FROM topic_word WHERE topic_id="+rs1.getString(1); 
			prepStmt2 = con.prepareStatement(sql2); 
			rs2 = prepStmt2.executeQuery();
			while(rs2.next()){
				sql3 = "select * from words where word_id="+rs2.getString(1);
				prepStmt3 = con.prepareStatement(sql3); 
				rs3 = prepStmt3.executeQuery();
				while (rs3.next()) {
					wordsRusKazTemp.add(rs3.getString(1));
					wordsRusKazTemp.add(rs3.getString(2));
					wordsRusKazTemp.add(rs3.getString(3));
					randomWords.add(rs3.getInt(1));
				}
			}
			randomWord = randomWords.get(myRandomizer.nextInt(randomWords.size()));
			int positionOfWord = 0;
			if (wordsRusKazTemp.contains(String.valueOf(randomWord))){
				positionOfWord = wordsRusKazTemp.indexOf(String.valueOf(randomWord));
				wordsRusKaz.add(new Word(randomWord,wordsRusKazTemp.get(positionOfWord+1),wordsRusKazTemp.get(positionOfWord+2)));
			}
			randomWords.clear();
			wordsRusKazTemp.clear();
			topicIds.add(rs1.getInt(1));
		}
		String sqlForCleanResults = "select * from results_test where test_grade='" + test_grade + "'";
		PreparedStatement prepStmtForCleanResults = con.prepareStatement(sqlForCleanResults);
		ResultSet rsForCleanResults = prepStmtForCleanResults.executeQuery();
		while (rsForCleanResults.next()){
			String sqlForDeleteResults = "DELETE FROM `results_test` WHERE test_grade=" + test_grade;
			PreparedStatement prepStmtForDeleteResults = con.prepareStatement(sqlForDeleteResults);
			prepStmtForDeleteResults.executeUpdate();
		} 
		request.setAttribute("questionId", 0);
	}
	else{
		request.setAttribute("questionId", questionId);
	}
	session.setAttribute("wordsRusKaz", wordsRusKaz);
	session.setAttribute("topicIds", topicIds);
	request.setAttribute("test_grade", test_grade);
	request.setAttribute("score", score);
}
catch(MySQLNonTransientConnectionException e){
	con = (new DBConnection()).getConnection();
}
%>

<jsp:include page="prover_sebyaF.jsp" />
