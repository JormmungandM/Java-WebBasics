<%@ page contentType="text/html;charset=UTF-8" %><%
    String pageBody = "/WEB-INF/" + request.getAttribute( "pageBody" ) ;
    String home = request.getContextPath() ;
%>
<!doctype html >
<html>
<head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="<%=home%>/css/style.css">
    <!-- https://materializecss.com/ -->
    <!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <!-- Compiled and minified JavaScript -->
   <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

   <title>JSP</title>
</head>
<body>

<jsp:include page="head/headerfragment.jsp"/>

<div style="margin-top: 6%">
    <jsp:include page="<%=pageBody%>" />
</div>


<div style="text-align: center; ">
    <jsp:include page="footer/footer.jsp"/>
</div>

</body>
</html>