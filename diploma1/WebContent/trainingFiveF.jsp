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
			<a href="?navPage=trainings&topic_id=<%=topicId%>" class = "btn btn-success">Закончить</a>
		   	</div>
		<%
	}
	else{		
 %>
			<h1 class="text-center yellow">
            Найди правильный перевод слова
          </h1>
 		<div class="row">
            <div class="col-sm-8">
            <h1 class="text-center yellow"> </h1>
            	<audio id="myAudio">
					<source src="audio/1.mp3">
				</audio>
                <img onclick="playAudio()" src="img/note.jpg" alt="" class="img-responsive img-centre">
            </div>
            <div class="col-sm-4">          
 	  <form method="post" action="TrainingOneServlet" id="trainingOneForm">
		 <input type="hidden" name="topic_id" value="<%=topicId%>">
		 <input type="hidden" name="questionId" value="<%=j%>">
		 <input type="hidden" name="task_type" value="five">
		 <input type="hidden" name="page" value="trainingFiveForm">
		 <input type="hidden" name="wordID" value="<%=wordsRusKaz.get(j).id%>">
		 <input type="hidden" name="variant" value="">
		 <input type="hidden" name="correctAns" value="<%=wordsRusKaz.get(j).rus%>">
		 
		 <%
		 Random rand = new Random();//
		 ArrayList<Integer> numbers = new ArrayList<Integer>();   
		 Random randomGenerator = new Random();
		 while (numbers.size() < 3) {

		     int random = randomGenerator .nextInt(wordsRusKaz.size());
		     if (!numbers.contains(random)&& random!=j) {
		         numbers.add(random);
		     }
		 }
		 int type = rand.nextInt(3);
		 String width = "style='width:180px;'";
		 if(type == 0){
			 %>
			<button class="btn btn-answer btn-block train1"  correct="1"><%=wordsRusKaz.get(j).rus%></button><br>
			<button class="btn btn-answer btn-block train1" correct="0"><%=wordsRusKaz.get(numbers.get(0)).rus%></button><br>
			<button class="btn btn-answer btn-block train1"  correct="0"><%=wordsRusKaz.get(numbers.get(1)).rus%></button>
		<%}
		 else if(type == 1){
			 %>
			<button class="btn btn-answer btn-block train1" correct="0"><%=wordsRusKaz.get(numbers.get(0)).rus%></button><br>
			<button class="btn btn-answer btn-block train1"  correct="1"><%=wordsRusKaz.get(j).rus%></button><br>
			<button class="btn btn-answer btn-block train1"  correct="0"><%=wordsRusKaz.get(numbers.get(1)).rus%></button>
		<%}
		else if(type == 2){
			 %>
			<button class="btn btn-answer btn-block train1" correct="0"><%=wordsRusKaz.get(numbers.get(0)).rus%></button><br>
			<button class="btn btn-answer btn-block train1" correct="0"><%=wordsRusKaz.get(numbers.get(1)).rus%></button><br>
			<button class="btn btn-answer btn-block train1" correct="1"><%=wordsRusKaz.get(j).rus%></button>
		<%}
		%>
	 </form>
	 <br>
	 <%	
}
%>
			</div>
          </div>
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
      
   