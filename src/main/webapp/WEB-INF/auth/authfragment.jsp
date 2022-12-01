<%@ page import="step.learning.entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" %><%
    String authError = (String) request.getAttribute( "AuthError" ) ;
    User authUser = (User) request.getAttribute( "AuthUser" ) ;
    String home = request.getContextPath() ;
%>

<div class="row" style="width: 60%; margin-top: 6%">
    <div class="card" style="padding: 20px; width: 60% ; text-align: center; margin: 0 auto;">
        <h2 style=" margin: 10px 0">Authorization</h2>
        <div>
            <% if( authUser == null ) { %>
            <form method="POST" action="">

                <div style="width: 80%; margin: 0 auto;">
                    <!-- Login -->
                    <div class="row">
                        <div class="input-field">
                            <input name="Login" id="log" type="text" class="validate" >
                            <label for="log">Login</label>
                        </div>
                    </div>
                    <!-- Password -->
                    <div class="row">
                        <div class="input-field">
                            <input name="Password" id="pass1" type="password" class="validate" >
                            <label for="pass1">Password</label>
                        </div>
                    </div>
                </div>

                <!-- Button -->
                <div class="row">
                     <a href="<%=home%>" type="submit" class="btn btn-primary" >Cancel</a>
                     <input type="hidden" name="form-id" value="auth-form" />
                     <button class="waves-effect waves-light btn" >Login</button>
                </div>
            </form>
            <% if( authError != null ) { %>
            <span class="auth-error"><%= authError %></span>
            <% } } else { %>
            <span>Hello, </span>
            <b><%= authUser.getName() %></b>
            <a href="<%=home%>/profile" class="auth-profile-a">
                <img class="auth-fragment-avatar"
                     src="<%=home%>/image/<%=authUser.getAvatar()%>"
                     alt="<%=authUser.getLogin()%>" />
            </a>
            <%-- region Если почта требует подтверждения, то выводим ссылку --%>
                <% if( authUser.getEmailCode() != null ) { %>
                <a href="<%=home%>/checkmail/"
                title="Почта не подтверждена, перейти на страницу подтверждения">&#x1F4E7;</a>
                <% } %>
            <%-- endregion --%>
            <a href="?logout=true">Log out</a>
            <% } %>
        </div>
    </div>
</div>