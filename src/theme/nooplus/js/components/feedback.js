var feedback = [
    {
        'body': 'NOOPLUS联机加速器性能稳定，价格也比较公道。从第一次使用至今，网络质量令人满意，所以现在身边的朋友我都推荐使用。每天都有专业在线客服，给力！',
        'author': '某玩家'
    },
	{
		'body': '测试。',
		'author': '作者'
	},
    {
        'body': '我可能碰到了假的用户反馈。',
        'author': '真的反馈'
    }
]

$('#feedbackButton').on('click', feedbackFn);

function feedbackFn() {
	var num = getReandomNum();
	$('#textBody').html(feedback[num].body);
	$('#textAuthor').html('——' + feedback[num].author);
}

/*随机返回用户反馈*/
function getReandomNum() {
	var reandomNum = Math.floor(Math.random() * feedback.length);
	return reandomNum;
}