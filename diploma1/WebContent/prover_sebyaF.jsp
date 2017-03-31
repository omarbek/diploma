<%@page import="java.util.Random"%>
<%@page import="main.Word"%>
<%@include file="mysql.jsp" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Collections"%>
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
function myClearThree(){
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
String test_grade = null;
test_grade = (String)request.getAttribute("test_grade");
String questionId = null;
questionId = (request.getAttribute("questionId")).toString();
String score=(String)request.getAttribute("score");

ArrayList<Word> wordsRusKaz = (ArrayList<Word>)session.getAttribute("wordsRusKaz");
ArrayList<Integer> topicIds = (ArrayList<Integer>)session.getAttribute("topicIds");

int j = Integer.parseInt(questionId); %>
<section id="main">
   <div class="question" style="margin-top:50px;">
<% if(j<8){	 %>
		<h1 class="text-center yellow">Найди правильный перевод слова</h1>
 		<div class="row">
 			<div class="col-sm-6">
 				<h2 class="text-center text-uppercase helv"><%=wordsRusKaz.get(j).rus%></h2>
 				<img src="img/questions/<%=wordsRusKaz.get(j).id%>.jpg" alt="" class="img-responsive img-centre">
            </div>
            <div class="col-sm-5 col-sm-offset-1">                    
				<form method="post" action="ProverSebyaServlet" id="trainingOneForm">
					 <input type="hidden" name="test_grade" value="<%=test_grade%>">
					 <input type="hidden" name="topic_id" value="<%=topicIds.get(j)%>">
					 <input type="hidden" name="questionId" value="<%=j%>">
					 <input type="hidden" name="task_type" value="one">
					 <input type="hidden" name="wordID" value="<%=wordsRusKaz.get(j).id%>">
					 <input type="hidden" name="variant" value="">
					 <input type="hidden" name="correctAns" value="<%=wordsRusKaz.get(j).kaz%>">				 
					 <%
					 Random rand = new Random();
					 ArrayList<Integer> numbers = new ArrayList<Integer>();   
					 Random randomGenerator = new Random();
					 while (numbers.size() < 3) {
					     int random = randomGenerator.nextInt(wordsRusKaz.size());
					     if (!numbers.contains(random)&& random!=j) {
					         numbers.add(random);
					     }
					 }
					 int type = rand.nextInt(3);
					 if(type == 0){ %>
					 	<div class="row">
							<div class="col-sm-9"><button class="btn btn-answer btn-block train1"  correct="1"><%=wordsRusKaz.get(j).kaz%></button></div>
							<audio id="myAudio<%=wordsRusKaz.get(j).id %>">
								<source src="audio/<%=wordsRusKaz.get(j).id %>.mp3">
							</audio>
							<div class="col-sm-3"><img onclick="playAudio(<%=wordsRusKaz.get(j).id %>)" src="img/icons/zvuk.png" class="img-responsive zvuk"></div>
						</div>
						<div class="row">
							<div class="col-sm-9"><button class="btn btn-answer btn-block train1"  correct="0"><%=wordsRusKaz.get(numbers.get(0)).kaz%></button></div>
							<audio id="myAudio<%=wordsRusKaz.get(numbers.get(0)).id %>">
								<source src="audio/<%=wordsRusKaz.get(numbers.get(0)).id %>.mp3">
							</audio>
							<div class="col-sm-3"><img onclick="playAudio(<%=wordsRusKaz.get(numbers.get(0)).id %>)" src="img/icons/zvuk.png" class="img-responsive zvuk"></div>
						</div>
						<div class="row">
							<div class="col-sm-9"><button class="btn btn-answer btn-block train1"  correct="0"><%=wordsRusKaz.get(numbers.get(1)).kaz%></button></div>
							<audio id="myAudio<%=wordsRusKaz.get(numbers.get(1)).id %>">
								<source src="audio/<%=wordsRusKaz.get(numbers.get(1)).id %>.mp3">
							</audio>
							<div class="col-sm-3"><img onclick="playAudio(<%=wordsRusKaz.get(numbers.get(1)).id %>)" src="img/icons/zvuk.png" class="img-responsive zvuk"></div>
						</div>
					<%}
					  else if(type == 1){
						 %>		 
						<div class="row">
							<div class="col-sm-9"><button class="btn btn-answer btn-block train1" correct="0"><%=wordsRusKaz.get(numbers.get(0)).kaz%></button></div>
							<audio id="myAudio<%=wordsRusKaz.get(numbers.get(0)).id %>">
								<source src="audio/<%=wordsRusKaz.get(numbers.get(0)).id %>.mp3">
							</audio>
							<div class="col-sm-3"><img onclick="playAudio(<%=wordsRusKaz.get(numbers.get(0)).id %>)" src="img/icons/zvuk.png" class="img-responsive zvuk"></div>
						</div>
						<div class="row">
							<div class="col-sm-9"><button class="btn btn-answer btn-block train1"  correct="1"><%=wordsRusKaz.get(j).kaz%></button></div>
							<audio id="myAudio<%=wordsRusKaz.get(j).id %>">
								<source src="audio/<%=wordsRusKaz.get(j).id %>.mp3">
							</audio>
							<div class="col-sm-3"><img onclick="playAudio(<%=wordsRusKaz.get(j).id %>)" src="img/icons/zvuk.png" class="img-responsive zvuk"></div>
						</div>
						<div class="row">
							<div class="col-sm-9"><button class="btn btn-answer btn-block train1"  correct="0"><%=wordsRusKaz.get(numbers.get(1)).kaz%></button></div>
							<audio id="myAudio<%=wordsRusKaz.get(numbers.get(1)).id %>">
								<source src="audio/<%=wordsRusKaz.get(numbers.get(1)).id %>.mp3">
							</audio>
							<div class="col-sm-3"><img onclick="playAudio(<%=wordsRusKaz.get(numbers.get(1)).id %>)" src="img/icons/zvuk.png" class="img-responsive zvuk"></div>
						</div>
					<%}
					  else if(type == 2){
						 %>
						<div class="row">
							<div class="col-sm-9"><button class="btn btn-answer btn-block train1" correct="0"><%=wordsRusKaz.get(numbers.get(0)).kaz%></button></div>
							<audio id="myAudio<%=wordsRusKaz.get(numbers.get(0)).id %>">
								<source src="audio/<%=wordsRusKaz.get(numbers.get(0)).id %>.mp3">
							</audio>
							<div class="col-sm-3"><img onclick="playAudio(<%=wordsRusKaz.get(numbers.get(0)).id %>)" src="img/icons/zvuk.png" class="img-responsive zvuk"></div>
						</div>
						<div class="row">
							<div class="col-sm-9"><button class="btn btn-answer btn-block train1" correct="0"><%=wordsRusKaz.get(numbers.get(1)).kaz%></button></div>
							<audio id="myAudio<%=wordsRusKaz.get(numbers.get(1)).id %>">
								<source src="audio/<%=wordsRusKaz.get(numbers.get(1)).id %>.mp3">
							</audio>
							<div class="col-sm-3"><img onclick="playAudio(<%=wordsRusKaz.get(numbers.get(1)).id %>)" src="img/icons/zvuk.png" class="img-responsive zvuk"></div>
						</div>
						<div class="row">
							<div class="col-sm-9"><button class="btn btn-answer btn-block train1" correct="1"><%=wordsRusKaz.get(j).kaz%></button></div>
							<audio id="myAudio<%=wordsRusKaz.get(j).id %>">
								<source src="audio/<%=wordsRusKaz.get(j).id %>.mp3">
							</audio>
							<div class="col-sm-3"><img onclick="playAudio(<%=wordsRusKaz.get(j).id %>)" src="img/icons/zvuk.png" class="img-responsive zvuk"></div>
						</div>
				<% } %>
				</form>
			</div>
		</div>
<%	}
	else if (j>=8 && j<16){ %>
		<h1 class="text-center yellow">
            Найди правильный перевод слова
          </h1>
 		<div class="row">
            <div class="col-sm-6">
            
            <h2 class="text-center text-uppercase helv"><%=wordsRusKaz.get(j-8).kaz%>
            <audio id="myAudio<%=wordsRusKaz.get(j-8).id %>">
				<source src="audio/<%=wordsRusKaz.get(j-8).id %>.mp3">
			</audio>
            <img onclick="playAudio(<%=wordsRusKaz.get(j-8).id %>)" src="img/icons/zvuk.png" class="zvuk-text"></h2>    
            <img src="img/questions/<%=wordsRusKaz.get(j-8).id%>.jpg" alt="" class="img-responsive img-centre">
            </div>
            <div class="col-sm-5 col-sm-offset-1">          
		 	  <form method="post" action="ProverSebyaServlet" id="trainingOneForm">
		 	  	<input type="hidden" name="test_grade" value="<%=test_grade%>">
				 <input type="hidden" name="topic_id" value="<%=topicIds.get(j-8)%>">
				 <input type="hidden" name="questionId" value="<%=j%>">
				 <input type="hidden" name="task_type" value="two">
				 <input type="hidden" name="page" value="trainingTwoForm">	 
				 <input type="hidden" name="wordID" value="<%=wordsRusKaz.get(j-8).id%>">
				 <input type="hidden" name="variant" value="">
				 <input type="hidden" name="correctAns" value="<%=wordsRusKaz.get(j-8).rus%>">
				 
				 <%
				 Random rand = new Random();
				 ArrayList<Integer> numbers = new ArrayList<Integer>();   
				 Random randomGenerator = new Random();
				 while (numbers.size() < 3) {
		
				     int random = randomGenerator .nextInt(wordsRusKaz.size());
				     if (!numbers.contains(random)&& random!=(j-8)) {
				         numbers.add(random);
				     }
				 }
				 int type = rand.nextInt(3);
				 if(type == 0){
					 %>
					<div class="row">
					<div class="col-sm-9"><button class="btn btn-answer btn-block train1"  correct="1"><%=wordsRusKaz.get(j-8).rus%></button></div>
						</div>
					<div class="row">
					<div class="col-sm-9"><button class="btn btn-answer btn-block train1"  correct="0"><%=wordsRusKaz.get(numbers.get(0)).rus%></button></div>
						</div>
					<div class="row">
					<div class="col-sm-9"><button class="btn btn-answer btn-block train1"  correct="0"><%=wordsRusKaz.get(numbers.get(1)).rus%></button></div>
						</div>
				<%}
				 else if(type == 1){
					 %>
					<div class="row">
					<div class="col-sm-9"><button class="btn btn-answer btn-block train1" correct="0"><%=wordsRusKaz.get(numbers.get(0)).rus%></button></div>
						</div>
					<div class="row">
					<div class="col-sm-9"><button class="btn btn-answer btn-block train1"  correct="1"><%=wordsRusKaz.get(j-8).rus%></button></div>
						</div>
					<div class="row">
					<div class="col-sm-9"><button class="btn btn-answer btn-block train1"  correct="0"><%=wordsRusKaz.get(numbers.get(1)).rus%></button></div>
						</div>
				<%}
				else if(type == 2){
					 %>
					<div class="row">
					<div class="col-sm-9"><button class="btn btn-answer btn-block train1" correct="0"><%=wordsRusKaz.get(numbers.get(0)).rus%></button></div>
						</div>
					<div class="row">
					<div class="col-sm-9"><button class="btn btn-answer btn-block train1" correct="0"><%=wordsRusKaz.get(numbers.get(1)).rus%></button></div>
						</div>
					<div class="row">
					<div class="col-sm-9"><button class="btn btn-answer btn-block train1" correct="1"><%=wordsRusKaz.get(j-8).rus%></button></div>
						</div>
				<%}
				%>
			 </form>
			 <br>
			</div>
          </div>
<% 	}
	else if (j>=16 && j<24){ %>
		<h1 class="text-center yellow">Собери слово из букв</h1>

	<div class="row">
		<div class="col-sm-12">
			<h3 class="text-center"><%=wordsRusKaz.get(j-16).rus %> 
			<audio id="myAudio<%=wordsRusKaz.get(j-16).id %>">
				<source src="audio/<%=wordsRusKaz.get(j-16).id %>.mp3">
			</audio>
			<img onclick="playAudio(<%=wordsRusKaz.get(j-16).id %>)" src="img/icons/zvuk.png" class="zvuk-text"></h3>
		</div>
	</div>
 	<%
		 String word="";
		 String clearWidth = "style='width:40px;'";
		 String width = "style='width:180px;'";
		 List<Integer> list=shuffle(wordsRusKaz.get(j-16).kaz.length());
			for(Integer i:list){
				char ch=wordsRusKaz.get(j-16).kaz.charAt(i);
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
	 <button onclick="myClearThree()" class="btn-answer btn zanovo">Заново</button>
 	 <form method="post" action="ProverSebyaServlet" id="trainingOneForm">
		 <input type="hidden" name="test_grade" value="<%=test_grade%>">
		 <input type="hidden" name="topic_id" value="<%=topicIds.get(j-16)%>">
		 <input type="hidden" name="questionId" value="<%=j%>">
		 <input type="hidden" name="task_type" value="three">
		 <input type="hidden" name="wordID" value="<%=wordsRusKaz.get(j-16).id%>">
		 <input type="hidden" name="demo" id="postData" value="">
		 <input type="hidden" name="correctAns" value="<%=wordsRusKaz.get(j-16).kaz%>">
		 <input type="hidden" name="page" value="trainingThreeForm">
	     <button class="btn-answer btn zanovo">Отправить</button>
	 </form>
	 </div>
	 </div>
<% 	}
	else if (j>=24 && j<32){ %>
	<h1 class="text-center yellow">Угадай слово по картинкам (на казахском)</h1>
 		 <br>
		<div class="row">
		<div class="col-sm-7">
			 <table>
			 	<tr>
			 		<td><img src="img/questions/<%=wordsRusKaz.get(j-24).id%>.jpg" class="img-rounded" alt="Cinque Terre" width="250px"/></td>
					<td><img src="img/questions/<%=wordsRusKaz.get(j-24).id%>.1.jpg" class="img-rounded" alt="Cinque Terre" width="250px"/></td>
	 		    </tr>
	 		    <tr>
	 		    	<td><img src="img/questions/<%=wordsRusKaz.get(j-24).id%>.2.jpg" class="img-rounded" alt="Cinque Terre" width="250px"/></td>
	 		    	<td><img src="img/questions/<%=wordsRusKaz.get(j-24).id%>.3.jpg" class="img-rounded" alt="Cinque Terre" width="250px"/></td>
			 	</tr>
			 </table>
		</div>
		<div class="col-sm-4" style="margin-top:-20px;">
 	  <form method="post" action="ProverSebyaServlet" id="trainingOneForm">
 	  <div class="form-group">
		 <input type="hidden" name="test_grade" value="<%=test_grade%>">
		 <input type="hidden" name="topic_id" value="<%=topicIds.get(j-24)%>">
		 <input type="hidden" name="questionId" value="<%=j%>">
		 <input type="hidden" name="task_type" value="four">
		 <input type="hidden" name="wordID" value="<%=wordsRusKaz.get(j-24).id%>">
		 <input type="hidden" name="page" value="trainingFourForm">
		 <input type="hidden" name="correctAns" value="<%=wordsRusKaz.get(j-24).kaz%>">
		 <input type="text" name="variant" class="form-control" placeholder="Ваш ответ"><br>
 		</div>
 		 <button class="btn-answer btn">Отправить</button>
	 </form>
	 </div>
	 </div>
		
<%	}
	else if (j>=32 && j<40){ %>
		<h1 class="text-center yellow">
            Найди правильный перевод слова
          </h1>
 		<div class="row">
            <div class="col-sm-7">
            <h1 class="text-center yellow"> </h1>
            	<audio id="myAudio<%=wordsRusKaz.get(j-32).id %>">
					<source src="audio/<%=wordsRusKaz.get(j-32).id %>.mp3">
				</audio>
                <img onclick="playAudio(<%=wordsRusKaz.get(j-32).id %>)" src="img/note.jpg" alt="" class="img-responsive img-centre" style="cursor:pointer" width="350px">
            </div>
            <div class="col-sm-5">          
		 	  <form method="post" action="ProverSebyaServlet" id="trainingOneForm">
				 <input type="hidden" name="test_grade" value="<%=test_grade%>">
		 		 <input type="hidden" name="topic_id" value="<%=topicIds.get(j-32)%>">
				 <input type="hidden" name="questionId" value="<%=j%>">
				 <input type="hidden" name="task_type" value="five">
				 <input type="hidden" name="page" value="trainingFiveForm">
				 <input type="hidden" name="wordID" value="<%=wordsRusKaz.get(j-32).id%>">
				 <input type="hidden" name="variant" value="">
				 <input type="hidden" name="correctAns" value="<%=wordsRusKaz.get(j-32).rus%>">
				 
				 <%
				 Random rand = new Random();
				 ArrayList<Integer> numbers = new ArrayList<Integer>();   
				 Random randomGenerator = new Random();
				 while (numbers.size() < 3) {
		
				     int random = randomGenerator .nextInt(wordsRusKaz.size());
				     if (!numbers.contains(random)&& random!=(j-32)) {
				         numbers.add(random);
				     }
				 }
				 int type = rand.nextInt(3);
				 String width = "style='width:180px;'";
				 if(type == 0){
					 %>
					<div class="row">
					<div class="col-sm-9"><button class="btn btn-answer btn-block train1"  correct="1"><%=wordsRusKaz.get(j-32).rus%></button></div>
						</div>
					<div class="row">
					<div class="col-sm-9"><button class="btn btn-answer btn-block train1" correct="0"><%=wordsRusKaz.get(numbers.get(0)).rus%></button></div>
						</div>
					<div class="row">
					<div class="col-sm-9"><button class="btn btn-answer btn-block train1"  correct="0"><%=wordsRusKaz.get(numbers.get(1)).rus%></button></div>
						</div>
				<%}
				 else if(type == 1){
					 %>
					<div class="row">
					<div class="col-sm-9"><button class="btn btn-answer btn-block train1" correct="0"><%=wordsRusKaz.get(numbers.get(0)).rus%></button></div>
						</div>
					<div class="row">
					<div class="col-sm-9"><button class="btn btn-answer btn-block train1"  correct="1"><%=wordsRusKaz.get(j-32).rus%></button></div>
						</div>
					<div class="row">
					<div class="col-sm-9"><button class="btn btn-answer btn-block train1"  correct="0"><%=wordsRusKaz.get(numbers.get(1)).rus%></button></div>
						</div>
				<%}
				else if(type == 2){
					 %>
					<div class="row">
					<div class="col-sm-9"><button class="btn btn-answer btn-block train1" correct="0"><%=wordsRusKaz.get(numbers.get(0)).rus%></button></div>
						</div>
					<div class="row">
					<div class="col-sm-9"><button class="btn btn-answer btn-block train1" correct="0"><%=wordsRusKaz.get(numbers.get(1)).rus%></button></div>
						</div>
					<div class="row">
					<div class="col-sm-9"><button class="btn btn-answer btn-block train1" correct="1"><%=wordsRusKaz.get(j-32).rus%></button></div>
						</div>
				<%}
				%>
			 </form>
			 <br>
			 </div>
          </div>
<%	}
	else { 

		List<String> wrongWordList=new ArrayList<String>();
		for (int k=0; k<topicIds.size(); k++){
			String sqlForResult = "select x2.word_kaz from results_test x"//
					+ " left join words x2 on x2.word_id=x.word_id"//
					+ " where student_id=" + session.getAttribute("studentID") + " and topic_id=" + topicIds.get(k);
			PreparedStatement ps = con.prepareStatement(sqlForResult);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (!wrongWordList.contains(rs.getString(1))){
					wrongWordList.add(rs.getString(1));
				}
			}
		}
		
	String userId = (String)session.getAttribute("userId");
	String sql5 = "select studentClass from students where user_id='"+userId+"'";
	PreparedStatement prepStmt5 = con.prepareStatement(sql5);
	ResultSet rs5 = prepStmt5.executeQuery();
	String classId = null;
	if (rs5.next()){
    	classId = rs5.getString(1);
    }
	 if(score.equals("100")){ %>
		<h1 class="text-center">Хорошая работа!</h1>
		<h2 class="text-center">Ты ответил правильно на все вопросы!</h2>
		<div class="row">	
			<div class="col-sm-4 col-sm-offset-2" style="margin-top:15px;">
				<div class="c100 p100 center">
	                <span style="margin-top:0px;">100%</span>
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
	 else{ 
		 %>
		 <h1 class="text-center">Список неверных слов:</h1>	
		<div class="row">
		<%  double scoreDouble = Double.parseDouble(score);
			int scoreInt = (int) scoreDouble; %>	
			<div class="col-sm-4" style="margin-top:15px;">
				<div class="c100 p<%=scoreInt%> center">
	                 <span style="margin-top:0px;"><%=scoreInt%>%</span>
	                 <div class="slice">
	                     <div class="bar"></div>
	                     <div class="fill"></div>
	                 </div>
                </div>
			</div>
			<div class="col-sm-4">
			<%
			for(String wrongWord: wrongWordList){ 
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
			   	<div class="col-sm-4 col-sm-offset-4">
			   		<a href="?navPage=homeStudent&grade=one&classId=<%=classId%>" class = "btn btn-success" style="font-size: 17px;">Хочу пройти еще уроки</a>
			   	</div>
		   	</div>
		   	<%
		String sql="update test set score="+score+" where grade="+test_grade+" and score<"+score+" and user_id="+session.getAttribute("userId");
		PreparedStatement prepStmt = con.prepareStatement(sql);
		prepStmt.executeUpdate(); %>
<%  } %>
	</div>
</section>
      
   