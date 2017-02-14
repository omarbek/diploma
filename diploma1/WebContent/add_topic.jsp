<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@include file="mysql.jsp" %>
<meta charset="utf-8">
<% boolean isEdit=Boolean.valueOf(request.getParameter("isEdit")); %>
<% 
	if(isEdit){
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
      <input type="text" class="form-control" name="name" required>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-xs-3">Класс:</label>
    <div class="col-xs-9">
		<select class="form-control" name="classNumber">
	        <option value="1">1</option>
	        <option value="2">2</option>
	        <option value="3">3</option>
	        <option value="4">4</option>
      </select>
    </div>
  </div>
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
  <input type="hidden" name="page" value="add_topic">
</form>