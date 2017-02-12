<!doctype html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <!--<title>Nooplus游戏加速</title>-->
    <!--<meta name="keywords" content="NOOPLUS,加速器,网游加速器">-->
    <!--<meta name="description" content="网游加速器">-->
    <title>{$config["appName"]}</title>
    <meta name="keywords" content="DEMO">
    <meta name="description" content="DEMO">

    <link rel="stylesheet" href="/theme/nooplus/css/base-3586c15928.css">

    <link rel="stylesheet" href="/theme/nooplus/css/main-1a3f97019d.css">

    <!--IE8 HTML5标签兼容JS-->
    <!--[if lt IE 9]>
    <script src="/theme/nooplus/plugins/html5.min.js"></script>
    <![endif]-->

</head>
<body>
<!--[if lte IE 8]>
<p class="browserupgrade">您的浏览器版本过低，请升级！</p>
<![endif]-->

<!--header-->
<div class="site-header">
    <header class="main-header" id="mainHeader">
        <div class="container">
            <div class="navbar-content clearfix" id="navbarContent">
                <div class="logo">
                    <a href="/#home" class="top-link">NOOPLUS</a>
                </div>
                {if $user->isLogin}
                <!--已登录-->
                <!--TPL预留-->
                <div class="logout-btn hide">
                    <a href="/user/logout"><i class="icon-exit"></i>注销</a>
                </div>
                <div class="panel-btn hide">
                    <a href="/user"><i class="icon-wrench"></i>我的账户</a>
                </div>
                {else}
                <div class="register-btn">
                    <a href="/auth/register"><i class="icon-user"></i>注册</a>
                </div>
                <div class="login-btn" id="loginBtn">
                    <a href="/auth/login"><i class="icon-enter"></i>登录</a>
                </div>
                {/if}
                <nav class="nav-main">
                    <ul id="mainMenu">
                        <li class="active"><a href="/#home" class="top-link">HOME</a></li>
                        <li><a href="/#service" class="top-link">服务</a></li>
                        <li><a href="/#game" class="top-link">支持游戏</a></li>
                        <li><a href="/#price" class="top-link">价格</a></li>
                        <li><a href="/#feedback" class="top-link">反馈</a></li>
                    </ul>
                </nav>
                <a class="hide nav-bars" id="navBars"><i class="icon-menu"></i></a>
            </div>
        </div>
    </header>
</div>