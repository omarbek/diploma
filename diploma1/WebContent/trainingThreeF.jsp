<%@page import="java.util.Collections"%>
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
var fruits = [];
var buttons=[];
var checkAnswer="";
function myFunction(id,a) {
	/* alert("s"); */
    checkAnswer += a;
    document.getElementsByClassName("next")[0].innerHTML = a;
    document.getElementById(id).style.visibility="hidden";
    buttons.push(id);
    document.getElementById("postData").value = checkAnswer;
    $('.next').removeClass('next').addClass('done');
    $('.others').first().removeClass('others').addClass('next');
}
function myClear(){
	checkAnswer="";
	var y = document.getElementsByClassName("done");
	var i;
	for (i = 0; i < y.length; i++) {
	  y[i].innerHTML = "";
	}
	$('.next').removeClass('next').addClass('others');
	$('.done').first().removeClass('done').addClass('next');
	$('.done').removeClass('done').addClass('others');
    
    for (var i = 0; i < buttons.length; i++) { 
       document.getElementById(buttons[i]).style.visibility = 'visible';
     }
}
function playAudio(y) {
	var x = document.getElementById("myAudio"+y);
	x.play(); 
}  
</script>
<%!
	public Long randomQuestion(Long lid){
		Random rnd=new Random();
		long a=lid*4-3+(long)(rnd.nextDouble()*(lid*5-(lid*4-3)));
		return a;
	}
	public List<Integer> shuffle(Integer a){
		List<Integer> list=new ArrayList<Integer>();
		for(int i=0;i<a;i++){
			list.add(i);
		}
		Collections.shuffle(list);
		return list;
	}
	%>
<%
if(con==null){
		con = (new DBConnection()).getConnection();
	}

String topicId = null;
topicId = (String)request.getAttribute("topic_id");
String questionId = null;
questionId = (request.getAttribute("questionId")).toString();

ArrayList<Word> wordsRusKaz = (ArrayList<Word>)session.getAttribute("wordsRusKaz");

int j = Integer.parseInt(questionId);
Integer count=(Integer)request.getAttribute("count");

%>
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
		<h1 class="text-center">Превосходно!</h1>
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
            	Собери слово из букв</h1>

	<div class="row">
		<div class="col-sm-12">
			<h3 class="text-center"><%=wordsRusKaz.get(j).rus %> 
			<audio id="myAudio<%=wordsRusKaz.get(j).id %>">
				<source src="audio/<%=wordsRusKaz.get(j).id %>.mp3">
			</audio>
			<img onclick="playAudio(<%=wordsRusKaz.get(j).id %>)" src="img/icons/zvuk.png" class="zvuk-text"></h3>
		</div>
	</div>
 	<%
		 String word="";
		 String clearWidth = "style='width:40px;'";
		 String width = "style='width:180px;'";
		 List<Integer> list=shuffle(wordsRusKaz.get(j).kaz.length());
			for(Integer i:list){
				char ch=wordsRusKaz.get(j).kaz.charAt(i);
				word+=ch;
			}
		%>
	<div class="row">
	<div class="col-sm-6 letters">	
 	<div class="row row-centered">
		<% for(int i=0;i<word.length();i++){ %>
			  <div class="col-sm-1 letter col-centered">
			  <% if(i == 0){ %>
			  		<button class="input-letter next"></button>
			  <% } 
			     else{%>
			     	<button class="input-letter others"></button>
			  <% }%>

			  </div>
	 	<% } %>
 	</div>
	<div class="row row-centered">		
			<%
		 	for(int i=0;i<word.length();i++){
		 	%>
		 	<div class="col-sm-1 letter col-centered">
				<button id=<% out.print(i); %> onclick="myFunction(this.id,'<% out.print(word.charAt(i)); %>')" class="btn btn-success btn-block">
				<% out.print(word.charAt(i)); %></button>
			</div>
		   <%
			}
		    %>	 	
	 </div>
	 </div>
	 <div class="col-sm-4  col-sm-offset-1">
	 <button onclick="myClear()" class="btn-answer btn zanovo">Заново</button>
 	 <form method="post" action="TrainingOneServlet" id="trainingOneForm">
		 <input type="hidden" name="topic_id" value="<%=topicId%>">
		 <input type="hidden" name="questionId" value="<%=j%>">
		 <input type="hidden" name="task_type" value="three">
		 <input type="hidden" name="wordID" value="<%=wordsRusKaz.get(j).id%>">
		 <input type="hidden" name="demo" id="postData" value="">
		 <input type="hidden" name="correctAns" value="<%=wordsRusKaz.get(j).kaz%>">
		 <input type="hidden" name="page" value="trainingThreeForm">
	     <button class="btn-answer btn zanovo">Отправить</button>
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
</section>