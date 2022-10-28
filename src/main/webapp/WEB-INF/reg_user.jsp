<%-- Форма регистрации нового пользователя --%>
<%@ page contentType="text/html;charset=UTF-8" %><%
  String home = request.getContextPath() ;
  String regError = (String) request.getAttribute( "regError" ) ;
  String regOk = (String) request.getAttribute( "regOk" ) ;
%>

<!-- Login -->
<div class="row">
  <div class="input-field col s12">
    <input name="userLogin" id="log" type="text" class="validate" >
    <label for="log">Login</label>
  </div>
</div>

<!-- Name Surname -->
<div class="row">
  <div class="input-field col s12">
    <input name="userName" id="ns" type="text" class="validate" >
    <label for="ns">Name Surname</label>
  </div>
</div>

<!-- Password -->
<div class="row">
  <div class="input-field col s12">
    <input name="userPassword" id="pass" type="text" class="validate" >
    <label for="pass">Login</label>
  </div>
</div>

<!-- RepeatPassword -->
<div class="row">
  <div class="input-field col s12">
    <input name="confirmPassword" id="pass2" type="text" class="validate" >
    <label for="pass2">Login</label>
  </div>
</div>

<!-- Avatar -->
<form action="#">
  <div class="file-field input-field">
    <div class="btn">
      <span>File</span>
      <input type="file">
    </div>
    <div class="file-path-wrapper">
      <input class="file-path validate"  name="userAvatar" type="text">
    </div>
  </div>
</form>


<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-5">
      <div class="card">
        <h2 class="card-title text-center">Register</h2>
        <% if( regError != null ) { %><h3 class="card-title text-center reg-error"><%=regError%></h3><% } %>
        <% if( regOk != null ) { %><h3 class="card-title text-center reg-ok"><%=regOk%></h3><% } %>
        <div class="card-body py-md-4">
          <form method="post" action="" enctype="multipart/form-data">
            <div class="form-group">
              <input type="text"     class="form-control" name="userLogin"       placeholder="Login" /><br/>
              <input type="text"     class="form-control" name="userName"        placeholder="Name Surname" /><br/>
              <input type="password" class="form-control" name="userPassword"    placeholder="Password" /><br/>
              <input type="password" class="form-control" name="confirmPassword" placeholder="Confirm password" /><br/>
              <input type="file"     class="form-control" name="userAvatar" />
            </div>
            <br/>
            <div class="d-flex flex-row align-items-center justify-content-between">
              <button type="submit" class="btn btn-primary">Create Account</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>