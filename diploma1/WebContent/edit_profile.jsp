<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

<div class="" style="margin-top: 50px;">
	<h1 class="text-center">Редактирование профиля</h1>
</div>
<div class="hr-img">
    <img src="img/hr.png" style="width: 75px;" class="img-centre" alt="">
</div>
<br>
<div class="reg" >
<form class="form-horizontal" id="registrationForm" method="POST" action="DeleteEditProfileServlet">
<input type="hidden" name="function_type" value="editProfile">
  <div class="form-group ">
    <!--<label class="control-label col-xs-3" for="lastName"></label>-->
    <div class="">
      <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Введите фамилию">
    </div>
  </div>
  <div class="form-group">
    <!--<label class="control-label col-xs-3" for="firstName"></label>-->
    <div class="">
      <input type="text" class="form-control" id="firstName" name="firstName" placeholder="Введите имя">
    </div>
  </div>
  <div class="form-group">
    <!--<label class="control-label col-xs-3" for="inputEmail"></label>-->
    <div class="">
      <input type="email" class="form-control" id="inputEmail" name="email" placeholder="E-mail">
    </div>
  </div>
  <div class="form-group">
    <!--<label class="control-label col-xs-3" for="inputPassword"></label>-->
    <div class="">
      <input type="password" class="form-control" id="inputPassword" name="pwd" placeholder="Введите пароль">
    </div>
  </div>
  <div class="form-group">
    <!--<label class="control-label col-xs-3" for="confirmPassword"></label>-->
    <div class="">
      <input type="password" class="form-control" id="confirmPassword" name="pwd2" placeholder="Введите пароль ещё раз">
    </div>
  </div>
  <div class="row">
  <div class="form-group ">
    <!--<label class="control-label col-xs-3"></label>-->
    <div class="col-xs-4">
      <select class="form-control" name="city">
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
    <div class="col-xs-4">
      <input type="number" name="school" class="form-control" id="school" placeholder="Номер школы"/>
    </div>
    <div class="col-xs-4">
      <select class="form-control" name="studentClass">
        <option value="">Класс</option>
        <option value="1">1 класс</option>
        <option value="2">2 класс</option>
        <option value="3">3 класс</option>
        <option value="4">4 класс</option>
      </select>
    </div>
  </div>
  </div>
  <br />
  <div class="form-group">
    <div class="text-center">
      <a href="?navPage=profile" class="btn btn-yellow" style="color:#000;"><i class="glyphicon glyphicon-menu-left"></i> Назад</a>
      <input type="reset" class="btn btn-default " value="Очистить форму">
      <input type="submit" class="btn btn-yellow " value="Готово">
    </div>
  </div>
</form>
</div>
