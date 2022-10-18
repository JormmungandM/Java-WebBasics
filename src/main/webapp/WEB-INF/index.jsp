<%@ page contentType="text/html;charset=UTF-8" %>
<%
//    String[] langs = new String[] { "uk", "en", "ru", "java" } ;

    String home = "/Java_WebBasics_war_exploded" ;
    String count = (String) request.getAttribute("count");
    String[] elements = (String[]) request.getAttribute("elements");
%>
<!doctype html >

<html>

<head>
    <meta charset="UTF-8" />
    <title>JSP basics</title>
    <style>
        input[type=radio] {
            visibility: hidden;
        }
        input[type=radio]:checked + label {
            border: 1px solid salmon;
            font-weight: bold;
        }
        label {
            cursor: pointer;
            font-size: larger;
            font-variant: all-petite-caps;
        }
    </style>
</head>

<body>
<h2>JSP - Java Server Pages</h2>
<div>
    <h4>Navigation</h4>
    <a href="filters">Веб-фильтры</a>
    <br/>
    <a href="../guice.jsp">Инверсия управления</a>
    <br/>
    <jsp:include page="footer.jsp"/>
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
    <% for(String element:elements) {%>
    <span><%=element%></span><br/>
    <%}%>
</div>


</body>
</html>
