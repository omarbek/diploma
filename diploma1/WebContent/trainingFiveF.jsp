<%@page import="java.util.Random"%>
<%@page import="main.Word"%>
<%@include file="mysql.jsp" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String topicId = null;
topicId = (String)request.getAttribute("topic_id");
String questionId = null;
questionId = (request.getAttribute("questionId")).toString();

ArrayList<Word> wordsRusKaz = (ArrayList<Word>)session.getAttribute("wordsRusKaz");

int j = Integer.parseInt(questionId);

%>
<br>
<div class="panel panel-default" style="max-width: 500px;" align="center">
 <%
 if(j>=wordsRusKaz.size()){
		%>
			<div class="well" style="background-color:pink;" align="center">
			<h2>Список неверных слов: </h2>
			<%
				List<String> wrongWordsList=(List<String>) request.getAttribute("wrongWordsList");
				if(wrongWordsList.isEmpty()){
					%>
						<h3>нет</h3>
					<%
				}
				for(String wrongWord: wrongWordsList){
					%>
						<h3><%=wrongWord %></h3>
					<%
				}
			%>
			<br>
			<a href="?navPage=trainings&topic_id=<%=topicId%>" class = "btn btn-success">Finished</a>
		   	</div>
		<%
	}
	else{
		 Random rand = new Random();
		 ArrayList<Integer> numbers = new ArrayList<Integer>();   
		 Random randomGenerator = new Random();
		 while (numbers.size() < 3) {

		     int random = randomGenerator .nextInt(wordsRusKaz.size());
		     if (!numbers.contains(random)&& random!=j) {
		         numbers.add(random);
		     }
		 }
		 int type = rand.nextInt(4);
		 String width = "style='width:180px;'";
 %>
 		<h2><%=wordsRusKaz.get(j).rus%> и <%= wordsRusKaz.get(numbers.get(0)).rus %></h2>
 		<img src="img/questions/<%=wordsRusKaz.get(j).id%>.jpg" class="img-rounded" alt="Cinque Terre" width="200px"/>
 		<img src="img/questions/<%=wordsRusKaz.get(numbers.get(0)).id%>.jpg" class="img-rounded" alt="Cinque Terre" width="200px"/>
 		<br><br>
 	  <form method="post" action="TrainingOneServlet" id="trainingOneForm">
		 <input type="hidden" name="topic_id" value="<%=topicId%>">
		 <input type="hidden" name="questionId" value="<%=j%>">
		 <input type="hidden" name="task_type" value="five">
		 <input type="hidden" name="wordID" value="<%=wordsRusKaz.get(j).id%>">
		 <input type="hidden" name="wordID2" value="<%=wordsRusKaz.get(numbers.get(0)).id%>">
		 <input type="hidden" name="page" value="trainingFiveForm">
		 <input type="hidden" name="correctAns" value="<%=wordsRusKaz.get(j).kaz%>">
		 <input type="hidden" name="correctAns2" value="<%=wordsRusKaz.get(numbers.get(0)).kaz%>">
		 <input type="text" name="variant"><% out.print(" және"); %>
		 <input type="text" name="variant2"><br>
		 <br>
		 <input class="btn btn-success btn-block" <%=width %> type="submit" value="Отправить">
      </form>
	 <br>
	 <%	
}
%>
</div>
	  