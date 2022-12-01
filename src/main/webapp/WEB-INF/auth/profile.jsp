<%@ page import="step.learning.entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" %><%
  User authUser = (User) request.getAttribute( "AuthUser" ) ;
  String home = request.getContextPath() ;
%>
  <div class="row"  style=" width:50%; margin: 0 auto;">
      <div class="card-panel">
        <div style="text-align: center">
          <h3>Кабинет пользователя</h3>
        </div>
        <div class="row">
          <div class="col s5" style="text-align: center">
            <div>
            <img
                 <%if (authUser.getAvatar() != null){%>
                 src="<%=home%>/image/<%=authUser.getAvatar()%>"
                 <%}else{%>
                 src="<%=home%>/image/16480.png"
                 <%}%>
                 alt="<%=authUser.getLogin()%>" style="width: 300px; height: 300px"/>
            </div>
            <div class="row" style="font-size: 16px">
              Id: <b data-field-name="id"><%= authUser.getId() %></b>
            </div>
          </div>
          <div class="col s7">
            <h5 class="profile-name">
              <span>Имя: </span> <b data-field-name="name"><%= authUser.getName() %></b>
            </h5>
            <h5 class="profile-name">
              <span>Логин: </span> <b data-field-name="login"><%= authUser.getLogin() %></b>
            </h5>
            <h5 class="profile-name">
              <span>E-mail: </span>
              <b data-field-name="email" id="emailName"
                 <% if( authUser.getEmailCodeAttempts() > 3 ) { %>
                   class="email-banned" <%-- crimson --%>
                 <%}else if( authUser.getEmailCode() != null ){ %>
                    class="email-check" <%-- DarkOrange --%>
                 <%}else{ %>
                    class="email-ok"    <%-- forestgreen --%>
                 <%}%>
              >
                <%= authUser.getEmail()%>
              </b>
              <p hidden id="emailBanned" >Ваша почта забаннена!</p>

              <a hidden id="emailConfirm" href="<%=home%>/checkmail/" title="Почта не подтверждена, перейти на страницу подтверждения">&#x1F4E7;</a>

            </h5>
            <p class="profile-fieldset-avatar">
              <div class="file-field input-field">
                <div class="waves-effect waves-light btn">
                  <span>Картинка:</span>
                  <input type="file" id="avatar-input" alt="avatar-input" />
                </div>
                <div class="file-path-wrapper">
                  <label for="avatar-save-button"></label>
                  <input class="file-path validate" id="avatar-save-button" alt="avatar-input" type="text" placeholder="Upload files">
                </div>
              </div>
            </p>

            <!-- Modal Trigger -->
            <a class="waves-effect waves-light btn modal-trigger" href="#modal1">Edit password</a>

            <!-- Modal Structure -->
            <div id="modal1" class="modal">
              <div class="modal-content">
                <h4>Edit password</h4>
                <div class="profile-pass" style="width: 80%; margin: 0 auto; padding: 15px 0">
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
                  <button type="submit" class="btn btn-primary" id="change-pass-button" >Change</button>
                </div>
              </div>
              <div class="modal-footer">
                <a href="#!" class="modal-close waves-effect waves-red btn-flat">Close</a>
              </div>
            </div>

          </div>




        </div>
        <div class="row">
          <div class="col s12">
            <%--Вернуться на главную--%>
            <a href="<%=home%>" type="submit" class="btn btn-primary" >Back</a>
            <%--Выйти из аккаунта--%>
            <a href="?logout=true" class="btn btn-primary" style="float: right;">Log out</a>
          </div>
        </div>
  </div>


<script>
  document.addEventListener( "DOMContentLoaded", () => {

    // Показываем ссылку на подтверждение почты
    const nameEmail = document.getElementById("emailName")
    if(nameEmail.className === "email-banned"){
      document.getElementById("emailBanned").hidden = false;
    }
    else if(nameEmail.className === "email-check"){
      document.getElementById("emailConfirm").hidden = false;
    }
    const changePassButton = document.querySelector( "#change-pass-button" ) ;
    if( ! changePassButton ) throw "'#change-pass-button' not found" ;
    changePassButton.addEventListener( 'click', changePassClick )

    const avatarSaveButton = document.querySelector( "#avatar-save-button" ) ;
    if( ! avatarSaveButton ) throw "'#avatar-save-button' not found" ;
    avatarSaveButton.addEventListener( 'click', avatarSaveClick ) ;


    for( let nameElement of document.querySelectorAll( ".profile-name b" ) ){
      nameElement.addEventListener( "click", nameClick ) ;
      nameElement.addEventListener( "blur", nameBlur ) ;
      nameElement.addEventListener( "keydown", nameKeydown ) ;
    }
  });

  function changePassClick(e) {
    let passwords = e.target.parentNode.querySelectorAll('input[type="password"]') ;
    if( passwords[0].value !== passwords[1].value ) {
      alert( "Пароли не совпадают" ) ;
      passwords[0].value = passwords[1].value = '' ;
      return ;
    }
    if( passwords[0].value.length < 3 ) {
      alert( "Пароль слишком короткий" ) ;
      passwords[0].value = passwords[1].value = '' ;
      return ;
    }
    // console.log( passwords[0].value ) ;
    fetch( "/Java_WebBasics_war_exploded/register/?password=" + passwords[0].value, {
      method: "PUT",
      headers: { },
      body: ""
    }).then( r => r.text() )
            .then( t => {

              alert(t + " (password)"); // сообщени об успешном (или неуспешном) обновлении
              passwords[0].value = passwords[1].value = '' ;
     } ) ;
  }

  function avatarSaveClick() {
    const avatarInput = document.querySelector( "#avatar-input" ) ;
    if( ! avatarInput ) throw "'#avatar-input' not found" ;
    if( avatarInput.files.length === 0 ) {
      alert( "select a file" ) ;
      return ;
    }
    let formData = new FormData() ;
    formData.append( "userAvatar", avatarInput.files[0] ) ;
    fetch( "/Java_WebBasics_war_exploded/register/", {
      method: "PUT",
      headers: { },
      body: formData  // наличие файла в formData автоматически сформирует multipart запрос
    }).then( r => r.text() )
      .then( t => {
          alert(t);
       } ) ;
  }
  function nameKeydown(e) {
    if( e.keyCode === 13 ) {
      e.preventDefault() ;
      e.target.blur() ;  // снять фокус ввода с элемента
      return false ;
    }
  }
  function nameClick(e) {
    e.target.setAttribute( "contenteditable", "true" ) ;
    e.target.focus() ;  // установить фокус ввода на элемент
    e.target.savedText = e.target.innerText ;
  }
  function nameBlur(e) {
    e.target.removeAttribute( "contenteditable" ) ;
    if( e.target.savedText !== e.target.innerText ) {
      if( confirm( "Сохранить изменения?" ) ) {
        const fieldName = e.target.getAttribute( "data-field-name" ) ;
        const url = "/Java_WebBasics_war_exploded/register/?" + fieldName + "=" + e.target.innerText ;
        // console.log( url ) ; return ;
        fetch( url, {
          method: "PUT",
          headers: {
          },
          body: ""
        }).then( r => r.text() )
                .then( t => {
                  // OK / error
                  console.log(t)
                  if( t === "OK" ) {
                    location = location ;
                  }
                  else {
                    alert( t ) ;
                    e.target.innerText = e.target.savedText ;
                  }
                } ) ;
      }
      else {
        e.target.innerText = e.target.savedText ;
      }
    }
  }


</script>