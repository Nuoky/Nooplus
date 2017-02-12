/*
判断是否是PC端函数
参数：IsPC( [ "Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod" ] )
PC返回true
*/
function IsPC( m )
{
    var userAgentInfo = navigator.userAgent;
    var Agents = m;
    // var Agents = new Array("Android", "iPhone", "SymbianOS", "Windows Phone", "iPod");
    var flag = true;
    for (var v = 0; v < Agents.length; v++) {
        if (userAgentInfo.indexOf(Agents[v]) > 0) { flag = false; break; }
    }
    return flag;
}
