/*phone状态下点击navBars按钮展开导航菜单*/
var navBars = $('#navBars');                        // 获取navBars容器
var navbarContent = $('#navbarContent');            // 获取navbar容器

navBars.click(function(){
    navbarContent.toggleClass('navbar-content-hidden');
})