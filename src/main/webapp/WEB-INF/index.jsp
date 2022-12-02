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

<body style="height: 100vh; line-height: 1.5;">
<div style="min-height: 100%; display: flex; flex-direction: column">
    <jsp:include page="/WEB-INF/head/headerfragment.jsp"/>
    <div style="flex:1 1 auto">
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
    </div>
    <div style="text-align: center">
        <jsp:include page="footer/footer.jsp"/>
    </div>

</div>

</body>
</html>
