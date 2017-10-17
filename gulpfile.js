var gulp = require('gulp');
var cleanCSS = require('gulp-clean-css');
var sass = require('gulp-sass');
var cucumber = require('gulp-cucumber');

//script paths
var destCss = 'src/main/resources/META-INF/resources/public/css',
 srcSass = 'src/main/resources/assets/sass/*.scss';

gulp.task('sass', function () {
  return gulp
    // Find all `.scss` files from the `sass/` folder
    .src(srcSass)
    // Run Sass on those files
    .pipe(sass())
    // Minifies the files
    .pipe(cleanCSS({compatibility: 'ie8'}))
    // Write the resulting CSS in the output folder
    .pipe(gulp.dest(destCss));
});

gulp.task('watch', function() {
  return gulp
    // Watch the input folder for change,
    // and run `sass` task when something happens
    .watch(srcSass, ['sass'])
    // When there is a change,
    // log a message in the console
    .on('change', function(event) {
      console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
    });
});

gulp.task('cucumber', function() {
    return gulp.src('src/test/resources/*').pipe(cucumber({
        'steps': 'src/test/javascript/FDMWebApp/*.js',
        'format': 'summary',
        'tags': '@javascript'
    }));
});