<!--header-->
{include file='header.tpl'}

<!--background-->
<div class="bg-img"></div>

<!--card-->
<div class="card-main card-main-auth" id="cardMain">
    <div class="card-header">

        <div class="card-tab card-tab-x2 clearfix">
            <div class="active" target="card-register">
                <span>注册</span>
            </div>
            <div target="card-login">
                <span>登录</span>
            </div>
        </div>

    </div>

    <!--register-->
    <div class="card-content card-register" show="yes">
        <div class="card-body">
            <div class="card-title">
                <h3>欢迎加入</h3>
            </div>
            <div class="register-form">
                <form role="form" action="javascript:void(0);"  method="POST">
                    <div class="form-group">
                        <input type="text" value="" placeholder="昵称" id="registerName">
                        <label for="registerName"></label>
                    </div>
                    <div class="form-group">
                        <input type="text" value="" placeholder="邮箱" id="registerEmail">
                        <label for="registerEmail"></label>
                    </div>
                    
                    {if $enable_email_verify == 'true'}
                    <!--TPL预留-->
                    <div class="form-group">
                        <input type="text" value="" placeholder="邮箱验证码" id="email_code">
                        <label for="email_code"></label>
                        <button id="email_verify" type="submit">获取验证码</button>
                    </div>
                    {/if}

                    <div class="form-group">
                        <input type="password" value="" placeholder="密码" id="registerPasswd">
                        <!--<label for="registerPasswd"></label>-->
                    </div>
                    <div class="form-group">
                        <input type="password" value="" placeholder="重复密码" id="repasswd">
                        <!--<label for="repasswd"></label>-->
                    </div>

                    <div class="form-group clearfix">
                        <select class="form-control" id="imtype">
                            <option>选择您的联络方式</option>
                            <option value="1">微信</option>
                            <option value="2">QQ</option>
                            <option value="3">Google+</option>
                            <option value="4">Telegram</option>
                        </select>
                        <label for="imtype"></label>
                    </div>

                    <div class="form-group">
                        <input type="text" value="" placeholder="在这输入联络方式账号" id="wechat">
                        <label for="wechat"></label>
                    </div>

                    {if $enable_invite_code == 'true'}
                    <!--TPL预留-->
                    <div class="form-group">
                        <input type="text" value="" placeholder="邀请码" id="icode" value="{$code}">
                        <label for="icode"></label>
                    </div>
                    {/if}

                    {if $geetest_html != null}
                    <!--TPL预留-->
                    <div class="form-group">
                        <div id="embed-captcha-register"></div>
                    </div>
                    {/if}

                    <div class="form-group">
                        <button id="tos" type="submit">注册</button>
                    </div>

                    <div class="form-group card-tos">
                        <p>注册即代表同意<a href="/tos">服务条款</a>，以及保证所录入信息的真实性，如有不实信息会导致账号被删除。</p>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!--login-->
    <div class="card-content card-login">
        <div class="card-body">
            <div class="card-avatar">
                <img alt="avatar" src="/theme/nooplus/img/avatar.jpg">
            </div>
            <div class="login-form">
                <form role="form" action="javascript:void(0);"  method="POST">
                    <div class="form-group">
                        <input type="text" value="" placeholder="请输入账号" id="loginEmail">
                        <label for="loginEmail"></label>
                    </div>

                    <div class="form-group">
                        <input type="password" value="" placeholder="请输入密码" id="loginPasswd">
                        <!--<label for="loginPasswd"></label>-->
                    </div>

                    <div class="form-group">
                        <input type="text" value="" placeholder="请输入两步验证码(没有就别填)" id="Code">
                        <label for="Code"></label>
                    </div>

                    {if $geetest_html != null}
                    <div class="form-group">
                        <div id="embed-captcha-login"></div>
                    </div>
                    {/if}

                    <div class="form-group">
                        <button id="login" type="submit">登录</button>
                    </div>

                    <div class="form-group text-left">
                        <input type="checkbox" value="week" id="remember_me" name="remember_me" checked>
                        <label for="remember_me"><span>记住我</span></label>
                    </div>
                </form>
            </div>
        </div>
        <div class="card-footer clearfix">
            <p class="reset-btn"><a class="login-link" href="/password/reset">忘记密码</a></p>
            <p class="register-btn"><a class="login-link" href="/auth/register">新用户注册</a></p>
        </div>
    </div>

</div>

{include file='bsdialog.tpl'}

<div class="modal fade" tabindex="-1" role="dialog" id="tos_modal" >
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">注册 TOS</h4>
            </div>
            <div class="modal-body">
                {include file='reg_tos.tpl'}
            </div>
            <div class="modal-footer">
                <p class="text-right">
                    <button type="button" data-dismiss="modal" id="cancel">我不服</button>
                    <button type="button" data-dismiss="modal" id="reg" >资慈</button>
                </p>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

{include file='footer.tpl'}

<!-- 登录AJAX -->
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
        // $("html").keydown(function(event){
        //     if(event.keyCode==13){
        //         login();
        //     }
        // });
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
        
        captchaObj.appendTo("#embed-captcha-login");

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

<!-- 注册AJAX -->
<script>
    $(document).ready(function(){
        function register(){
            
            document.getElementById("tos").disabled = true; 
            
            $.ajax({
                type:"POST",
                url:"/auth/register",
                dataType:"json",
                data:{
                    email: $("#registerEmail").val(),
                    name: $("#registerName").val(),
                    passwd: $("#registerPasswd").val(),
                    repasswd: $("#repasswd").val(),
                    wechat: $("#wechat").val(),
                    imtype: $("#imtype").val(){if $enable_invite_code == 'true'},
                    code: $("#icode").val(){/if}{if $enable_email_verify == 'true'},
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
        // $("html").keydown(function(event){
        //     if(event.keyCode==13){
        //         $("#tos_modal").modal();
        //     }
        // });
        
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
        
        captchaObj.appendTo("#embed-captcha-register");

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

</body>
</html>