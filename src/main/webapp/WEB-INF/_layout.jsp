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
<body style="height: 100vh; line-height: 1.5;">

<div style="min-height: 100%; display: flex; flex-direction: column">
    <jsp:include page="head/headerfragment.jsp"/>

    <div style="flex:1 1 auto">
        <jsp:include page="<%=pageBody%>" />
    </div>

    <div style="text-align: center; ">
        <jsp:include page="footer/footer.jsp"/>
    </div>
</div>


<scrip type="text/javascript" src="js/materialize.min.js"></scrip>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        let elems = document.querySelectorAll('.modal');
        let instances = M.Modal.init(elems, {opacity:0.2});
    });
</script>
</body>
</html>