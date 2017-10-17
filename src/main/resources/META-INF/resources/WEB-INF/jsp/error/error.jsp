<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Learnist | ${message}</title>
    <link rel="apple-touch-icon" sizes="57x57" href="public/images/icons/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="public/images/icons/apple-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="public/images/icons/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="public/images/icons/apple-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="public/images/icons/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="public/images/icons/apple-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="public/images/icons/apple-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="public/images/icons/apple-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="public/images/icons/apple-icon-180x180.png">
    <link rel="icon" type="image/png" sizes="32x32" href="public/images/icons/favicon-32x32.png">
    <link rel="manifest" href="public/images/icons/manifest.json">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="msapplication-TileImage" content="/public/images/icons/ms-icon-144x144.png">
    <meta name="theme-color" content="#ffffff">
    <style>
        body {
            height: 100vh;
            display: flex;
            background-color: #aaa;
            text-align: center;
            justify-content: center;
            align-items: center;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }
        div {
            background-color: rgb(236, 238, 239);
            border-radius: .3rem;
            box-sizing: border-box;
            color: rgb(55, 58, 60);
            display: block;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            font-size: 16px;
            line-height: 24px;
            margin-bottom: 32px;
            padding: 2rem 1rem;
            text-align: center;
            -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
        }
        @media (min-width: 576px) {
            div {
                padding: 4rem 2rem;
            }
        }
        h1 {
            font-size: 2em;
            font-weight: 500;
            line-height: 1.1;
            margin-top: 0;
            margin-bottom: .5rem;
            box-sizing: border-box;
            color: rgb(55, 58, 60);
            display: block;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            -webkit-margin-after: 8px;
            -webkit-margin-before: 0;
            -webkit-margin-end: 0;
            -webkit-margin-start: 0;
            -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
        }

        a {
            display: inline-block;
            line-height: 1.25;
            color: #fff;
            background-color: #0275d8;
            text-decoration: none;
            user-select: none;
            border: 1px solid #0275d8;
            padding: .5rem 1rem;
            font-size: 1rem;
            border-radius: .25rem;
        }
    </style>
</head>
<body>
<div>
    <h1>${message}</h1>
    <a href="/">Back to Home</a>
</div>
</body>
</html>
