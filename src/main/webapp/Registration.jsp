<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="ISO-8859-1">
  <!-- https://materializecss.com/ -->
  <!-- Compiled and minified CSS -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

  <!-- Compiled and minified JavaScript -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

  <title>Registration</title>
</head>
  <body>
    <div style="margin-left: 30%; margin-right: 30%; ">

      <h1 style="text-align: center">Registration Form</h1>

      <form >

        <!-- Login -->
        <div class="row">
          <div class="input-field col s12">
            <input id="login" type="text" class="validate">
            <label for="login">Login</label>
          </div>
        </div>

        <!-- Email -->
        <div class="row">
          <div class="input-field col s12">
            <input id="email" type="email" class="validate">
            <label for="email">Email</label>
          </div>
        </div>

        <!-- Password -->
        <div class="row">
          <div class="input-field col s12">
            <input id="pass1" type="password" class="validate">
            <label for="pass1">Password</label>
          </div>
        </div>

        <!-- Repeat password -->
        <div class="row">
          <div class="input-field col s12">
            <input id="pass2" type="password" class="validate">
            <label for="pass2">Repeat password</label>
          </div>
        </div>

        <!-- Button -->
        <div style="padding: 0 11px">
          <div style="text-align: left; display: inline; float: right">
            <a class="waves-effect waves-light btn" >Create account</a>
          </div>
          <div style="text-align: right; display: inline">
            <a class="waves-effect waves-light btn" href="WEB-INF/index.jsp">Cancel</a>
          </div>
        </div>


      </form>

    </div>
  </body>
</html>