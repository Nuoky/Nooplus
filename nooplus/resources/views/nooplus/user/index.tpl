





{include file='user/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">用户中心</h1>
			</div>
		</div>
		<div class="container">
			<section class="content-inner margin-top-no">
				<div class="ui-card-wrap">
						
						<div class="col-lg-6 col-md-6">
						
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">系统中最新公告</p>
										<p>其他公告请到<a href="/user/announcement"/>公告面板</a>查看。</p>
										{if $ann != null}
										<p>{$ann->content}</p>
										{/if}
									</div>
									
								</div>
							</div>
						
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">All-in-One</p>
										<p>这里为您提供了自动化地配置文件生成，包含了所有 Shadowsocks 服务器的信息，方便您在诸多的服务器中快速添加，快速切换。</p>
										<p><i class="icon icon-lg">desktop_windows</i>&nbsp;<a href="/ssr-download/ssr-win.7z">Windows 下载 C# 版</a>，解压，运行程序，然后您有两种方式导入所有节点<br>(1)下载<a href="/user/getpcconf?without_mu=0">这个</a>或者<a  href="/user/getpcconf?without_mu=1">这个（无单端口多用户）</a>，右键小飞机 服务器 -- 从配置文件导入服务器，选择这个文件，<br>(2)点击<a class="copy-text" data-clipboard-text="{$android_add}">这里</a>或者<a class="copy-text" data-clipboard-text="{$android_add_without_mu}">这个（无单端口多用户）</a>，然后右键小飞机 -- 从剪贴板复制地址<br>然后选择一个合适的服务器，更新一下PAC为绕过国内IP，然后开启系统代理即可上网。</p>
										<p><i class="icon icon-lg">laptop_mac</i>&nbsp;<a href="/ssr-download/ssr-mac.dmg">Mac OS X下载这个</a>，安装，然后下载<a href="/user/getpcconf?without_mu=0">这个</a>或者<a  href="/user/getpcconf?without_mu=1">这个（无单端口多用户）</a>，运行程序，小飞机上右键 服务器列表 子菜单 的 “导入服务器配置文件...” 导入这个文件，然后选择一个合适的服务器，更新一下PAC，然后开启系统代理即可上网。</p>
										<p><i class="icon icon-lg">laptop_mac</i>&nbsp;iOS 强烈推荐下载<a href="https://itunes.apple.com/cn/app/shadowrocket/id932747118?mt=8">Shadowrocket</a>，然后在 Safari 中点击<a id="android_add" href="{$android_add}">这个</a>或者<a id="android_add_without_mu" href="{$android_add_without_mu}">这个（无单端口多用户）</a>，然后点击确定，就可以批量添加节点。</p>
										<STRIKE><p><i class="icon icon-lg">laptop_mac</i>&nbsp;iOS 下载<a href="/link/{$ios_token}">这个</a>，导入到 Surge 中，然后就可以随意切换服务器上网了。</p></STRIKE>
										<p><i class="icon icon-lg">android</i>&nbsp;<a href="/ssr-download/ssr-android.apk">Android下载 Android 版</a>，安装，然后在手机上默认浏览器中点击<a id="android_add" href="{$android_add}">这个</a>或者<a id="android_add_without_mu" href="{$android_add_without_mu}">这个（无单端口多用户）</a>，然后点击确定，批量添加完节点，然后路由选择绕过大陆，右上角开启就可以上网了。同时提供一个 ACL 地址，<a href="/link/{$acl_token}">长按复制地址</a>到客户端里应用即可。</p>
									</div>
									
								</div>
							</div>
						
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">帐号使用情况</p>
										<dl class="dl-horizontal">
											<dt>帐号等级</dt>
											<dd>{$user->class}</dd>

											<dt>等级过期时间</dt>
											<dd>{$user->class_expire}</dd>

											<dt>帐号过期时间</dt>
											<dd>{$user->expire_in}</dd>
											
											<dt>速度限制</dt>
											{if $user->node_speedlimit!=0}
											<dd>{$user->node_speedlimit}Mbps</dd>
											{else}
											<dd>不限速</dd>
											{/if}
										</dl>
									</div>
									
								</div>
							</div>
						
							
							
							
						</div>
						
						<div class="col-lg-6 col-md-6">
							
						
						
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
									
										<div id="traffic_chart" style="height: 300px; width: 100%;"></div>
										
										<script src="//cdn.staticfile.org/canvasjs/1.7.0/canvasjs.js"></script>
										<script type="text/javascript">
											var chart = new CanvasJS.Chart("traffic_chart",
											{
												title:{
													text: "流量使用情况",
													fontFamily: "Impact",
													fontWeight: "normal"
												},

												legend:{
													verticalAlign: "bottom",
													horizontalAlign: "center"
												},
												data: [
												{
													//startAngle: 45,
													indexLabelFontSize: 20,
													indexLabelFontFamily: "Garamond",
													indexLabelFontColor: "darkgrey",
													indexLabelLineColor: "darkgrey",
													indexLabelPlacement: "outside",
													type: "doughnut",
													showInLegend: true,
													dataPoints: [
														{if $user->transfer_enable != 0}
														{
															y: {$user->last_day_t/$user->transfer_enable*100}, legendText:"已用 {number_format($user->last_day_t/$user->transfer_enable*100,2)}% {$user->LastusedTraffic()}", indexLabel: "已用 {number_format($user->last_day_t/$user->transfer_enable*100,2)}% {$user->LastusedTraffic()}"
														},
														{
															y: {($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100}, legendText:"今日 {number_format(($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100,2)}% {$user->TodayusedTraffic()}", indexLabel: "今日 {number_format(($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100,2)}% {$user->TodayusedTraffic()}"
														},
														{
															y: {($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100}, legendText:"剩余 {number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100,2)}% {$user->unusedTraffic()}", indexLabel: "剩余 {number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100,2)}% {$user->unusedTraffic()}"
														}
														{/if}
													]
												}
												]
											});

											chart.render();
										</script>
										
									</div>
									
								</div>
							</div>
						
						
					
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">续命获取流量</p>
											<p>流量不会重置，可以通过续命获取流量。</p>

											<p>每次续命可以获取{$config['checkinMin']}~{$config['checkinMax']}MB流量。</p>
										
											<p>每天可以续命一次。您可以点击按钮或者摇动手机来续命。</p>

											<p>上次续命时间：<code>{$user->lastCheckInTime()}</code></p>
											
											<p id="checkin-msg"></p>
											
											{if $geetest_html != null}
												<div id="popup-captcha"></div>
											{/if}
									</div>
									
									<div class="card-action">
										<div class="card-action-btn pull-left">
											{if $user->isAbleToCheckin() }
												<p id="checkin-btn">
													<button id="checkin" class="btn btn-brand btn-flat waves-attach"><span class="icon">check</span>&nbsp;续命</button>
												</p>
											{else}
												<p><a class="btn btn-brand disabled btn-flat waves-attach" href="#"><span class="icon">check</span>&nbsp;不能续命</a></p>
											{/if}
										</div>
									</div>
									
								</div>
							</div>
						
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">连接信息</p>
											<dl class="dl-horizontal">
												<dt>端口</dt>
												<dd>{$user->port}</dd>
												<dt>密码</dt>
												<dd>{$user->passwd}</dd>
												<dt>上次使用</dt>
												<dd>{$user->lastSsTime()}</dd>
											</dl>
									</div>
									
								</div>
							</div>
						
						
						
						
						{if $enable_duoshuo=='true'}
						
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<p class="card-heading">讨论区</p>
											<div class="ds-thread" data-thread-key="0" data-title="index" data-url="{$baseUrl}/user/"></div>
											<script type="text/javascript">
											var duoshuoQuery = {

											short_name:"{$duoshuo_shortname}"


											};
												(function() {
													var ds = document.createElement('script');
													ds.type = 'text/javascript';ds.async = true;
													ds.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') + '//static.duoshuo.com/embed.js';
													ds.charset = 'UTF-8';
													(document.getElementsByTagName('head')[0] 
													 || document.getElementsByTagName('body')[0]).appendChild(ds);
												})();
											</script>
									</div>
									
								</div>
							</div>
						
						{/if}
						
						{include file='dialog.tpl'}
						
					</div>
						
					
				</div>
			</section>
		</div>
	</main>







{include file='user/footer.tpl'}

<script src="theme/material/js/shake.js/shake.js"></script>


<script>

$(function(){
	new Clipboard('.copy-text');
});

$(".copy-text").click(function () {
	$("#result").modal();
	$("#msg").html("已复制到您的剪贴板，请您继续接下来的操作。");
});

{if $geetest_html == null}


window.onload = function() { 
    var myShakeEvent = new Shake({ 
        threshold: 15 
    }); 
 
    myShakeEvent.start(); 
 
    window.addEventListener('shake', shakeEventDidOccur, false); 
 
    function shakeEventDidOccur () { 
		if("vibrate" in navigator){
			navigator.vibrate(500);
		}
		
        $.ajax({
                type: "POST",
                url: "/user/checkin",
                dataType: "json",
                success: function (data) {
                    $("#checkin-msg").html(data.msg);
                    $("#checkin-btn").hide();
					$("#result").modal();
                    $("#msg").html(data.msg);
                },
                error: function (jqXHR) {
					$("#result").modal();
                    $("#msg").html("发生错误：" + jqXHR.status);
                }
            });
    } 
}; 


$(document).ready(function () {
	$("#checkin").click(function () {
		$.ajax({
			type: "POST",
			url: "/user/checkin",
			dataType: "json",
			success: function (data) {
				$("#checkin-msg").html(data.msg);
				$("#checkin-btn").hide();
				$("#result").modal();
				$("#msg").html(data.msg);
			},
			error: function (jqXHR) {
				$("#result").modal();
				$("#msg").html("发生错误：" + jqXHR.status);
			}
		})
	})
})
	

{else}


window.onload = function() { 
    var myShakeEvent = new Shake({ 
        threshold: 15 
    }); 
 
    myShakeEvent.start(); 
 
    window.addEventListener('shake', shakeEventDidOccur, false); 
 
    function shakeEventDidOccur () { 
		if("vibrate" in navigator){
			navigator.vibrate(500);
		}
		
        c.show();
    } 
}; 



var handlerPopup = function (captchaObj) {
	c = captchaObj;
	captchaObj.onSuccess(function () {
		var validate = captchaObj.getValidate();
		$.ajax({
			url: "/user/checkin", // 进行二次验证
			type: "post",
			dataType: "json",
			data: {
				// 二次验证所需的三个值
				geetest_challenge: validate.geetest_challenge,
				geetest_validate: validate.geetest_validate,
				geetest_seccode: validate.geetest_seccode
			},
			success: function (data) {
				$("#checkin-msg").html(data.msg);
				$("#checkin-btn").hide();
				$("#result").modal();
				$("#msg").html(data.msg);
			},
			error: function (jqXHR) {
				$("#result").modal();
				$("#msg").html("发生错误：" + jqXHR.status);
			}
		});
	});
	// 弹出式需要绑定触发验证码弹出按钮
	captchaObj.bindOn("#checkin");
	// 将验证码加到id为captcha的元素里
	captchaObj.appendTo("#popup-captcha");
	// 更多接口参考：http://www.geetest.com/install/sections/idx-client-sdk.html
};

initGeetest({
	gt: "{$geetest_html->gt}",
	challenge: "{$geetest_html->challenge}",
	product: "popup", // 产品形式，包括：float，embed，popup。注意只对PC版验证码有效
	offline: {if $geetest_html->success}0{else}1{/if} // 表示用户后台检测极验服务器是否宕机，与SDK配合，用户一般不需要关注
}, handlerPopup);
	


{/if}


</script>
