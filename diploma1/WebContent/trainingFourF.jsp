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
<section id="main">
        <div class="question">
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
 		 <h1 class="text-center yellow">Угадай слово по картинкам (на казахском)</h1>
 		 <br>
		<div class="row">
		<div class="col-sm-7">
			 <table>
			 	<tr>
			 		<td><img src="img/questions/<%=wordsRusKaz.get(j).id%>.jpg" class="img-rounded" alt="Cinque Terre" width="250px"/></td>
					<td><img src="img/questions/<%=wordsRusKaz.get(j).id%>.1.jpg" class="img-rounded" alt="Cinque Terre" width="250px"/></td>
	 		    </tr>
	 		    <tr>
	 		    	<td><img src="img/questions/<%=wordsRusKaz.get(j).id%>.2.jpg" class="img-rounded" alt="Cinque Terre" width="250px"/></td>
	 		    	<td><img src="img/questions/<%=wordsRusKaz.get(j).id%>.3.jpg" class="img-rounded" alt="Cinque Terre" width="250px"/></td>
			 	</tr>
			 </table>
		</div>
		<div class="col-sm-4">
 	  <form method="post" action="TrainingOneServlet" id="trainingOneForm">
 	  <div class="form-group">
		 <input type="hidden" name="topic_id" value="<%=topicId%>">
		 <input type="hidden" name="questionId" value="<%=j%>">
		 <input type="hidden" name="task_type" value="four">
		 <input type="hidden" name="wordID" value="<%=wordsRusKaz.get(j).id%>">
		 <input type="hidden" name="page" value="trainingFourForm">
		 <input type="hidden" name="correctAns" value="<%=wordsRusKaz.get(j).kaz%>">
		 <input type="text" name="variant" class="form-control" placeholder="Ваш ответ"><br>
 		</div>
 		 <button class="btn-answer btn">Отправить</button>
	 </form>
	 </div>
	 </div>
	 
	 <%	
}
%>
</div>
<div class="progress-holder">
          <div class="percent">
            20%
          </div>
          <div class="progress">
            <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
              <span class="sr-only">60%</span>
            </div>
          </div>
          <div class="clear"></div>
        </div>
</section>	  