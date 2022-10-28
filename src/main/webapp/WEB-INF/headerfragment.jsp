<%@ page contentType="text/html;charset=UTF-8" %><%
    String home = request.getContextPath() ;
%>

<div>
    <jsp:include page="/WEB-INF/authfragment.jsp" />
    <a class="waves-effect waves-light btn" href="registration" >Регистрация</a>
</div>