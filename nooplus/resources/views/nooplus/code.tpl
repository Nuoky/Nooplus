<!--header-->
{include file='header.tpl'}

<!--background-->
<div class="bg-img"></div>

<div class="card-main card-main-tos">
	<div class="card-header">
		<div class="card-tab card-tab-x1">
			<h1 class="content-heading">邀请码</h1>
		</div>
	</div>
	<div class="card-content">
		<div class="card-body">
			<div class="card-title">
				<h3>
				{$config["appName"]} 的邀请码，没了就是没了哦。
				</h3>
			</div>
			<hr>
				<div class="card-table">
					<div class="table-responsive">
						<table class="table">
							<thead>
							<tr>
								<th>###</th>
								<th>邀请码 (点击邀请码进入注册页面)</th>
								<th>状态</th>
							</tr>
							</thead>
							<tbody>
							{foreach $codes as $code}
							<tr>
								<td>{$code->id}</td>
								<td><a href="/auth/register?code={$code->code}">{$code->code}</a></td>
								<td>可用</td>
							</tr>
							{/foreach}
							</tbody>
						</table>
					</div>
				</div>
			<hr>
		</div>
	</div>
</div>

<!--footer-->
{include file='footer.tpl'}

</body>
</html>