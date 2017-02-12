function placeholderfun(){

    if( !('placeholder' in document.createElement('input')) ){
        function GetStringNumValue(pxstr){
            return pxstr.substring(0,pxstr.length-2);
        }

        $('input[placeholder],textarea[placeholder]').each(function(){
            var $element = $(this),
                placeholder = $element.attr('placeholder');
            if($element.attr('type') != 'password'){//非密码  
                if($element.val()===""){
                    $element.val(placeholder).addClass('placeholder');
                    $element.css('color','#ccc');
                }
                $element.focus(function(){
                    if($element.val()===placeholder){
                        $element.val("").removeClass('placeholder');
                        $element.css('color','#000');
                    }
                }).blur(function(){
                    if($element.val()===""){   //if($element.val()==="" &&  ($element.attr('type') != 'password')){    
                        $element.val(placeholder).addClass('placeholder');
                        $element.css('color','#ccc');
                    }else if($element.val() == placeholder){
                        $element.css('color','#ccc');
                    }else{
                        $element.css('color','#000');
                    }
                }).closest('form').submit(function(){
                    if($element.val() === placeholder){
                        $element.val('');
                    }
                });
            }else{//密码框  
                if (placeholder){
                    // 文本框ID
                    var elementId = $element.attr('id');
                    if (!elementId) {
                        var now = new Date();
                        elementId = 'lbl_placeholder' + now.getSeconds() + now.getMilliseconds();
                        $element.attr('id', elementId);
                    }
                }//end of if (placeholder)
                 // 添加label标签，用于显示placeholder的值
                var $label = $('<label>', {
                    html: $element.val() ? '' : placeholder,
                    'for': elementId,
                    css:{
                        position: 'absolute',
                        cursor: 'text',
                        color: '#cccccc',
                        fontSize: $element.css('fontSize'),
                        fontFamily: $element.css('fontFamily')
                    }
                }).insertAfter($element);
                // 绑定事件
                var _setPosition = function () {
                    $label.css({
                        marginTop:'8px',
                        marginLeft:'-327px'
                    });
                };
                var _resetPlaceholder = function () {
                    if ($element.val()) { $label.html(null); }
                    else {
                        _setPosition();
                        $label.html(placeholder);
                    }
                };
                _setPosition();
                $element.on('focus blur input keyup propertychange resetplaceholder', _resetPlaceholder);
            }
        });
    }
}
placeholderfun();