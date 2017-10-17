<!DOCTYPE HTML>
<meta name="viewport" content="width=device-width, initial-scale=1">
<html lang="en">
	<style type="text/css">
		body{
			padding: 20px;
			text-align: center;
		}
		div{
			margin: auto;
			width: 50%;
			border-radius: 10px;
			padding: 10px 0 10px 0;
		}
	</style>
	<head>
	 	<meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<title>Spring MVC Exception</title>
        <link rel="stylesheet" media="screen" href="/webjars/bootstrap/4.0.0-alpha.5/css/bootstrap.min.css">
	</head>
	<body>
		<div class="bg-danger">
			<h2>Spring MVC Exception Handling</h2>
			<h3 class="bg-danger">${exception.getExceptionMsg()}</h3>
			<a href="/" class="btn btn-default">Home</a>
		</div>
	</body>
</html>