  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <meta charset="utf-8">
   
  <div id="login-overlay" class="modal-dialog">
      <div class="modal-content">
          
          <div class="modal-body">
          
              <div class="row">
                  <div class="col-xs-12">
                  
              <h1 class="modal-title text-center" id="myModalLabel">SpeakKazakh</h1>
              <% 	String message=null;
					if(request.getParameter("message")!=null){
						message="Вы зарегистрировались. Теперь войдите в систему."; %>
				<div class="" >
					<h3 class="text-center"><font color="purple"><%=message %></font></h3>
				</div>
				<% } %>
                      <div class="">
                          <form id="loginForm" method="POST" action="LoginServlet" novalidate="novalidate">
                              <div class="form-group">
                                  <label for="username" class="control-label">E-mail</label>
                                  <input type="text" class="form-control" id="username" name="username" value="" required="" title="Пожалуйста напишите вашу почту" placeholder="example@gmail.com">
                                  <span class="help-block"></span>
                              </div>
                              <div class="form-group">
                                  <label for="password" class="control-label">Пароль</label>
                                  <input type="password" class="form-control" id="password" name="password" value="" required="" title="Пожалуйста введите свой пароль">
                                  <span class="help-block"></span>
                              </div>
                              <div id="loginErrorMsg" class="alert alert-error hide">Неверная почта или пароль</div>
                              <button type="submit" class="btn btn-yellow btn-block">Готово</button>
                              <a href="?navPage=forgot" class="btn btn-default btn-block">Забыли пароль?</a>
                          </form>
                      </div>
                      <div class="col-xs-12">
                  	
                      <p><h4 class="reg-title">	<br>Хочу начать обучение! <a href="?navPage=registration" class="">Регистрация</a></h4></p>
                      <p><h4 class="reg-title"><a href="?navPage=registrationTeacher" class="">Регистрация для учителей</a></h4></p>
                  </div>
                  </div>
                  
              </div>
          </div>
      </div>
  </div>