<%@ page import="step.learning.entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" %><%
  User authUser = (User) request.getAttribute( "AuthUser" ) ;
  String home = request.getContextPath() ;
%>
  <div class="row"  style=" width:50%; margin: 0 auto">
      <div class="card-panel">
        <div style="text-align: center">
          <h3>Кабинет пользователя</h3>
        </div>
        <div class="row">
          <div class="col s5">
            <img class="profile-avatar"
                 <%if (authUser.getAvatar() != null){%>
                 src="<%=home%>/img/<%=authUser.getAvatar()%>"
                 <%}else{%>
                 src="<%=home%>/img/16480.png"
                 <%}%>
                 alt="<%=authUser.getLogin()%>" style="width: 200px; height: 200px"/>
            <p style="font-size: 10px">Id: <b data-field-name="id"><%= authUser.getId() %></b></p>
          </div>
          <div class="col s7">
            <h5 class="profile-name">
              <span>Имя: </span> <b data-field-name="name"><%= authUser.getName() %></b>
            </h5>
            <h5 class="profile-name">
              <span>Логин: </span> <b data-field-name="login"><%= authUser.getLogin() %></b>
            </h5>
            <p class="profile-fieldset-avatar">
            <form action="#">
              <div class="file-field input-field">
                <div class="waves-effect waves-light btn">
                  <span>Картинка:</span>
                  <input type="file" id="avatar-input" alt="avatar-input" />
                </div>
                <div class="file-path-wrapper">
                  <input class="file-path validate" id="avatar-save-button" alt="avatar-input" type="text" placeholder="Upload files">
                </div>
              </div>
            </form>
            </p>
          </div>
        </div>
        <div class="row">
          <div class="col s6">
            <%--Вернуться на главную--%>
            <a href="<%=home%>" type="submit" class="btn btn-primary" >Back</a>
          </div>
          <div class="col s6" >
            <%--Выйти из аккаунта--%>
            <a href="?logout=true" class="btn btn-primary">Log out</a>
          </div>
        </div>
  </div>


<script>
  document.addEventListener( "DOMContentLoaded", () => {
    const avatarSaveButton = document.querySelector( "#avatar-save-button" ) ;
    if( ! avatarSaveButton ) throw "'#avatar-save-button' not found" ;
    avatarSaveButton.addEventListener( 'click', avatarSaveClick ) ;
    for( let nameElement of document.querySelectorAll( ".profile-name b" ) ){
      nameElement.addEventListener( "click", nameClick ) ;
      nameElement.addEventListener( "blur", nameBlur ) ;
      nameElement.addEventListener( "keydown", nameKeydown ) ;
    }
  });
  function avatarSaveClick() {
    const avatarInput = document.querySelector( "#avatar-input" ) ;
    if( ! avatarInput ) throw "'#avatar-input' not found" ;
    if( avatarInput.files.length === 0 ) {
      alert( "select a file" ) ;
      return ;
    }
    let formData = new FormData() ;
    formData.append( "userAvatar", avatarInput.files[0] ) ;
    fetch( "/WebBasics/register/", {
      method: "PUT",
      headers: { },
      body: formData  // наличие файла в formData автоматически сформирует multipart запрос
    }).then( r => r.text() )
            .then( t => {
              console.log(t);
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