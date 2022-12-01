<%@ page import="step.learning.entities.Post" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
//    String[] langs = new String[] { "uk", "en", "ru", "java" } ;

    String home = request.getContextPath() ;
//    String count = (String) request.getAttribute("count");
//    String[] elements = (String[]) request.getAttribute("elements");
//    String MD5 = (String) request.getAttribute("HashInputMD5");
//    String Sha1 = (String) request.getAttribute("HashInputSha1");


    Post[] posts = (Post[]) request.getAttribute("posts");
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


<!--
1. id
2. user id
3. name
4. picture preview
5. content
6. data
-->

<% if (posts.length != 0) {%>
    <div class="row" style="width: 70%">
        <div class="col s2"></div>
        <div class="col s8" style="width: 100%">
            <h1>Posts</h1>
            <% for(Post post:posts) {%>
            <div class ="row" style="box-shadow: 0 0 15px rgba(0, 0, 0, .2); width: 100%">
                <div class="col s3" style="padding: 10px 10px">
                    <img
                        <%if (post.getPreview() != null){%>
                            src="<%=home%>/image/<%=post.getPreview()%>"
                        <%}else{%>
                            src="<%=home%>/image/NoImageVailable.png"
                        <%}%>

                         width="100%" height="100%" style="text-align: center" alt="">
                 </div>
                <div class="col s9">
                    <div class="row" style="padding: 10px; margin:0">
                        <div class ="col s9">
                            <h4 style="margin: 0 0"><%=post.getName()%></h4>
                        </div>
                        <div class ="col s3" >
                            <span style="color: gray; float:right"><%=post.getDate()%></span>
                        </div>
                    </div>
                    <div class="row" style="padding: 10px; margin:0">
                        <%=post.getContent()%>
                    </div>
                </div>
            </div>
            <%}%>
        </div>
        <div class="col s2"></div>
    </div>
<%}else {%>
    <h1>Posts not found</h1>
<%}%>

<!--
<%--<div>--%>
<%--    <h4>Navigation</h4>--%>
<%--    <a href="<%=home%>/filters">Веб-фильтры</a>--%>
<%--    <br/>--%>
<%--    <a href="<%=home%>/guice.jsp">Инверсия управления</a>--%>
<%--    <br/>--%>
<%--</div>--%>

<%--<img src="<%=home%>/img/maxresdefault.jpg" style="width: 600px; height: 400px"/>--%>
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

<%--<div>--%>
<%--    <h4>DB Table</h4>--%>
<%--    DB:  <%= count %><br/><br/>--%>
<%--    &lt;%&ndash; <% for(String element:elements) {%>--%>
<%--        <span><%=element%></span><br/>--%>
<%--        <%}%> &ndash;%&gt;--%>
<%--</div>--%>
<%--<form method="post" action="" style="width: 30%; text-align: left">--%>
<%--    <div class="row" >--%>
<%--        <div class="input-field col s12">--%>
<%--            <input name="HashInput" id="Hash" type="text" class="validate" >--%>
<%--            <label for="Hash">Hash</label>--%>
<%--        </div>--%>
<%--        <button class="waves-effect waves-light btn" >Hash</button>--%>
<%--    </div>--%>
<%--</form>--%>

<%--<%if(MD5 != null || Sha1 !=null){%>--%>
<%--<div>--%>
<%--    <p>--%>
<%--        Hash MD5: <%=MD5%>--%>
<%--    </p>--%>
<%--    <p>--%>
<%--        Hash Sha1: <%=Sha1%>--%>
<%--    </p>--%>
<%--</div>--%>
<%--<%}%>--%>
-->


<div style="text-align: center">
    <jsp:include page="footer/footer.jsp"/>
</div>

</body>
</html>
