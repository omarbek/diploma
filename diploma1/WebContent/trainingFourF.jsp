<%@page import="com.mysql.jdbc.exceptions.MySQLNonTransientConnectionException"%>
<%@page import="java.util.Random"%>
<%@page import="main.Word"%>
<%@include file="mysql.jsp" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script type="text/javascript">
function playAudio() {
	var x = document.getElementById("myAudio");
	x.play(); 
}  
</script>
<%
try{
String topicId = null;
topicId = (String)request.getAttribute("topic_id");
String questionId = null;
questionId = (request.getAttribute("questionId")).toString();

ArrayList<Word> wordsRusKaz = (ArrayList<Word>)session.getAttribute("wordsRusKaz");

int j = Integer.parseInt(questionId);
Integer count=(Integer)request.getAttribute("count");

%>
<script>
function playAudio(y) {
	var x = document.getElementById("myAudio"+y);
	x.play(); 
}  
</script>
<br>
<section id="main">
   <div class="question">
 <%
 if(j>=wordsRusKaz.size()){
	List<String> wrongWordsList=(List<String>) request.getAttribute("wrongWordsList");
	String userId = (String)session.getAttribute("userId");
	String sql5 = "select studentClass from students where user_id='"+userId+"'";
	PreparedStatement prepStmt5 = con.prepareStatement(sql5);
	ResultSet rs5 = prepStmt5.executeQuery();
	String classId = null;
	if (rs5.next()){
    	classId = rs5.getString(1);
    }
	 if(wrongWordsList.isEmpty()){ %>
		<h1 class="text-center">Отлично сработано!</h1>
		<h2 class="text-center">Ты ответил правильно на все вопросы!</h2>
		<div class="row">	
			<div class="col-sm-4 col-sm-offset-2" style="margin-top:15px;">
				<div class="c100 p100 center">
	                <span><%=wordsRusKaz.size()%> / <%=wordsRusKaz.size()%></span>
	                <p class="prav">правильных</p>
	                <p class="otv">ответов</p>
	                <div class="slice">
	                   <div class="bar"></div>
	                   <div class="fill"></div>
	                </div>
                </div>
			</div>
		   	<div class="col-sm-4">
		   		<img class="img-responsive img-centre" src="img/dragon.png" style="width:280px;">
			</div>
		 </div>
	<%}
	 else{  %>
		 <h1 class="text-center">Список неверных слов:</h1>	
		<div class="row">	
			<div class="col-sm-4" style="margin-top:15px;">
			<%  int rightAnswers = wordsRusKaz.size() - wrongWordsList.size();
				int percntge = (100*rightAnswers)/wordsRusKaz.size();%>
				<div class="c100 p<%=percntge%> center">
	                 <span><%=rightAnswers%> / <%=wordsRusKaz.size()%></span>
	                 <p class="prav">правильных</p>
	                 <p class="otv">ответов</p>
	                 <div class="slice">
	                     <div class="bar"></div>
	                     <div class="fill"></div>
	                 </div>
                </div>
			</div>
			<div class="col-sm-4">
			<%
			for(String wrongWord: wrongWordsList){ 
				  String sql6 = "select * from words where word_kaz='"+wrongWord+"'";
				  PreparedStatement prepStmt6 = con.prepareStatement(sql6);
				  ResultSet rs6 = prepStmt6.executeQuery();
				  String wordID = null;
				  if (rs6.next()){
					  wordID = rs6.getString(1);
				  }
			%>
				<h3>
				<audio id="myAudio<%=wordID %>">
					<source src="audio/<%=wordID %>.mp3">
				</audio>
				<img onclick="playAudio(<%=wordID %>)" src="img/icons/zvuk.png" class="zvuk-text"> <%=wrongWord%> 
				<span class="wrong-word-rus"> - <%=rs6.getString(2)%></span></h3>
				<% } %>
				</div>
			   	<div class="col-sm-4">
			   		<img class="img-responsive img-centre" src="img/dragon.png" style="width:280px;">
				</div>
			   	</div>
			<% }%>
		   	
		   	
		   	<div class="row" style="margin-top:50px;">
			   	<div class="col-sm-3">
			   	</div>
			   	<div class="col-sm-3">
					<a href="?navPage=trainings&topic_id=<%=topicId%>" class = "btn btn-warning">К списку тренировок</a>
			   	</div>
			   	<div class="col-sm-3">
			   		<a href="?navPage=homeStudent&grade=one&classId=<%=classId%>" class = "btn btn-warning">Выбрать другую тему</a>
			   	</div>
			   	<div class="col-sm-3">
		   		</div>
		   	</div>
		<%
	}
	else{		
 %>
 		 <h1 class="text-center yellow"><span class="back-btn"><a href="index.jsp?navPage=trainings&topic_id=<%=topicId %>" class="btn btn-warning"><i class="glyphicon glyphicon-menu-left"></i> Назад</a></span>
            	Угадай слово по картинкам (на казахском)</h1>
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
		<div class="col-sm-4" style="margin-top:-20px;">
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
            <%=j*100/count %>
          </div>
          <div class="progress">
            <div class="progress-bar" role="progressbar" aria-valuenow="<%=j*100/count %>" aria-valuemin="0" aria-valuemax="100" style="width: <%=j*100/count %>%;">
              <span class="sr-only">60%</span>
            </div>
          </div>
          <div class="clear"></div>
        </div>
        <%}
catch(MySQLNonTransientConnectionException e){
} %>
</section>	  