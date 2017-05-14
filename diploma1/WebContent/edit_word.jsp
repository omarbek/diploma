<%@page import="javax.swing.JOptionPane"%>
<%@page import="main.Word"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@include file="mysql.jsp" %>
<meta charset="utf-8">
<% 
try{
Long topicId=null;
	Long wordId=null;
	String rus=null;
	String kaz=null;
	if(request.getParameter("word_id")!=null&&request.getParameter("topic_id")!=null){
		wordId=Long.parseLong(request.getParameter("word_id"));
		topicId=Long.parseLong(request.getParameter("topic_id"));
		PreparedStatement ps=con.prepareStatement("select *s from words where word_id="+wordId);
		ResultSet rs=ps.executeQuery();
		String grade=null;
		if(rs.next()){
			 rus=rs.getString("word_rus");
			 kaz=rs.getString("word_kaz");
		}
	}
%>
<div class="col-xs-offset-3 col-xs-9"><h1>Изменить слово</h1></div>
<form class="form-horizontal" action="AdminServlet" method="post" enctype="multipart/form-data">
  <div class="form-group">
    <label class="control-label col-xs-3">Слово (на русском):</label>
    <div class="col-xs-9">
      <input type="text" class="form-control" name="rus" value="<% if(rus!=null&&!rus.isEmpty()) out.print(rus); %>" required>
    </div>
  </div>
   <div class="form-group">
    <label class="control-label col-xs-3">Слово (на казахском):</label>
    <div class="col-xs-9">
      <input type="text" class="form-control" name="kaz" value="<% if(kaz!=null&&!kaz.isEmpty()) out.print(kaz); %>" required>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-xs-3">Урок:</label>
    <div class="col-xs-9">
		<select class="form-control" name="topic_id">
			<%
				PreparedStatement topics=con.prepareStatement("select * from topics");
				ResultSet rs=topics.executeQuery();
				while(rs.next()){
					if(rs.getLong(1)==topicId){
						%>
		        	<option selected="selected" value="<%=rs.getLong(1) %>"><%=rs.getString(2) %></option>
						<%
					}else{
						%>
		        	<option value="<%=rs.getLong(1) %>"><%=rs.getString(2) %></option>
						<%
					}
				}
	        %>
      </select>
    </div>
  </div>
  <input type="hidden" name="word_id" value="<%= wordId %>">
  <input type="hidden" name="page" value="edit_word">
  <div class="form-group">
    <label class="control-label col-xs-3">Картинка:</label>
    <div class="col-xs-3">
      <input name="file" type="file">
    </div>
  </div>
  <br />
  <div class="form-group">
    <div class="col-xs-offset-3 col-xs-9">
      <input type="submit" class="btn btn-primary" value="Сохранить">
    </div>
  </div>
  <%}
catch(Exception e){
	session = request.getSession(false);
	if (session == null) {
		session.invalidate();
	} else {
		JOptionPane.showMessageDialog(null, "edit_word.jsp\n"+e.getLocalizedMessage());
	}
}finally{
	 if(con != null)  con.close(); 
}
%>
</form>
