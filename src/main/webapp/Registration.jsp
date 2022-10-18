<%@ page contentType="text/html;charset=UTF-8" %><%
  String login = (String)request.getAttribute("login");
  String email = (String)request.getAttribute("email");
  String password = (String)request.getAttribute("password");
  String Error = (String) request.getAttribute("Error");
%>
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

      <form method="post">

        <!-- Login -->
        <div class="row">
          <div class="input-field col s12">
            <input name="login" id="log" type="text" class="validate" >
            <label for="log">Login</label>
          </div>
        </div>

        <!-- Email -->
        <div class="row">
          <div class="input-field col s12">
            <input name="email" id="ema" type="email" class="validate" >
            <label for="ema">Email</label>
          </div>
        </div>

        <!-- Password -->
        <div class="row">
          <div class="input-field col s12">
            <input name="password" id="pass1" type="password" class="validate" >
            <label for="pass1">Password</label>
          </div>
        </div>

        <!-- Repeat password -->
        <div class="row">
          <div class="input-field col s12">
            <input name="password2" id="pass2" type="password" class="validate" >
            <label for="pass2">Repeat password</label>
          </div>
        </div>

        <!-- Button -->
        <div style="padding: 0 11px">
          <div style="text-align: left; display: inline; float: right">
            <button class="waves-effect waves-light btn" >Create account</button>
          </div>
          <div style="text-align: right; display: inline">
            <a class="waves-effect waves-light btn" href="WEB-INF/index.jsp">Cancel</a>
          </div>
        </div>

      </form>

      <p>
        <% if(Error == null){%>
          <% if(login != null && email != null){%>
            User: <b><%=login%></b>
            <br/>
            Email: <b><%= email %></b>
            <br/>
            Password: <b><%= password %></b>
          <% }%>
        <% } else {%>
          Error:  <b><%= Error %></b>
        <% }%>
      </p>

    </div>


  </body>
</html>