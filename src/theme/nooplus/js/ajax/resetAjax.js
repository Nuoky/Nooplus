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