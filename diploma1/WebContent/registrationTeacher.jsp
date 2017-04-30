<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@include file="mysql.jsp" %>
<meta charset="utf-8">
<script type="text/javascript">
window.onload = function () {
    document.getElementById("inputPassword").onchange = validatePassword;
    document.getElementById("confirmPassword").onchange = validatePassword;
};
function validatePassword(){
var pass2=document.getElementById("confirmPassword").value;
var pass1=document.getElementById("inputPassword").value;
if(pass1!=pass2)
    document.getElementById("confirmPassword").setCustomValidity("Пароли не совпадают!");
else
    document.getElementById("confirmPassword").setCustomValidity('');
}
</script>

<div class="" >
	<h1 class="text-center">Регистрация для Учителя</h1>
</div>
<div class="hr-img">
    <img src="img/hr.png" style="width: 75px;" class="img-centre" alt="">
</div>
<br>
<% 
String message=null;
	if(request.getParameter("message")!=null){
		message="Этот электронный адрес уже зарегистрирован!";
%>
<div class="" >
	<h3 class="text-center"><font color="purple"><%=message %></font></h3>
</div>
<% } %>
<br>
<div class="reg" >
<form class="form-horizontal" id="registrationForm" method="POST" action="RegistrationServlet">
<input type="hidden" name="userStatus" value="3">
  <div class="form-group ">
    <!--<label class="control-label col-xs-3" for="lastName"></label>-->
    <div class="">
      <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Введите фамилию" required>
    </div>
  </div>
  <div class="form-group">
    <!--<label class="control-label col-xs-3" for="firstName"></label>-->
    <div class="">
      <input type="text" class="form-control" id="firstName" name="firstName" placeholder="Введите имя" required>
    </div>
  </div>
  <div class="form-group">
    <!--<label class="control-label col-xs-3" for="inputEmail"></label>-->
    <div class="">
      <input type="email" class="form-control" id="inputEmail" name="email" placeholder="E-mail" required>
    </div>
  </div>
  <div class="form-group">
    <!--<label class="control-label col-xs-3" for="inputPassword"></label>-->
    <div class="">
      <input type="password" class="form-control" id="inputPassword" name="pwd" placeholder="Введите пароль" required>
    </div>
  </div>
  <div class="form-group">
    <!--<label class="control-label col-xs-3" for="confirmPassword"></label>-->
    <div class="">
      <input type="password" class="form-control" id="confirmPassword" name="pwd2" placeholder="Введите пароль ещё раз" required>
    </div>
  </div>
  <div class="row">
  <div class="form-group ">
    <!--<label class="control-label col-xs-3"></label>-->
    <div class="col-xs-6">
      <select class="form-control" name="city" required>
        <option value="">Регион</option>
        <option value="Астана">г. Астана</option>
        <option value="Алматы">г. Алматы</option>
        <option value="Акмолинская">Акмолинская обл.</option>
        <option value="Актюбинская">Актюбинская обл.</option>
        <option value="Алматинская">Алматинская обл.</option>
        <option value="Атырауская">Атырауская обл.</option>
        <option value="Восточно-Казахстанская">Восточно-Казахстанская обл.</option>
        <option value="Жамбылская">Жамбылская обл.</option>
        <option value="Западно-Казахстанская">Западно-Казахстанская обл.</option>
        <option value="Карагандинская">Карагандинская обл.</option>
        <option value="Костанайская">Костанайская обл.</option>
        <option value="Кызылординская">Кызылординская обл.</option>
        <option value="Мангистауская">Мангистауская обл.</option>
        <option value="Павлодарская">Павлодарская обл.</option>
        <option value="Северо-Казахстанская">Северо-Казахстанская обл.</option>
        <option value="Южно-Казахстанская">Южно-Казахстанская обл.</option>
      </select>
    </div>
    <div class="col-xs-6">
      <input type="number" name="school" class="form-control" id="school" placeholder="Номер школы" required/>
    </div>
  </div>
  </div>
  <br />
  <div class="form-group">
    <div class="text-center">
      <a href="index.jsp" class="btn btn-yellow" style="color:#000;"><i class="glyphicon glyphicon-menu-left"></i> Назад</a>
      <input type="reset" class="btn btn-default " value="Очистить форму">
      <input type="submit" class="btn btn-yellow " value="Готово">
    </div>
  </div>
</form>
</div>