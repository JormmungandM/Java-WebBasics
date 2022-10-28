<%@ page import="step.learning.entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" %><%
    String authError = (String) request.getAttribute( "AuthError" ) ;
    User authUser = (User) request.getAttribute( "AuthUser" ) ;
    String home = request.getContextPath() ;
%>

<div class = "auth-fragment">
    <% if( authUser == null ) { %>
    <form method="POST" action="">

        <div class="row">
            <!-- Login -->
            <div class="input-field col s3">
                <input name="userLogin" id="log" type="text" class="validate" >
                <label for="log">Login</label>
            </div>
            <!-- Password -->
            <div class="input-field col s3">
                <input name="userPassword" id="pass1" type="password" class="validate" >
                <label for="pass1">Password</label>
            </div>
            <!-- Button -->
            <div class="col s1" style="margin-top:1.2em">
                <button class="waves-effect waves-light btn" >Enter</button>
            </div>
        </div>
    </form>
    <% if( authError != null ) { %>
        <span class="auth-error"><%= authError %></span>
        <% } } else { %>
        <span>Hello, </span>
        <b><%= authUser.getName() %></b>
        <a href="<%=home%>/profile" class="auth-profile-a"><img class="auth-fragment-avatar"
                                                                src="<%=home%>/image/<%=authUser.getAvatar()%>"
                                                                alt="<%=authUser.getLogin()%>" /></a>

        <a href="?logout=true">Log out</a>
    <% } %>
</div>