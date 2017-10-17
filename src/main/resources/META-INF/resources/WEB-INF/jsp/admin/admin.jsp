<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="">
		<meta name="author" content="">
		<title>${title}</title>
		<!-- Links -->
		<link rel="apple-touch-icon" sizes="57x57" href="public/images/icons/apple-icon-57x57.png">
		<link rel="apple-touch-icon" sizes="60x60" href="public/images/icons/apple-icon-60x60.png">
		<link rel="apple-touch-icon" sizes="72x72" href="public/images/icons/apple-icon-72x72.png">
		<link rel="apple-touch-icon" sizes="76x76" href="public/images/icons/apple-icon-76x76.png">
		<link rel="apple-touch-icon" sizes="114x114" href="/public/images/icons/apple-icon-114x114.png">
		<link rel="apple-touch-icon" sizes="120x120" href="/public/images/icons/apple-icon-120x120.png">
		<link rel="apple-touch-icon" sizes="144x144" href="/public/images/icons/apple-icon-144x144.png">
		<link rel="apple-touch-icon" sizes="152x152" href="/public/images/icons/apple-icon-152x152.png">
		<link rel="apple-touch-icon" sizes="180x180" href="/public/images/icons/apple-icon-180x180.png">
		<link rel="icon" type="image/png" sizes="192x192" href="/android-icon-192x192.png">
		<link rel="icon" type="image/png" sizes="32x32" href="/public/images/icons/favicon-32x32.png">
		<link rel="icon" type="image/png" sizes="96x96" href="/public/images/icons/favicon-96x96.png">
		<link rel="icon" type="image/png" sizes="16x16" href="/public/images/icons/favicon-16x16.png">
		<link rel="manifest" href="/public/images/icons/manifest.json">
		<meta name="msapplication-TileColor" content="#ffffff">
		<meta name="msapplication-TileImage" content="/public/images/icons/ms-icon-144x144.png">
		<meta name="theme-color" content="#ffffff">
		<!-- Bootstrap Core CSS -->
		<!-- Icons -->
		<link href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.4.1/css/simple-line-icons.min.css" rel="stylesheet">
		<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
		<script>
            (function(w,d,s,g,js,fs){
                g=w.gapi||(w.gapi={});g.analytics={q:[],ready:function(f){this.q.push(f);}};
                js=d.createElement(s);fs=d.getElementsByTagName(s)[0];
                js.src='https://apis.google.com/js/platform.js';
                fs.parentNode.insertBefore(js,fs);js.onload=function(){g.load('analytics');};
            }(window,document,'script'));
		</script>
		<!-- Main styles for this application -->
		<link href="/public/css/admin.css" rel="stylesheet">
	</head>
	<body class="app header-fixed sidebar-fixed aside-menu-fixed aside-menu-hidden">
		<header class="app-header navbar">
			<button class="navbar-toggler mobile-sidebar-toggler hidden-lg-up" type="button">☰</button>
			<a class="navbar-brand" href="/"></a>
			<ul class="nav navbar-nav hidden-md-down">
				<li class="nav-item">
					<a class="navbar-link navbar-toggler sidebar-toggler" href="#">☰</a>
				</li>
				<li class="nav-title pl-3">Welcome ${user.username}</li>
			</ul>
			<ul class="nav navbar-nav ml-auto hidden-md-down">
				<li class="nav-item px-1">
					<a class="nav-link nav-page" href="#">
						<i class="fa fa-envelope-o"></i> Messages<span class="badge badge-success">42</span>
					</a>
				</li>
				<li class="nav-item px-1">
					<form:form id="logoutForm" action="/logout" method="post">
						<a href="#" onclick="document.getElementById('logoutForm').submit();" class="btn btn-primary"><i class="fa fa-sign-out"></i> Logout</a>
					</form:form>
				</li>
			</ul>
		</header>
		<div class="app-body">
			<div class="sidebar">
				<nav class="sidebar-nav">
					<form:form id="navForm">
						<ul class="nav">
							<li class="nav-item">
								<a class="nav-link nav-page" href="/administrator/dashboard"><i class="icon-speedometer"></i> Dashboard</a>
							</li>
							<li class="nav-item">
								<a class="nav-link nav-page" href="/administrator/analytics"><i class="icon-chart"></i> Analytics</a>
							</li>
							<li class="nav-title">${user.username}</li>
							<li class="nav-item">
								<a class="nav-link nav-page" href="/administrator/details" target="_top"><i class="icon-info"></i> Details</a>
							</li>
							<li class="nav-item">
								<a class="nav-link nav-page" href="/administrator/preferences" target="_top"><i class="fa fa-cog"></i> Preferences</a>
							</li>
							<li class="nav-item hidden-md-up">
								<a class="nav-link nav-page" href="#">
									<i class="fa fa-envelope-o"></i> Messages<span class="badge badge-success">42</span>
								</a>
							</li>
							<li class="nav-title">Tools</li>
							<li class="nav-item nav-dropdown">
								<a class="nav-link nav-dropdown-toggle" href="#"><i class="fa fa-users"></i>Users</a>
								<ul class="nav-dropdown-items">
									<li class="nav-item">
										<a class="nav-link nav-page" href="/administrator/users/administrators" target="_top"> Administrators</a>
									</li>
									<li class="nav-item">
										<a class="nav-link nav-page" href="/administrator/users/learners" target="_top"> Learners</a>
									</li>
									<li class="nav-item nav-dropdown">
										<a class="nav-link nav-page" href="/administrator/users/lecturers" target="_top"> Lecturers</a>
									</li>
								</ul>
							</li>
							<li class="nav-item">
								<a class="nav-link nav-page" href="/administrator/courses" target="_top"><i class="fa fa-graduation-cap"></i> Courses</a>
							</li>
						</ul>
					</form:form>
					<ul class="nav hidden-md-up">
						<li class="nav-item">
							<form:form id="logoutForm" action="/logout" method="post">
								<button type="submit" class="nav-link b-a-0"><i class="fa fa-sign-out"></i> Logout</button>
							</form:form>
						</li>
					</ul>
				</nav>
			</div>
			<!-- Main content -->
			<main class="main">
				<div id="pageLoader" class="p-4 m-4" style="height: 100%;display: flex;justify-content: center;align-items: center;
">
					<div class="loader"></div>
				</div>
				<div id="main">
					<jsp:include page="${page}.jsp"/>
				</div>
			</main>
		</div>
		<footer class="app-footer">
			<a href="http://coreui.io">CoreUI</a> &copy; 2017 creativeLabs.
			<span class="float-right">Powered by <a href="http://coreui.io">CoreUI</a>
        </span>
		</footer>
		<!-- Bootstrap and necessary plugins -->
		<script src="/webjars/pace/1.0.2/pace.min.js"></script>
		<!-- GenesisUI main scripts -->
		<script src="https://use.fontawesome.com/bf6125494d.js"></script>
		<jsp:include page="../includes/scripts.jsp"/>
		<script src="/public/js/admin.js"></script>
	</body>
</html>
