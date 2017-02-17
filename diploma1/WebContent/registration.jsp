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
    <label class="control-label col-xs-3"></label>
    <div class="col-xs-3">
      <select class="form-control" name="city">
        <option disabled selected>Регион</option>
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
    <div class="col-xs-3">
      <input type="number" name="school" class="form-control" id="school" placeholder="Номер школы"/>
    </div>
    <div class="col-xs-3">
      <select class="form-control" name="studentClass">
        <option disabled selected>Класс</option>
        <option value="1">1 класс</option>
        <option value="2">2 класс</option>
        <option value="3">3 класс</option>
        <option value="4">4 класс</option>
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