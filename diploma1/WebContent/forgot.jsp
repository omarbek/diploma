<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@include file="mysql.jsp" %>

<div class="" >
	<h1 class="text-center">Забыли пароль?</h1>
</div>
<div class="hr-img">
    <img src="img/hr.png" style="width: 75px;" class="img-centre" alt="">
</div>
<br>
<% 
	String message=null;
	if(request.getParameter("message")!=null){
		if(request.getParameter("message").isEmpty()){
			message="Такой почты не существует, повторите еще раз!";
		} else {
			message="Ваш пароль выслан на вашу почту "+(String)request.getParameter("message");
		}
%>
<div class="" >
	<h1 class="text-center"><font color="white"><%=message %></font></h1>
</div>
<% } %>
<br>
<div class="reg" >
<form class="form-horizontal" id="registrationForm" method="POST" action="ForgotServlet">
  <div class="form-group ">
    <!--<label class="control-label col-xs-3" for="lastName"></label>-->
    <div class="">
      <input type="text" class="form-control" name="email" placeholder="Введите почту" required>
    </div>
  </div>
  <br />
  <div class="form-group">
    <div class="text-center">
      <a href="index.jsp" class="btn btn-yellow" style="color:#000;"><i class="glyphicon glyphicon-menu-left"></i> Назад</a>
      <input type="submit" class="btn btn-yellow " value="Готово">
    </div>
  </div>
</form>
</div>