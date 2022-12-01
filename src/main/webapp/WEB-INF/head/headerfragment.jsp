<%@ page import="step.learning.entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" %><%
    User authUser = (User) request.getAttribute( "AuthUser" ) ;
    String home = request.getContextPath() ;
%>

<div>
    <nav>
        <div class="nav-wrapper">
            <a href="<%=home%>" class="brand-logo" style="margin-left: 10px">JSP - Java Server Page</a>
            <ul class="right hide-on-med-and-down">

                <%--Если пользователь авторизован выключаем регистрацию и включаем посты--%>
                <%if (authUser == null){%>
                <li>
                    <a href="<%=home%>/register/">
                        Registration
                    </a>
                </li>
                <%} else { %>
                <li>
                    <a href="<%=home%>/user-posts/">
                        Posts
                    </a>
                </li>
                <%}%>

                <li>
                    <a href="<%=home%>/profile">
                    <%--Если пользователь авторизован меняем текст логин на профиль--%>
                        <%if (authUser == null){%>
                            Login
                        <%}else {%>
                            Profile
                        <%}%>
                    </a>
                </li>

            </ul>
        </div>
    </nav>
</div>