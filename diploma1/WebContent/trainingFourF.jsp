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
<div class="panel panel-default" style="max-width: 600px;" align="center">
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
 %>
 		 <h2>Угадай слово по картинкам</h2>
 		 <br>
		 <%
		 String width = "style='width:180px;'";
			 %>
			 <table>
			 	<tr>
			 		<td><img height ="150px" width = "150px" src="img/<%=wordsRusKaz.get(j).id%>.jpg" class="img-rounded" alt="Cinque Terre" width="200px"/></td>
					<td><img height ="150px" width = "150px" src="img/<%=wordsRusKaz.get(j).id%>.1.jpg" class="img-rounded" alt="Cinque Terre" width="200px"/></td>
	 		    </tr>
	 		    <tr>
	 		    	<td><img height ="150px" width = "150px" src="img/<%=wordsRusKaz.get(j).id%>.2.jpg" class="img-rounded" alt="Cinque Terre" width="200px"/></td>
	 		    	<td><img height ="150px" width = "150px" src="img/<%=wordsRusKaz.get(j).id%>.3.jpg" class="img-rounded" alt="Cinque Terre" width="200px"/></td>
			 	</tr>
			 </table>
		 <br>
 	  <form method="post" action="TrainingOneServlet" id="trainingOneForm">
		 <input type="hidden" name="topic_id" value="<%=topicId%>">
		 <input type="hidden" name="questionId" value="<%=j%>">
		 <input type="hidden" name="task_type" value="four">
		 <input type="hidden" name="wordID" value="<%=wordsRusKaz.get(j).id%>">
		 <input type="hidden" name="page" value="trainingFourForm">
		 <input type="hidden" name="correctAns" value="<%=wordsRusKaz.get(j).kaz%>">
		 <input type="text" name="variant"><br>
 		 <br>
 		 <input class="btn btn-success btn-block" <%=width %>  type="submit" value="Отправить">
	 </form>
	 <br>
	 <%	
}
%>
</div>
	  