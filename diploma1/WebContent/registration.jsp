<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@include file="mysql.jsp" %>
<script type="text/javascript">
window.onload = function () {
    document.getElementById("inputPassword").onchange = validatePassword;
    document.getElementById("confirmPassword").onchange = validatePassword;
}
function validatePassword(){
var pass2=document.getElementById("confirmPassword").value;
var pass1=document.getElementById("inputPassword").value;
if(pass1!=pass2)
    document.getElementById("confirmPassword").setCustomValidity("Passwords Don't Match");
else
    document.getElementById("confirmPassword").setCustomValidity('');
//empty string means no validation error
}
</script>
<div class="col-xs-offset-3 col-xs-9"><h1>Регистрация</h1></div>

<form class="form-horizontal" id="registrationForm" method="POST" action="RegistrationServlet">
  <div class="form-group">
    <label class="control-label col-xs-3" for="lastName">Фамилия:</label>
    <div class="col-xs-9">
      <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Введите фамилию" required>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-xs-3" for="firstName">Имя:</label>
    <div class="col-xs-9">
      <input type="text" class="form-control" id="firstName" name="firstName" placeholder="Введите имя" required>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-xs-3" for="inputEmail">E-mail:</label>
    <div class="col-xs-9">
      <input type="email" class="form-control" id="inputEmail" name="email" placeholder="E-mail" required>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-xs-3" for="inputPassword">Пароль:</label>
    <div class="col-xs-9">
      <input type="password" class="form-control" id="inputPassword" name="pwd" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" 
      			title="Пароль должен состоять минимум из 8 символов и должен иметь минимум одну цифру, одну строчную и одну прописную букву" placeholder="Введите пароль" required>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-xs-3" for="confirmPassword">Подтвердите пароль:</label>
    <div class="col-xs-9">
      <input type="password" class="form-control" id="confirmPassword" name="pwd2" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" 
      			title="Пароль должен состоять минимум из 8 символов и должен иметь минимум одну цифру, одну строчную и одну прописную букву" placeholder="Введите пароль ещё раз" required>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-xs-3">Статус:</label>
    <div class="col-xs-2">
      <label class="radio-inline">
        <input type="radio" name="statusRadios" value="1"> Учитель
      </label>
    </div>
    <div class="col-xs-2">
      <label class="radio-inline">
        <input type="radio" name="statusRadios" value="2"> Ученик
      </label>
    </div>
  </div>
  <% Connection con = (new DBConnection()).getConnection();
	 String sql = "SELECT distinct city FROM schools";
	 PreparedStatement prepStmt = con.prepareStatement(sql);
	 ResultSet rs = prepStmt.executeQuery();%>
  <div class="form-group">
    <label class="control-label col-xs-3"></label>
    <div class="col-xs-3">
      <select class="form-control" name="city">
        <option disabled selected>Город</option>
        <% while(rs.next()){ %>
        <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
        <% } %>
      </select>
    </div>
  <% String sql2 = "SELECT school_name FROM schools where city = 'Almaty'";
	 PreparedStatement prepStmt2 = con.prepareStatement(sql2);
	 ResultSet rs2 = prepStmt2.executeQuery();  %>
    <div class="col-xs-3">
      <select class="form-control" name="school">
        <option disabled selected>Школа</option>
        <% while (rs2.next()){ %>
        <option value="<%=rs2.getString(1)%>"><%=rs2.getString(1)%></option>
        <% } %>
      </select>
    </div>
    <% String sql3 = "SELECT class_name FROM classes";
	 PreparedStatement prepStmt3 = con.prepareStatement(sql3);
	 ResultSet rs3 = prepStmt3.executeQuery();  %>
    <div class="col-xs-3">
      <select class="form-control" name="studentClass">
        <option disabled selected>Класс</option>
        <% while (rs3.next()){ %>
        <option value="<%=rs3.getString(1)%>"><%=rs3.getString(1)%></option>
        <% } %>
      </select>
    </div>
  </div>
  <br />
  <div class="form-group">
    <div class="col-xs-offset-3 col-xs-9">
      <input type="submit" class="btn btn-primary" value="Регистрация">
      <input type="reset" class="btn btn-default" value="Очистить форму">
    </div>
  </div>
</form>