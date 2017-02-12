var wHeight = 0;                                        // 定义窗口高度全局变量
var wWidth = 0;                                         // 定义窗口宽度全局变量
var mainHeader = $('#mainHeader');                 // 获取头部Header容器
var mainMenu = $('#mainMenu > li');                   // 获取导航条菜单ul
var containerSection = $('#contentSection').find('.section')   // 获取面板容器下的所有为.section的后代
var scrollDown = $('#scrollDown');                  // 获取banner内的scrolldown按钮
var headerHeight = 0;             // Header高度
var scrollTimer = null;
var resizeTimer = null;


$(window).resize(function () {
    /*resize事件优化*/
    if (resizeTimer) {
        clearTimeout(resizeTimer)
    }
    resizeTimer = setTimeout(function(){
        // console.log("window resize");
        windowResize();
    }, 200);
});

/*owl轮播图插件*/
$(".owl-carousel").owlCarousel({
    items: 1,
    loop: true,
    autoplay: 200,
    lazyLoad: true,
    dots: false
});
/*非低版本IE运行canvas-colorfly*/
if( !(isIE( ["9.0", "8.0", "7.0", "6.0" ] )) ){
    $("#colorfly").colorFly({
        num: 14,
        size: 10,
        colors: ["#f5c152", "#e6611b", "#5cd2ad"]
    });
}

/*滚动条滚动时*/
$(window).scroll(function(){                        // 导航条滚动事件
    /*scroll事件优化*/
    if (scrollTimer) {
        clearTimeout(scrollTimer);
    }
    scrollTimer = setTimeout(function(){
        var dHeight = $(document).height();                 // 取得页面高度
        var sTop = $(document).scrollTop();             // 取得滚动条高度
        // console.log(sTop + wHeight + 'X' + (dHeight - 100));
        /*导航条滚动后移动到窗口顶部（判断窗口大小是否超过PHONE）*/
        if( wWidth > 768){
            mainHeader.toggleClass('scrolled', sTop > 0);
        }
        /*导航条根据滚动条位置改变样式*/
        mainMenu.each(function (i) {
            var topNum = 50;                            // 预设：提早50距离激活导航条上的class样式
            var hometopNum = 0;                         // 预设：HOME首页高度
            /*判断是HOME还是其它导航*/
            if( i == 0 ){
                $(mainMenu[i]).toggleClass('active', sTop >= hometopNum && sTop < $(containerSection[i]).offset().top-topNum);
            }else if( i < containerSection.length ){
                $(mainMenu[i]).toggleClass('active', sTop > $(containerSection[i-1]).offset().top-topNum && sTop < $(containerSection[i]).offset().top-topNum);  //滚动条高度必须大于section高度且小于下一个section的高度
            }else if( sTop + wHeight >= dHeight - 50 ){  //没触底前会先计算最后一个判断，如果高度能达到最后一个面板就会激活active -50是防止意外
                $(mainMenu[mainMenu.length-2]).removeClass('active');   //如果滚动条触底则删除倒数第二个nav的active
                $(mainMenu[mainMenu.length-1]).toggleClass('active', (sTop + wHeight) >= (dHeight - 50) );   //滚动条触底，给最后一个nav添加active，滚动高度+窗口大小 = 页面高度, -50是防止意外
            }else{
                $(mainMenu[i]).toggleClass('active', sTop > $(containerSection[containerSection.length-1]).offset().top-topNum); //如果高度能达到最后一个面板就会激活active
            }
        });
    }, 120);
})

/*点击a标签判断是否需要跳转锚点+锚点过渡动画-方法3*/
/*该方法修复了方法2，因为有不明href值造成的JS保错导致滑动失效*/
/*使用方法：需要a标签的href值对应锚点目标的id值，例：<a href="#test"> <div id="test">*/
$('a.top-link').click(function () {
    var navhref = $(this).attr('href').match(/#\b[\w[^-]*]*/)[0];                           //正则匹配#号后的字符
    $('html,body').stop();                                                                  //停止动画防止重复点击
    $('html,body').animate({
        scrollTop: $(navhref).offset().top - headerHeight              //设置animate动画：滚动条滚动到对应id容器的高度
    }, {
        duration: 500,                                                              //时间
        easing: "swing"                                                             //动画曲线
    });
    return false;                                                                   //取消a标签的默认点击事件修复“闪屏”，禁止冒泡
})

/*点击banner按钮跳转锚点过渡动画*/
scrollDown.click(function () {
    var scrolldownTarget = $(containerSection[0]);
    $('html,body').stop();
    $('html,body').animate({
        scrollTop: scrolldownTarget.offset().top - headerHeight                     //设置animate动画：滚动条滚动到section的高度
    }, 1000);
    return false;                                                                               //取消a标签的默认点击事件修复“闪屏”，禁止冒泡
})

/*窗口改变时，将窗口大小输出给全局变量wHeight*/
function windowResize() {
    wHeight = $(window).height();               // 取得浏览器窗口高度
    wWidth = $(window).width();                 // 取得浏览器窗口宽度
    if( wHeight > 440 ){                     //设置一个最小高度
        $('#siteBanner').height(wHeight);         // banner-canvas满屏高度控制
    }
}
/*初始化*/
windowResize();