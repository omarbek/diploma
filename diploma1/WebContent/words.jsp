<%@page import="javax.swing.JOptionPane"%>
<% 
	session=request.getSession(false);
	if(session==null){
		session.invalidate();
	response.sendRedirect("index.jsp");
	}else{
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="mysql.jsp" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <% 
try{	
 	Long topicId = Long.parseLong(request.getParameter("topic_id"));
 	String sql = "select * from topics where topic_id="+topicId;
 	PreparedStatement prepStmt = con.prepareStatement(sql);
	ResultSet rs = prepStmt.executeQuery();
	String topicName=null;
	if(rs.next()){
 		topicName=rs.getString("topic_name");
	}
 %>
    <div class="container" id="content">
      <section id="main" class="trener">
      <h1 class="text-center"><%=topicName %></h1>
        <div class="hr-img">
          <img src="img/hr.png" style="width: 50px;" class="img-centre" alt="">
        </div>
        <br>
          <%
          	String sqlWords="select x.* from words x left join topic_word x2 on x2.word_id=x.word_id"
          					+" where x2.topic_id="+topicId;
          	PreparedStatement prepStmtWords = con.prepareStatement(sqlWords);
      	  	ResultSet rsWords = prepStmtWords.executeQuery();
      	  	int i=0;
	  		while(rsWords.next()){
	  			if(i%4 == 0){%>
	  			<div class="row">
	  		  	<%}%>
	  		  	<div class="col-md-3 ">
	  		            <div class="subject">
	  		              <img src="img/questions/<%=rsWords.getLong(1)%>.jpg" class="img-responsive" alt="">
	  		              <div class="row">
	  						<div class="col-md-7 ">
	  							<h3><%=rsWords.getString(2) %></h3>
	  						</div>
	  						<div class="col-md-5 ">
	  							<a href="?navPage=edit_word&word_id=<%=rsWords.getLong(1) %>&topic_id=<%=topicId %>">Изменить</a>
	  							<form action="TopicServlet" method="post">
					           		<input type="hidden" name="word_id" value="<%=rsWords.getString(1) %>">
				           			<input type="hidden" name="topic_id" value="<%=topicId%>">
					           		<input type="hidden" name="page" value="remove_word">
					            	<button>Удалить</button>
					            </form>
	  						</div>	
	  					  </div>
	  		            </div>
	  		     </div>
	  			<%if((i+1)%4 == 0){%>
	  			</div>
	  			<%}
	  			i++;
	  		} %>
            
            <br>
	        <form action="AdminServlet" method="post" enctype="multipart/form-data">
            	Слово (на русском): <input type="text" name="rus"><br>
            	Слово (на казахском): <input type="text" name="kaz">
           		<input type="hidden" name="topic_id" value="<%=topicId%>">
           		<input type="hidden" name="page" value="add_word">
      			<input name="file" type="file">
            	<button>Добавить</button>
            </form>
        </div>
      </section>
    </div>
    <%
    }
catch(Exception e){
	JOptionPane.showMessageDialog(null, e.getLocalizedMessage());
	e.printStackTrace();
}
%>
<%}%>