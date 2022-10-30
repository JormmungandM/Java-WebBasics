<%-- Форма регистрации нового пользователя --%>
<%@ page contentType="text/html;charset=UTF-8" %><%
  String home = request.getContextPath() ;
  String regError = (String) request.getAttribute( "regError" ) ;
  String regOk = (String) request.getAttribute( "regOk" ) ;
  String SaveName = (String) request.getAttribute( "SaveName" );
  String SaveLog = (String)  request.getAttribute( "SaveLog" );
%>

  <div class="row" style="width: 60%">
      <div class="card" style="padding: 20px; width: 60% ; text-align: center; margin: 0 auto !important;">
        <h2 style=" margin: 10px 0">Register<%=SaveLog%></h2>
        <% if( regError != null ) { %><h3 class="card-title text-center reg-error"><%=regError%></h3><% } %>
        <% if( regOk != null ) { %><h3 class="card-title text-center reg-ok"><%=regOk%></h3><% } %>
        <div class="card-body">
          <form method="POST" action="" enctype="multipart/form-data">
            <div class="form-group" style="width: 80%; margin-left: auto; margin-right: auto ">
              <!-- Login -->
              <div class="row">
                <div class="input-field">
                  <input name="Login" id="log" type="text" class="validate"
                  <%if(SaveLog != null){%>
                          value="<%=SaveLog%>"
                  <%}%>
                  >
                  <label for="log">Login</label>
                </div>
              </div>
              <!-- Name Surname -->
              <div class="row">
                <div class="input-field">
                  <input name="Name" id="nam" type="text" class="validate"
                    <%if(SaveName != null){%>
                         value="<%=SaveName%>"
                    <%}%>>
                  <label for="nam">Name</label>
                </div>
              </div>
              <!-- Password -->
              <div class="row">
                <div class="input-field">
                  <input name="Password" id="pass1" type="password" class="validate" >
                  <label for="pass1">Password</label>
                </div>
              </div>
              <!-- RepeatPassword -->
              <div class="row">
                <div class="input-field">
                  <input name="confirmPassword" id="pass2" type="password" class="validate" >
                  <label for="pass2">Repeat password</label>
                </div>
              </div>

              <!-- Avatar -->
              <div class="file-field input-field">
                <div class="btn">
                  <span>File</span>
                  <input type="file">
                </div>
                <div class="file-path-wrapper">
                  <input name="Avatar" class="file-path validate"   type="text">
                </div>
              </div>
            </div>
            <br/>
            <div>
              <a href="<%=home%>" type="submit" class="btn btn-primary" >Cancel</a>
              <button type="submit" class="btn btn-primary" >Create Account</button>
            </div>
          </form>
        </div>
  </div>
</div>