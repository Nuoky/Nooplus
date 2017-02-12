<!--header-->
{include file='header.tpl'}

<!--background-->
<div class="bg-img"></div>

<!--card-->
<div class="card-main card-main-auth" id="cardMain">
    <div class="card-header">
        <div class="card-tab card-tab-x1">
            <div>
                <span>重置密码</span>
            </div>
        </div>
    </div>

    <!--reset-->
    <div class="card-content card-reset" show="yes">
        <div class="card-body">
            <div class="card-title">
                <h3>嗨呀，忘记密码了？</h3>
            </div>
            <div class="reset-form">
                <form role="form" action="javascript:void(0);"  method="POST">
                    <div class="form-group">
                        <input type="text" value="" placeholder="请输入邮箱" id="resetEmail">
                        <label for="resetEmail"></label>
                    </div>

                    <div class="form-group">
                        <button id="reset" type="submit">重置密码</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="card-footer clearfix">
            <p class="login-btn"><a class="login-link" href="/auth/login">登录</a></p>
            <p class="register-btn"><a class="login-link" href="/auth/register">新用户注册</a></p>
        </div>
    </div>

</div>

{include file='bsdialog.tpl'}

<!--footer-->
{include file='footer.tpl'}

<script>
    $(document).ready(function(){
        function reset(){
            $("#result").modal();
            $("#msg").html("正在发送，请稍候。。。");
            $.ajax({
                type:"POST",
                url:"/password/reset",
                dataType:"json",
                data:{
                    email: $("#email").val(),
                },
                success:function(data){
                    if(data.ret == 1){
                        $("#result").modal();
                        $("#msg").html(data.msg);
                       // window.setTimeout("location.href='/auth/login'", 2000);
                    }else{
                        $("#result").modal();
                        $("#msg").html(data.msg);
                    }
                },
                error:function(jqXHR){
                    $("#result").modal();
                    $("#msg").html(data.msg);
                }
            });
        }
        $("html").keydown(function(event){
            if(event.keyCode==13){
                login();
            }
        });
        $("#reset").click(function(){
            reset();
        });
    })
</script>

</body>
</html>