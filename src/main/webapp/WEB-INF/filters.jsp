<%@ page contentType="text/html;charset=UTF-8"%><%
    String fromDemoFilter = (String) request.getAttribute( "DemoFilter" );
    //System.out.println( "JSP" );
    //List<String> users = (List<String>) request.getAttribute("users");
    String[] users = (String[]) request.getAttribute("users");
%>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Filters</title>
</head>
<body>
    <h1>Сервлетные фильтры</h1>
<p>
    Фильтры (веб-фильтры, сервлеты фильтры) - сервлеты (классы для сетевых задач),
    предназначенные для реализации концепции MiddleWare: конвейерной обработки запросов
    (и ответа).
</p>
<p>
    Для создания (добавления MiddleWare) необходимо:
        - Создать класс, реализующий javax.servlet.Filter
        - Три случая появления за событиями жизненного цикла фильтра
            = init - создание (настройка) фильтра. Здесь встречается ссылка на конфигурацию
                FilterConfig, этот посилань желательно сохранить. Через нее можно получить сведения об окружении запуска
                (файловые пути и т.п.)
            = doFilter - работа фильтра, среди параметров, относящихся к цепочке следующих фильтров
                filterChain. Фильтр может прервать исключительную обработку, если не оспаривается продолжение цепочки, либо
                продолжить filterChain.doFilter(...). Код, который находится в filterChain.doFilter стоящий на "прямую"
                пути запроса; после - на "обратном"
            = destroy - разрушение фильтра.
        - Зарегестрировать фильтр:Либо аннотацией, либо в web.xml. Рекомендуется - web.xml так как при помощи
            аннотаций неудобно указывать порядок выполнения фильтров.

</p>
<p>

    <% if(fromDemoFilter == null){%>
    <i>Запос не проходил через DemoFilter</i>
    <% } else { %>
    <i>DemoFilter передал данные <b><%=fromDemoFilter%></b></i>
    <% } %>
</p>
<p>
    Инфомация от БД: <%= request.getAttribute("viewInfo") %>
</p>

<% for(String user:users) {%>
<span><%=user%></span><br/>
<%}%>

</body>
</html>
