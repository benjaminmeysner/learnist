<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="adminContainer">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="/administrator/dashboard">Home</a></li>
        <li class="breadcrumb-item"><a href="/administrator">Administrator</a></li>
        <li class="breadcrumb-item active">Analytics</li>
    </ol>
    <div class="container-fluid mt-1 px-0 px-sm-3">
        <div id="ui-view">
            <div style="display: none;" id="embed-api-auth-container"></div>
            <div id="chart-container"></div>
            <div id="entrance-container"></div>
            <div id="view-selector-container"></div>
            <div id="breakdown-chart-container"></div>
            <div id="chart-1-container"></div>
        </div>
    </div>
</div>