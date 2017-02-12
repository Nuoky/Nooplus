/*
 isIE( ["9.0", "8.0", "7.0", "6.0" ] )
参数说明：9.0、8.0 对应 IE9、IE8，符合参数返回结果true
*/
function isIE( v ) {
    var ieVersion = v;
    /*判断IE浏览器变量*/
    var browser=navigator.appName;
    var b_version=navigator.appVersion;
    var version=b_version.split(";");
    /*兼容火狐，火狐下version.length = 1，所以找不到version[1]*/
    /*IE11以下都是 version.length = 11*/
    /*这里设置1代表跳过火狐了*/
    if (version.length > 1) {
        var trim_Version=version[1].replace(/[ ]/g,"").replace(/MSIE/g,"");
        for(var i=0; i<ieVersion.length; i++){
            var flag = true;
            if( browser == "Microsoft Internet Explorer" && ieVersion[i] == trim_Version ){
                // alert(trim_Version + ' v ' + ieVersion[i]);
                // alert('IE');
                break;
            }else{
                // alert(trim_Version + ' v ' + ieVersion[i]);
                // alert('noIE');
                flag = false;
            }
        }
    }
    return flag;
}