<%@page import="main.Word"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@include file="mysql.jsp" %>
<meta charset="utf-8">
<% 
	Long topicId=null;
	String classNumber=null;
	String name=null;
	if(request.getParameter("topic_id")!=null){
		topicId=Long.parseLong(request.getParameter("topic_id"));
		PreparedStatement ps=con.prepareStatement("select * from topics where topic_id="+topicId);
		ResultSet rs=ps.executeQuery();
		String grade=null;
		if(rs.next()){
			 name=rs.getString("topic_name");
			 grade=rs.getString("grade");
			 classNumber=Word.getGrade(grade); 
		}
	}
	if(topicId!=null){
%>
<div class="col-xs-offset-3 col-xs-9"><h1>Изменить урок</h1></div>
<%
	}else{
%>
<div class="col-xs-offset-3 col-xs-9"><h1>Добавить урок</h1></div>
<%
	}
%>
<form class="form-horizontal" action="AdminServlet" method="post" enctype="multipart/form-data">
  <div class="form-group">
    <label class="control-label col-xs-3">Имя урока:</label>
    <div class="col-xs-9">
      <input type="text" class="form-control" name="name" value="<% if(name!=null&&!name.isEmpty()) out.print(name); %>" required>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-xs-3">Класс:</label>
    <div class="col-xs-9">
		<select class="form-control" name="classNumber">
			<% if("four".equals(classNumber)){ %>
		        <option value="1">1</option>
		        <option value="2">2</option>
		        <option value="3">3</option>
		        <option selected="selected" value="4">4</option>
	        <% } else if("three".equals(classNumber)){ %>
		        <option value="1">1</option>
		        <option value="2">2</option>
		        <option selected="selected" value="3">3</option>
		        <option value="4">4</option>
	        <% } else if("two".equals(classNumber)){ %>
		        <option value="1">1</option>
		        <option selected="selected" value="2">2</option>
		        <option value="3">3</option>
		        <option value="4">4</option>
	        <% } else{ %>
		        <option selected="selected" value="1">1</option>
		        <option value="2">2</option>
		        <option value="3">3</option>
		        <option value="4">4</option>
	        <% } %>
      </select>
    </div>
  </div>
  <% 
  	String pageValue=null;
  	if(topicId!=null){
  		pageValue="edit_topic";
  %>
  <input type="hidden" name="topicId" value="<%= topicId %>">
  <%
  	}else{
  		pageValue="add_topic";
  	}
   %>
  <input type="hidden" name="page" value="<%= pageValue %>">
  <div class="form-group">
    <label class="control-label col-xs-3">Картинка:</label>
    <div class="col-xs-3">
      <input name="file" type="file">
    </div>
  </div>
  <br />
  <div class="form-group">
    <div class="col-xs-offset-3 col-xs-9">
      <input type="submit" class="btn btn-primary" value="Добавить">
    </div>
  </div>
</form>