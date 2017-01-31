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
    document.getElementById("demo").innerHTML = checkAnswer;
    document.getElementById(id).style.visibility="hidden";
    buttons.push(id);
    document.getElementById("postData").value = checkAnswer;
}
function myClear(){
	checkAnswer="";
    document.getElementById("demo").innerHTML = "";
    for (var i = 0; i < buttons.length; i++) { 
       document.getElementById(buttons[i]).style.visibility = 'visible';
     }
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
			<h1 class="text-center yellow">Собери слово из букв</h1>

	<div class="row">
		<div class="col-sm-12">
			<h2 class="text-center"><%=wordsRusKaz.get(j).rus %> </h2>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
 			<h2 class="text-center"><p name="input_letter" id="demo"></p></h2>
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
		<div class="row" align="center">
		<div class="col-sm-12">
		<table>
			<tr>
			<%
		 	for(int i=0;i<word.length();i++){
		 	%>
		 		<td>
					<button id=<% out.print(i); %> onclick="myFunction(this.id,'<% out.print(word.charAt(i)); %>')" class="btn btn-success btn-block">
					<% out.print(word.charAt(i)); %></button>
				</td>
				<td width="10px"></td>
		   <%
			}
		    %>
	 		</tr>
	 	</table>
	 	</div>
	 </div>
	 <div class="row">
	 <div class="col-sm-4 col-sm-offset-4">
	 <button onclick="myClear()" class="btn-answer btn">Заново</button>
	 </div>
	 </div>
	 <div class="row">
	 <div class="col-sm-4 col-sm-offset-4">
 	 <form method="post" action="TrainingOneServlet" id="trainingOneForm">
		 <input type="hidden" name="topic_id" value="<%=topicId%>">
		 <input type="hidden" name="questionId" value="<%=j%>">
		 <input type="hidden" name="task_type" value="three">
		 <input type="hidden" name="wordID" value="<%=wordsRusKaz.get(j).id%>">
		 <input type="hidden" name="demo" id="postData" value="">
		 <input type="hidden" name="correctAns" value="<%=wordsRusKaz.get(j).kaz%>">
		 <input type="hidden" name="page" value="trainingThreeForm">
	     <button class="btn-answer btn">Отправить</button>
	 </form>
	 <br>
	 </div>
	 </div>
	 <%	
	}
%>

</div>
</section>