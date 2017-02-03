  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <div id="login-overlay" class="modal-dialog">
      <div class="modal-content">
          <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
              <h4 class="modal-title" id="myModalLabel">Добро пожаловать в speakkazakh.com!</h4>
          </div>
          <div class="modal-body">
              <div class="row">
                  <div class="col-xs-6">
                      <div class="well">
                          <form id="loginForm" method="POST" action="LoginServlet" novalidate="novalidate">
                              <div class="form-group">
                                  <label for="username" class="control-label">Почта</label>
                                  <input type="text" class="form-control" id="username" name="username" value="" required="" title="Пожалуйста напишите вашу почту" placeholder="example@gmail.com">
                                  <span class="help-block"></span>
                              </div>
                              <div class="form-group">
                                  <label for="password" class="control-label">Пароль</label>
                                  <input type="password" class="form-control" id="password" name="password" value="" required="" title="Пожалуйста введите свой пароль">
                                  <span class="help-block"></span>
                              </div>
                              <div id="loginErrorMsg" class="alert alert-error hide">Неверная почта или пароль</div>
                              <div class="checkbox">
                                  <label>
                                      <input type="checkbox" name="remember" id="remember"> Запомнить меня
                                  </label>
                                  <p class="help-block">(если это личный компьютер)</p>
                              </div>
                              <button type="submit" class="btn btn-success btn-block">Готово</button>
                              <a href="/forgot/" class="btn btn-default btn-block">Помощь в регистрации</a>
                          </form>
                      </div>
                  </div>
                  <div class="col-xs-6">
                      <p class="lead">Еще не зарегистрирован?</p>                     
                      <p><a href="?navPage=registration" class="btn btn-info btn-block">Да, хочу зарегистрироваться сейчас!</a></p>
                  </div>
              </div>
          </div>
      </div>
  </div>