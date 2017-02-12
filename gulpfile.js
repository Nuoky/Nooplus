var gulp = require('gulp');
var rev = require('gulp-rev');
var revReplace = require('gulp-rev-replace');
var useref = require('gulp-useref');
var filter = require('gulp-filter');
var uglify = require('gulp-uglify');
var csso = require('gulp-csso');
var postcss = require('gulp-postcss');
var autoprefixer = require('autoprefixer');
var imagemin = require('gulp-imagemin');
var clean = require('gulp-clean');
var browserSync = require('browser-sync').create();

//Watch
gulp.task('watch', ['browser-sync'], function () {

})
// browser-sync静态服务器开发环境
gulp.task('browser-sync', function() {
    browserSync.init({
        files: "**",
        server: {
            baseDir: "./src"
        }
    });
});
// browser-sync静态服务器生产环境
gulp.task('browser-sync-dist', function() {
    browserSync.init({
        files: "**",
        server: {
            baseDir: "./dist"
        }
    });
});

//默认任务 + 合并JS、CSS
gulp.task('default', ['clean'], function () {
    //运行压缩、移动其它文件的task，异步进行，有可能压缩后再clean结果不可预料，所以不和clean写在一起
    gulp.start('minifyImg', 'moveFile');

    var jsFilter = filter(['**/*.js', '!**/*.min.js'], {restore: true});
    var cssFilter = filter(['**/*.css', '!**/*.scss'], {restore: true});
    var revFilter = filter(['**/*', '!**/*.html'], {restore: true});

    var processors = [
        autoprefixer
    ];

    return gulp.src(['src/index.html', 'src/login.html', 'src/register.html', 'src/reset.html', 'src/tos.html', 'src/staff.html', 'src/code.html', 'src/404.html', 'src/modaltest.html'])
        //根据注释设置合并的CSS、JS
        .pipe(useref())
        //筛选JS文件
        .pipe(jsFilter)
        //压缩JS
        .pipe(uglify())
        //返回所有文件
        .pipe(jsFilter.restore)
        //筛选CSS文件
        .pipe(cssFilter)
        //添加浏览器前缀
        .pipe(postcss(processors))
        //压缩CSS
        .pipe(csso())
        //返回所有文件
        .pipe(cssFilter.restore)
        //筛选需要重命名的文件（解决缓存问题）
        .pipe(revFilter)
        //重命名增加hash值
        .pipe(rev())
        //返回所有文件
        .pipe(revFilter.restore)
        //替换重命名后的文件URL
        .pipe(revReplace())
        //将结果输出到dist目录
        .pipe(gulp.dest('dist'))
});

//移动插件plugins文件夹
gulp.task('moveFile', function(){
    return gulp.src(['src/theme*/nooplus*/plugins*/**', 'src/theme*/nooplus*/css*/fonts*/**'])
        .pipe(gulp.dest('dist'));
});

//压缩图片
gulp.task('minifyImg', function(){
    var imgFilter = filter(['**/*.jpg', '**/*.png', '**/*.gif', '**/*.svg'], {restore: true});
    return gulp.src('src/theme*/nooplus*/img*/**')
        //筛选JPG、PNG、GIF、SVG文件
        .pipe(imgFilter)
        //压缩图片
        .pipe(imagemin())
        //返回图片文件夹下的所有图片
        .pipe(imgFilter.restore)
        .pipe(gulp.dest('dist'));
});

//清空项目文件夹
gulp.task('clean', function () {
    return gulp.src('dist/*')
        .pipe(clean());
})