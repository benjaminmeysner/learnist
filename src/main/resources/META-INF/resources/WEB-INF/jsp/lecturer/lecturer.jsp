<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <c:set var="title" scope="application" value="Details | ${user.getUsername()}"/>
    <jsp:include page="../includes/head.jsp"/>
    <!-- Add css here -->
    <link rel="stylesheet" href="<c:url value="/public/css/basic.css" />">
</head>
<body>
<jsp:include page="../includes/nav.jsp"/>
<div id="main">

    <main class="col-sm-9 col-md-10 ml-auto">
        <h1>Dashboard</h1>
    </main>
</div>
<jsp:include page="../includes/scripts.jsp"/>
<!-- Add javascript here -->
</body>
</html>