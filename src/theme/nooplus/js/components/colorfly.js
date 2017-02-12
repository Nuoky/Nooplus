// ***************colorfly-方块动画****************************
// 栗子
/*
 $("#colorfly").colorFly({
 num: 14,   //数量
 size: 10, //方块大小（越小越快）
 colors: ["#f5c152", "#e6611b", "#5cd2ad"] //随机颜色
 //方向 下次吧
 });
*/
// 兼容IE9以上
;(function ($) {
    $.fn.extend({
        "colorFly":function(options){
            var opts = $.extend({}, defaluts, options);         //使用jQuery.extend 覆盖插件默认参数
            var colorFly = $(this)[0];
            var ctx = colorFly.getContext("2d");                //获取元素并创建canvas2D画布
            var boxes = [];

            /*初始化*/
            resize();
            $(window).resize(resize);                           // 当窗口大小发生改变时
            /*添加方块实例化（包含各种函数draw、rotate、getDots）并存入boxes，且将方块限制在num个数量*/
            while (boxes.length < opts.num) {
                boxes.push(new Box());
            }
            draw();

            /*获取Canvas对象宽高*/
            function resize() {
                var box = colorFly.getBoundingClientRect();     //获取元素的宽高并赋值到元素的属性
                colorFly.width = box.width;
                colorFly.height = box.height;
            }
            /*方块参数*/
            function Box() {
                /*
                Math.floor() 方法可对一个数进行下舍入。
                Math.random()是令系统随机选取大于等于 0.0 且小于 1.0 的伪随机值
                改小25可以调整方块大小
                +1是最小方块大小限制
                由于sin、cos值的范围是-1,1，乘以half_size后方块对角线最长的也是half_size*2，所以叫它half_size
                */
                this.half_size = Math.floor((Math.random() * opts.size) + 1);

                // 随机设定方块出生坐标
                // 根据resize()函数，根据c元素大小，随机生成方块的x、y坐标值
                this.x = Math.floor((Math.random() * colorFly.width) + 1);
                this.y = Math.floor((Math.random() * colorFly.height) + 1);

                /*
                随机旋转速度
                 sin(pi*0.2) = sin(180度*0.2) = y点
                 cos(pi*0.2) = cos(180度*0.2) = x点
                */
                this.r = Math.random() * Math.PI;

                /*根据预设的colors数组的长度随机计算colors随机方块颜色*/
                this.color = opts.colors[Math.floor((Math.random() * opts.colors.length))];
                /*根据上面的x、y、r、half_size算出绘制方块的坐标点*/
                this.getDots = function () {
                    var full = (Math.PI * 2) / 4;        // (Math.PI * 2) / 4 = 360度/4 = 1/4圆
                    var p1 = {
                        /*
                        原理 sin、cos 同样的角度下，得出的值始终在一个圆上，对应x坐标、y坐标(cosa,sina)
                        随机圆心坐标x + half_size[随机值 控制大小] * (cos(180度*随机值)[控制旋转 角度大小] = x点)
                        随机圆心坐标y + half_size[随机值 控制大小] * (sin(180度*随机值)[控制旋转 角度大小] = y点)
                        */
                        x: this.x + this.half_size * Math.cos(this.r),
                        y: this.y + this.half_size * Math.sin(this.r)
                    };
                    var p2 = {
                        x: this.x + this.half_size * Math.cos(this.r + full),
                        y: this.y + this.half_size * Math.sin(this.r + full)
                    };
                    var p3 = {
                        x: this.x + this.half_size * Math.cos(this.r + full * 2),
                        y: this.y + this.half_size * Math.sin(this.r + full * 2)
                    };
                    var p4 = {
                        x: this.x + this.half_size * Math.cos(this.r + full * 3),
                        y: this.y + this.half_size * Math.sin(this.r + full * 3)
                    };
                    return {
                        p1: p1,
                        p2: p2,
                        p3: p3,
                        p4: p4
                    };
                }
                /*
                每次draw前会运行一遍rotate，给r、x、y添加上speed（移动的量）
                随着循环执行函数不断的变换位置(this.r\this.x\this.y)，形成移动、旋转所需要的数值
                速度和大小有关系，越小的方块half_size值就越小，speed值就越大，速度就越快
                */
                this.rotate = function () {
                    var speed = (60 - this.half_size) / 20;
                    this.r += speed * 0.002;    //* 0.002 转慢一点
                    this.x += -speed;           // 负值改变方向
                    this.y += speed;
                }
                /*
                根据随机方块数值绘制方块
                随着循环执行函数，根据上面的数值，不断的绘制新的正方形，形成移动动画效果
                */
                this.draw = function () {
                    // 每次绘制前运行一次getDots()获取新的数值(this.r\this.x\this.y)，生成绘制的坐标
                    var dots = this.getDots();
                    ctx.beginPath();
                    ctx.moveTo(dots.p1.x, dots.p1.y);
                    ctx.lineTo(dots.p2.x, dots.p2.y);
                    ctx.lineTo(dots.p3.x, dots.p3.y);
                    ctx.lineTo(dots.p4.x, dots.p4.y);
                    ctx.fillStyle = this.color;
                    ctx.fill();
                    //如果发现方块在界外了则让方块回到顶部重新下降
                    if (this.y - this.half_size > colorFly.height) {
                        this.y -= colorFly.height + this.half_size * 2;
                    }
                    if (this.x - this.half_size > colorFly.width) {
                        this.x -= colorFly.width + 100;
                    }
                    //x轴speed为负值时
                    if (this.x + this.half_size < 0) {
                        this.x += colorFly.width + this.half_size * 2;
                    }
                    //y轴speed为负值时
                    if (this.y + this.half_size < 0) {
                        this.y += colorFly.height + this.half_size * 2;
                    }
                }
            }
            /*开始绘制*/
            function draw() {
                ctx.clearRect(0, 0, colorFly.width, colorFly.height);   // 清空画布
                for (var i = 0; i < boxes.length; i++) {
                    boxes[i].rotate();                                  // 将boxes传入rotate()，根据值算出移动后新的方块4个点的坐标
                }
                for (var i = 0; i < boxes.length; i++) {                // rotate()后x、y值发生改变，传入draw，绘制出新的canvas图形
                    boxes[i].draw();
                }
                requestAnimationFrame(draw);                            // 按浏览器设置执行draw()，每执行一次14个方块都会重新绘制在新的坐标（x、y）
            }
        }
    })
    /*默认参数*/
    var defaluts = {
        num: 14,
        size: 25,
        colors: ["#f5c152", "#e6611b", "#5cd2ad"]
    };
})(jQuery);
