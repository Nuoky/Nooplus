/*需要加载IsPC.js*/
/*card-avatar*/
// input失去焦点时获取Gravatar头像
$('#loginEmail').blur(function() {
    var reg = /^\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}$/;
    if(reg.test(this.value)){
        $('.card-avatar').find('img').attr('src', 'https://secure.gravatar.com/avatar/' + md5(this.value))
    }
});

/*card-tab-x2 + card-content*/
var cardTabx2 = $('.card-tab-x2').find('div');
var cardContent = $('.card-content');

cardContent.each(function () {
    if ( $(this).attr('show') == 'yes' ){
        $(this).show();
    }
})

cardTabx2.click(function () {
    var targetClass = '.' + $(this).attr('target');
    cardTabx2.removeClass('active');
    cardContent.hide();
    if( $(targetClass).css('display') == 'none' ){
        $(this).addClass('active');
        $(targetClass).show();
    }
})


/*初始化*/
mobileCardHeight();

/*点击TAB时运行mobileCardHeight*/
/*cardTabx2在card.js中定义了*/
cardTabx2.click(function () {
    mobileCardHeight();
});

/*移动端上登陆面板高度小于浏览器窗口高度时增加padding值填满屏幕*/
function mobileCardHeight() {
    if( !IsPC( [ "Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod" ] ) ){
        var wHeight = $(window).height();
        var card = $('#cardMain');
        var cardHeight = card.height();

        if( wHeight > cardHeight ){
            card.css('padding-bottom', wHeight-cardHeight-4);
        }

    }
}
