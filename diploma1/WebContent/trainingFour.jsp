<%@page import="com.mysql.jdbc.exceptions.MySQLNonTransientConnectionException"%>
<%@page import="java.util.Random"%>
<%@page import="main.Word"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="mysql.jsp" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%
try{
if(con==null){
		con = (new DBConnection()).getConnection();
	}

	String topicId = null;
	topicId = request.getParameter("topic_id");
	
	String questionId = null;
	questionId = request.getParameter("questionId");
	
	ArrayList<Word> wordsRusKaz = null;
	wordsRusKaz = (ArrayList<Word>)session.getAttribute("wordsRusKaz");
	
	if(questionId.equals("0")){
		String sql = "SELECT * FROM topic_word WHERE topic_id="+topicId;
		String sql2 = null;
		PreparedStatement prepStmt = con.prepareStatement(sql);
		PreparedStatement prepStmt2;
		ResultSet rs = prepStmt.executeQuery();
		ResultSet rs2; 
		wordsRusKaz = new ArrayList<Word>();
		
		while(rs.next()){
			sql2 = "SELECT * FROM words WHERE word_id="+rs.getString(1); 
			prepStmt2 = con.prepareStatement(sql2); 
			rs2 = prepStmt2.executeQuery();
			while(rs2.next()){
				wordsRusKaz.add(new Word(rs2.getInt(1),rs2.getString(2),rs2.getString(3)));
			}
		}
		request.setAttribute("questionId", 0);
	}
	else{
		request.setAttribute("questionId", questionId);
	}
	
	List<String> wrongWordsList=new ArrayList<String>();
	String sqlForResult = "select x2.word_kaz from results x"//
		+ " left join words x2 on x2.word_id=x.word_id"//
		+ " where student_id=" + session.getAttribute("studentID") + " and topic_id=" + topicId
		+ " and task_type='four'";
	PreparedStatement ps = con.prepareStatement(sqlForResult);
	ResultSet rs = ps.executeQuery();
	while (rs.next()) {
		wrongWordsList.add(rs.getString(1));
	}
	request.setAttribute("wrongWordsList", wrongWordsList);
	
	Integer count=0;
	String sqlCount="select count(1) from topic_word where topic_id=" + topicId;
	PreparedStatement psCount=con.prepareStatement(sqlCount);
	ResultSet rsCount=psCount.executeQuery();
	while(rsCount.next()){
		count=rsCount.getInt(1);
	}
	request.setAttribute("count",count);
	
	session.setAttribute("wordsRusKaz", wordsRusKaz);
	request.setAttribute("topic_id", topicId);

}
catch(MySQLNonTransientConnectionException e){
	con = (new DBConnection()).getConnection();
}%>

<jsp:include page="trainingFourF.jsp" />
				

  