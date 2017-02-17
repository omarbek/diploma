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
var matchId=null;
var wrongIds="";
var isFirst=true;
var match=null;
function firstMatch(id,count) {
	if(match!=1){
		if(isFirst){
			document.getElementById(id).style.background='#FFA500';
			matchId=id;
			isFirst=false;
			match=1;
		}else{
			var secondId;
			if(matchId==id){
				secondId=id+count;
				//button disappear only in right answer
			}else{ 
				secondId=matchId+count;
				wrongIds+=matchId+",";
				document.getElementById("postData").value = wrongIds;
			}
			document.getElementById(id).style.visibility = 'hidden';//
			document.getElementById(secondId).style.visibility = 'hidden';//
			isFirst=true;
			matchId=null;
			match=null;
		}
	}else{
		alert("Выберите слово с другой колонки");
	}
}
function secondMatch(id,count){
	if(match!=2){
		if(!isFirst){
			var secondId=id-count;
			if(secondId==matchId){
				//button disappear only in right answer
			}else{
				wrongIds+=matchId+",";
				document.getElementById("postData").value = wrongIds;
			}
			document.getElementById(matchId).style.visibility = 'hidden';//
			document.getElementById(id).style.visibility = 'hidden';//
			isFirst=true;
			matchId=null;
			match=null;
		}else{
			document.getElementById(id).style.background='#FFA500';
			matchId=id-count;
			isFirst=false;
			match=2;
		}
	}else{
		alert("Выберите слово с другой колонки");
	}
}
function myClear(id,count){
	matchId=null;
	wrongIds="";
	match=null;
	isFirst=true;
    for (var i = id; i <= (id+count)*2; i++) { 
       document.getElementById(i).style.visibility = 'visible';
	   document.getElementById(i).style.background='#5cb85c';
     }
}
</script>
<%
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
		String width = "style='width:180px;'";
		List<Word> shuffleList=new ArrayList();
		List<Integer> pushedButtons=new ArrayList();
		shuffleList.addAll(wordsRusKaz);
		Collections.shuffle(shuffleList);
 %>
			<h1 class="text-center yellow">
            Подберите пару для каждого слова
          </h1>
 		<div class="row">
            <div class="col-sm-4 col-sm-offset-1">
			
			 <%
		 for(int i=0;i<shuffleList.size();i++){
    %>
		 		<button id=<%=shuffleList.get(i).id %> onclick="firstMatch(<%=shuffleList.get(i).id %>, <%=count %>)" class="btn btn-success btn-block" <%=width %>><%=shuffleList.get(i).kaz %></button>
    			<h2></h2>
    <%
		 }
    %>
    		</div>
    		<div class="col-sm-4 col-sm-offset-3">   
			 <%
		 for(int i=0;i<shuffleList.size();i++){
			 wordsRusKaz.get(i).id=wordsRusKaz.get(i).id+count;
    %>
		 		<button id=<%=wordsRusKaz.get(i).id %> onclick="secondMatch(<%=wordsRusKaz.get(i).id %>, <%=count %>)" class="btn btn-success btn-block" <%=width %>><%=wordsRusKaz.get(i).rus %></button>
    			<h2></h2>
    <%
		 }
			 
    %>
    </div>
    </div>
    <div class="row">
        <div class="col-sm-4 col-sm-offset-1">
        	<button onclick="myClear(<%=wordsRusKaz.get(0).id-count %>, <%=count %>)" class="btn btn-answer" <%=width %>>Заново</button>       
        </div>
        <div class="col-sm-4 col-sm-offset-3">
			<form method="post" action="TrainingOneServlet" id="trainingOneForm">
			 <input type="hidden" name="topic_id" value="<%=topicId%>">
			 <input type="hidden" name="task_type" value="six">
			 <input type="hidden" name="page" value="trainingSixForm">
			 <input type="hidden" name="variant" id="postData" value="">
		     <button class="btn btn-answer" <%=width %>>Отправить</button>
	      	</form>
		</div>
    </div>
	 <%	
}
%>          
        </div>
        <div class="progress-holder">
          <div class="percent">
            <%=j*10 %>
          </div>
          <div class="progress">
            <div class="progress-bar" role="progressbar" aria-valuenow="<%=j*10 %>" aria-valuemin="0" aria-valuemax="100" style="width: <%=j*10 %>%;">
              <span class="sr-only">60%</span>
            </div>
          </div>
          <div class="clear"></div>
        </div>
      </section>
      
   