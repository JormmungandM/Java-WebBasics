<%@ page contentType="text/html;charset=UTF-8" %>
<%
//    String[] langs = new String[] { "uk", "en", "ru", "java" } ;

    String home = request.getContextPath() ;
    String count = (String) request.getAttribute("count");
    String[] elements = (String[]) request.getAttribute("elements");
    String MD5 = (String) request.getAttribute("HashInputMD5");
    String Sha1 = (String) request.getAttribute("HashInputSha1");
%>
<!doctype html >

<html>
<head>
    <meta charset="UTF-8" />
    <title>JSP basics</title>
    <link rel="stylesheet" href="<%=home%>/css/style.css">

    <!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</head>

<body>

<jsp:include page="/WEB-INF/head/headerfragment.jsp"/>

<div>
    <h4>Navigation</h4>
    <a href="<%=home%>/filters">Веб-фильтры</a>
    <br/>
    <a href="<%=home%>/guice.jsp">Инверсия управления</a>
    <br/>
</div>

<%--<img src="<%=home%>/img/maxresdefault.jpg" style="width: 600px; height: 400px"/>--%>
<!--
<p>
    Суть JSP - "смешивание" возможностей Java и HTML.
    &lt;% ... %&gt; - контейнер для Java кода,
<%--    <% int x = 10 ; %>--%>
<%--    &lt;%= ... %&gt; - выражение (вывод результата)--%>
<%--    x = <%= x %>--%>
</p>


<%--<jsp:include page="fragment.jsp"/>--%>
<br/>

Условная верстка
<%--<% if(x < 10) { %>--%>
<%--<b> x < 10 </b>--%>
<%--<% } else { %>--%>
<%--<i> x >= 10 </i>--%>
<%--<% } %>--%>
<br/>

Циклы и обработка массивов
<%--<% String[] arr = new String[] { "Some", "Words", "in", "array" } ; %>--%>
<%--<h3>Содержимое массива: </h3>--%>
<%--<% for( String str : arr ) { %>--%>
<%--<b><%= str %></b><br/>--%>
<%--<% } %>--%>
<br/>

<b>Select language: </b>
<form>
<%--    <% for(String lang: langs) { %>--%>
<%--    <input type="radio" name="lang" id="lang-<%= lang%>"/>--%>
<%--    <label for="lang-<%= lang%>"><%= lang%></label>--%>
<%--    <% } %>--%>
</form>
-->

<div>
    <h4>DB Table</h4>
    DB:  <%= count %><br/><br/>
    <%-- <% for(String element:elements) {%>
        <span><%=element%></span><br/>
        <%}%> --%>
</div>
<form method="post" action="" style="width: 30%; text-align: left">
    <div class="row" >
        <div class="input-field col s12">
            <input name="HashInput" id="Hash" type="text" class="validate" >
            <label for="Hash">Hash</label>
        </div>
        <button class="waves-effect waves-light btn" >Hash</button>
    </div>
</form>

<%if(MD5 != null || Sha1 !=null){%>
<div>
    <p>
        Hash MD5: <%=MD5%>
    </p>
    <p>
        Hash Sha1: <%=Sha1%>
    </p>
</div>
<%}%>
<div style="text-align: center">
    <jsp:include page="footer/footer.jsp"/>
</div>

</body>
</html>
