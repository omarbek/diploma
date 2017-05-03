<%@page import="javax.swing.JOptionPane"%>
<% 
	session=request.getSession(false);
	if(session==null){
		session.invalidate();
	response.sendRedirect("index.jsp");
	}else{
%>
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
    for(var i = id; i <= (id+(count/2)-1); i++){
       document.getElementById(i).style.visibility = 'visible';
 	   document.getElementById(i).style.background='#5cb85c';
    }
    for (var i = id+count; i <= id+(3*count/2)-1; i++) { 
       document.getElementById(i).style.visibility = 'visible';
	   document.getElementById(i).style.background='#5cb85c';
    }
}
function playAudio(id) {
	var x = document.getElementById(id);
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
		<h1 class="text-center">Так держать!</h1>
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
				<audio id="<%=wordID %>">
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
			   		<a href="?navPage=homeStudent&grade=one&classId=<%=classId%>" class = "btn btn-warning"">Выбрать другую тему</a>
			   	</div>
			   	<div class="col-sm-3">
		   		</div>
		   	</div>
		<%
	}
	else{		
		String width = "style='width:180px;'";
		List<Word> shuffleList=new ArrayList();
		List<Word> secondWordRusKaz=new ArrayList();
		if(j==0){
			for(int i=0;i<count/2;i++){
				secondWordRusKaz.add(wordsRusKaz.get(i));
				shuffleList.add(wordsRusKaz.get(i));
			} 
		}else{
			for(int i=count/2;i<count;i++){
				secondWordRusKaz.add(wordsRusKaz.get(i));
				shuffleList.add(wordsRusKaz.get(i));
			}
		}
		Collections.shuffle(shuffleList);
 %>
			<h1 class="text-center yellow">
            <span class="back-btn"><a href="index.jsp?navPage=trainings&topic_id=<%=topicId %>" class="btn btn-warning"><i class="glyphicon glyphicon-menu-left"></i> Назад</a></span>
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
			 secondWordRusKaz.get(i).id=secondWordRusKaz.get(i).id+count;
    %>
		 		<button id=<%=secondWordRusKaz.get(i).id %> onclick="secondMatch(<%=secondWordRusKaz.get(i).id %>, <%=count %>)" class="btn btn-success btn-block" <%=width %>><%=secondWordRusKaz.get(i).rus %></button>
    			<h2></h2>
    <%
		 }
			 
    %>
    </div>
    </div>
    <div class="row">
        <div class="col-sm-4 col-sm-offset-1">
        	<button onclick="myClear(<%=secondWordRusKaz.get(0).id-count %>, <%=count %>)" class="btn btn-answer" <%=width %>>Заново</button>       
        </div>
        <div class="col-sm-4 col-sm-offset-3">
			<form method="post" action="TrainingOneServlet" id="trainingOneForm">
			 <input type="hidden" name="topic_id" value="<%=topicId%>">
			 <input type="hidden" name="task_type" value="six">
			 <input type="hidden" name="questionId" value="<%=j%>">
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
      <%
      }
catch(Exception e){
	JOptionPane.showMessageDialog(null, e.getLocalizedMessage());
	e.printStackTrace();
}
%>
<%}%>   