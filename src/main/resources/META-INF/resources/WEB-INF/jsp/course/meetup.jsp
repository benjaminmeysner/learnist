<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<c:set var="title" scope="application" value="Meetup"/>
		<jsp:include page="../includes/head.jsp"/>
		<!-- Add css here -->
		<link rel="stylesheet" href="https://unpkg.com/leaflet@1.0.3/dist/leaflet.css"
		      integrity="sha512-07I2e+7D8p6he1SIM+1twR5TIrhUQn9+I6yjqD53JQjFiMf8EtC93ty0/5vJTZGF8aAocvHYNEDJajGdNx1IsQ=="
		      crossorigin=""/>
		<link href='https://api.mapbox.com/mapbox-gl-js/v0.36.0/mapbox-gl.css' rel='stylesheet' />
		<link rel="stylesheet" href="/public/css/route.css"/>
		<link rel="stylesheet" href="<c:url value="/public/css/basic.css" />">
	</head>
	<body>
		<jsp:include page="../includes/nav.jsp"/>
		<div id="main">
			<div id="map"></div>
		</div>
		<script src="https://unpkg.com/leaflet@1.0.3/dist/leaflet.js"
		        integrity="sha512-A7vV8IFfih/D732iSSKi20u/ooOfj/AGehOKq0f4vLT1Zr2Y+RX7C+w8A1gaSasGtRUZpF/NZgzSAu4/Gc41Lg=="
		        crossorigin=""></script>
		<%--<script src='https://api.mapbox.com/mapbox-gl-js/v0.36.0/mapbox-gl.js'></script>--%>
		<script>
            var street1 = '${viewMeetup.getLocation().getStreet_address()}';
            var postcode1 = '${viewMeetup.getLocation().getPostalcode()}';
            var street2 = '${user.getAddress().getStreet_address()}';
            var postcode2 = '${user.getAddress().getPostalcode()}';
            var meetupMessage = '${viewMeetup.getCourse().getName()} meetup at ${viewMeetup.getLocalDate()}';
            var courseCode = '${viewMeetup.getCourse().getCode()}';
            var key = 'AIzaSyBOeADi22yGnTeBsqHLB3l0vpKy8aEaJHo';
            var address1 = street1 + ',' + postcode1;
            var address2 = street2 + ',' + postcode2;
            var api1 = 'https://maps.googleapis.com/maps/api/geocode/json?address='+address1.replace(/ /g,'+')+'&'+key;
            var api2 = 'https://maps.googleapis.com/maps/api/geocode/json?address='+address2.replace(/ /g,'+')+'&'+key;
            var coords;
            $.get(api1, function (data) {
                coords = data.results[0].geometry.location;
                var map = L.map('map').setView([coords.lat, coords.lng], 13);
                L.tileLayer('https://api.mapbox.com/styles/v1/mapbox/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
                    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
                    maxZoom: 24,
                    id: 'streets-v9',
                    accessToken: 'pk.eyJ1IjoiZXJ1c3R1c2FndXR1IiwiYSI6ImNqMjVrbHhiZTAwM2szM29qMDJ5dGc4ZGIifQ.JOq5Qu6LkYZOL2x8K8xRaw'
                }).addTo(map);
                var marker = L.marker([coords.lat, coords.lng]).addTo(map);
                marker.bindPopup(meetupMessage+'<a class="btn btn-sm btn-success" href="/course/'+courseCode+'">Back to Course</a>').openPopup();
                if(street2){
                    $.get(api2, function (data) {
                        var coords2 = data.results[0].geometry.location;
                        L.Routing.control({
                            waypoints: [
                                L.latLng(coords2.lat, coords2.lng),
                                L.latLng(coords.lat, coords.lng)
                            ],
                            routeWhileDragging: true
                        }).addTo(map);
                        map.fitBounds([
                            [coords.lat, coords.lng],
                            [coords2.lat, coords2.lng]
                        ]);
                    });
                }
            });
		</script>
		<script src="/public/js/route.js"></script>
		<jsp:include page="../includes/scripts.jsp"/>
		<!-- Add javascript here -->
	</body>
</html>