/*login*/
<script>
$(document).ready(function(){
    function login(){
        {if $geetest_html != null}
        if(typeof validate == 'undefined')
        {
            $("#result").modal();
            $("#msg").html("请滑动验证码来完成验证。");
            return;
        }

        if (!validate) {
            $("#result").modal();
            $("#msg").html("请滑动验证码来完成验证。");
            return;
        }

        {/if}

        document.getElementById("login").disabled = true;

        $.ajax({
            type:"POST",
            url:"/auth/login",
            dataType:"json",
            data:{
                email: $("#loginEmail").val(),
                passwd: $("#loginPasswd").val(),
                code: $("#code").val(),
                remember_me: $("#remember_me:checked").val(){if $geetest_html != null},
        geetest_challenge: validate.geetest_challenge,
            geetest_validate: validate.geetest_validate,
            geetest_seccode: validate.geetest_seccode{/if}
    },
        success:function(data){
            if(data.ret == 1){
                $("#result").modal();
                $("#msg").html(data.msg);
                window.setTimeout("location.href='/user'", {$config['jump_delay']});
                // window.setTimeout("location.href='/user'", 1);
            }else{
                $("#result").modal();
                $("#msg").html(data.msg);
                document.getElementById("login").disabled = false;
                {if $geetest_html != null}
                captcha.refresh();
                {/if}
            }
        },
        error:function(jqXHR){
            $("#msg-error").hide(10);
            $("#msg-error").show(100);
            $("#msg-error-p").html("发生错误："+jqXHR.status);
            document.getElementById("login").disabled = false;
            {if $geetest_html != null}
            captcha.refresh();
            {/if}
        }
    });
    }
    $("html").keydown(function(event){
        if(event.keyCode==13){
            login();
        }
    });
    $("#login").click(function(){
        login();
    });

    $('div.modal').on('shown.bs.modal', function() {
        $("div.gt_slider_knob").hide();
    });

    $('div.modal').on('hidden.bs.modal', function() {
        $("div.gt_slider_knob").show();
    });
})
</script>

{if $geetest_html != null}
<script>
var handlerEmbed = function (captchaObj) {
    // 将验证码加到id为captcha的元素里

    captchaObj.onSuccess(function () {
        validate = captchaObj.getValidate();
    });

    captchaObj.appendTo("#embed-captcha");

    captcha = captchaObj;
    // 更多接口参考：http://www.geetest.com/install/sections/idx-client-sdk.html
};

initGeetest({
    gt: "{$geetest_html->gt}",
    challenge: "{$geetest_html->challenge}",
    product: "embed", // 产品形式，包括：float，embed，popup。注意只对PC版验证码有效
    offline: {if $geetest_html->success}0{else}1{/if} // 表示用户后台检测极验服务器是否宕机，与SDK配合，用户一般不需要关注
}, handlerEmbed);
</script>
{/if}


/*register*/

<script>
$(document).ready(function(){
    function register(){

        document.getElementById("tos").disabled = true;

        $.ajax({
            type:"POST",
            url:"/auth/register",
            dataType:"json",
            data:{
                email: $("#email").val(),
                name: $("#name").val(),
                passwd: $("#passwd").val(),
                repasswd: $("#repasswd").val(),
                wechat: $("#wechat").val(),
                imtype: $("#imtype").val(){if $enable_invite_code == 'true'},
        code: $("#code").val(){/if}{if $enable_email_verify == 'true'},
        emailcode: $("#email_code").val(){/if}{if $geetest_html != null},
        geetest_challenge: validate.geetest_challenge,
            geetest_validate: validate.geetest_validate,
            geetest_seccode: validate.geetest_seccode
        {/if}
    },
        success:function(data){
            if(data.ret == 1){
                $("#result").modal();
                $("#msg").html(data.msg);
                window.setTimeout("location.href='/auth/login'", {$config['jump_delay']});
            }else{
                $("#result").modal();
                $("#msg").html(data.msg);
                document.getElementById("tos").disabled = false;

                {if $geetest_html != null}
                captcha.refresh();
                {/if}
            }
        },
        error:function(jqXHR){
            $("#msg-error").hide(10);
            $("#msg-error").show(100);
            $("#msg-error-p").html("发生错误："+jqXHR.status);
            document.getElementById("tos").disabled = false;
            {if $geetest_html != null}
            captcha.refresh();
            {/if}
        }
    });
    }
    $("html").keydown(function(event){
        if(event.keyCode==13){
            $("#tos_modal").modal();
        }
    });

    {if $geetest_html != null}
    $('div.modal').on('shown.bs.modal', function() {
        $("div.gt_slider_knob").hide();
    });


    $('div.modal').on('hidden.bs.modal', function() {
        $("div.gt_slider_knob").show();
    });


    {/if}

    $("#reg").click(function(){
        register();
    });

    $("#tos").click(function(){
        {if $geetest_html != null}
        if(typeof validate == 'undefined')
        {
            $("#result").modal();
            $("#msg").html("请滑动验证码来完成验证。");
            return;
        }

        if (!validate) {
            $("#result").modal();
            $("#msg").html("请滑动验证码来完成验证。");
            return;
        }

        {/if}
        $("#tos_modal").modal();
    });
})
</script>


{if $enable_email_verify == 'true'}
<script>
var wait=60;
function time(o) {
    if (wait == 0) {
        o.removeAttr("disabled");
        o.text("获取验证码");
        wait = 60;
    } else {
        o.attr("disabled","disabled");
        o.text("重新发送(" + wait + ")");
        wait--;
        setTimeout(function() {
                time(o)
            },
            1000)
    }
}



$(document).ready(function () {
    $("#email_verify").click(function () {
        time($("#email_verify"));

        $.ajax({
            type: "POST",
            url: "send",
            dataType: "json",
            data: {
                email: $("#email").val()
            },
            success: function (data) {
                if (data.ret) {
                    $("#result").modal();
                    $("#msg").html(data.msg);

                } else {
                    $("#result").modal();
                    $("#msg").html(data.msg);
                }
            },
            error: function (jqXHR) {
                $("#result").modal();
                $("#msg").html(data.msg+"     出现了一些错误。");
            }
        })
    })
})
</script>
{/if}

{if $geetest_html != null}
<script>
var handlerEmbed = function (captchaObj) {
    // 将验证码加到id为captcha的元素里

    captchaObj.onSuccess(function () {
        validate = captchaObj.getValidate();
    });

    captchaObj.appendTo("#embed-captcha");

    captcha = captchaObj;
    // 更多接口参考：http://www.geetest.com/install/sections/idx-client-sdk.html
};

initGeetest({
    gt: "{$geetest_html->gt}",
    challenge: "{$geetest_html->challenge}",
    product: "embed", // 产品形式，包括：float，embed，popup。注意只对PC版验证码有效
    offline: {if $geetest_html->success}0{else}1{/if} // 表示用户后台检测极验服务器是否宕机，与SDK配合，用户一般不需要关注
}, handlerEmbed);
</script>

{/if}