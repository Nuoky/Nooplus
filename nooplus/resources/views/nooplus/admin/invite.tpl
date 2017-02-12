





{include file='admin/main.tpl'}







	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">邀请</h1>
			</div>
		</div>
		<div class="container">
				<section class="content-inner margin-top-no">
				
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<p>公共邀请码（类别为0的邀请码）请<a href="/code">在这里查看</a>。</p>
							</div>
						</div>
					</div>
					
					
					<div class="card">
						<div class="card-main">
							<div class="card-inner">
								<div class="form-group form-group-label">
									<label class="floating-label" for="prefix">邀请码前缀</label>
									<input class="form-control" id="prefix" type="text">
								</div>
								
								<div class="form-group form-group-label">
									<label class="floating-label" for="uid">邀请码类别(0为公开，其他数字为对应用户的ID，或者输入用户的完整邮箱)</label>
									<input class="form-control" id="uid" type="text">
								</div>
								
								<div class="form-group form-group-label">
									<label class="floating-label" for="prefix">邀请码数量</label>
									<input class="form-control" id="num" type="number">
								</div>
								
								
							</div>
							
							<div class="card-action">
								<div class="card-action-btn pull-left">
									<a class="btn btn-flat waves-attach" id="invite" ><span class="icon">check</span>&nbsp;生成</a>
								</div>
							</div>
						</div>
					</div>
					
					<div class="card margin-bottom-no">
						<div class="card-main">
							<div class="card-inner">
								<p class="card-heading">返利记录</p>
									<div class="card-table">
										<div class="table-responsive">
											{$paybacks->render()}
											<table class="table">
												<thead>
												<tr>
													<th>###</th>
													<th>返利用户</th>
													<th>返利金额</th>
												</tr>
												</thead>
												<tbody>
												{foreach $paybacks as $payback}
													<tr>
														<td><b>{$payback->id}</b></td>
														{if $payback->user()!=null}
														<td>{$payback->user()->user_name}
														</td>
														{else}
														<td>已注销
														</td>
														{/if}
														<td>{$payback->ref_get} 元</td>
													</tr>
												{/foreach}
												</tbody>
											</table>
											{$paybacks->render()}
										</div>
									</div>
								
								
							</div>
						</div>
					</div>
					
					{include file='dialog.tpl'}

							
			</div>
			
			
			
	</main>












{include file='admin/footer.tpl'}





<script>
    $("#invite").click(function () {
            $.ajax({
                type: "POST",
                url: "/admin/invite",
                dataType: "json",
                data: {
                    prefix: $("#prefix").val(),
                    uid: $("#uid").val(),
                    num: $("#num").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
                        $("#msg").html(data.msg);
                        window.setTimeout("location.href='/admin/invite'", {$config['jump_delay']});
					}
                    else
					{
						$("#result").modal();
                        $("#msg").html(data.msg+"。");
					}
					
                    // window.location.reload();
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
</script>

