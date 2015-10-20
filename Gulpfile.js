'use strict';

var gulp, sass, imagemin, changed, cssGlobbing, watchify, sourcemaps,
    source, uglify, autoprefixer, RevAll, path, through, del, browserify, glob;

gulp = require('gulp');
sass = require('gulp-sass');
imagemin = require('gulp-imagemin');
changed = require('gulp-changed');
cssGlobbing = require('gulp-css-globbing');
browserify = require('browserify');
glob = require('glob');
watchify = require('watchify');
sourcemaps = require('gulp-sourcemaps');
source = require('vinyl-source-stream');
uglify = require('gulp-uglify');
autoprefixer = require('gulp-autoprefixer');
RevAll = require('gulp-rev-all');
path = require('path');
through = require('through2');
del = require('del');

var assetPath, buildPath, revPath, sources, includePaths, watchPaths;

assetPath = 'public/assets';
buildPath = 'build/assets';
sources = {
  js: 'app/assets/javascripts/application.js',
  scss: 'app/assets/stylesheets/application.scss',
  font: ['app/assets/fonts/**/*', 'vendor/assets/fonts/**/*'],
  img: 'app/assets/images/**/*'
};
includePaths = {
  js: ['app/assets/javascripts', 'vendor/assets/javascripts'],
  scss: [ 'app/assets/stylesheets', 'vendor/assets/stylesheets'],
  img: ['app/assets/images']
};
watchPaths = {
  js: ['app/assets/javascripts/**/*.js', 'vendor/assets/javascripts/**.*.js'],
  scss: ['app/assets/stylesheets/**/*.scss', 'vendor/assets/stylesheets/**/*.scss'],
  img: ['app/assets/images/**/*'],
  font: ['app/assets/fonts/**/*', 'vendor/assets/fonts/**/*']
};

gulp.task('default', ['build']);
gulp.task('build', ['compile-scss', 'compile-es6', 'compile-fonts', 'compile-images']);

gulp.task('compile-scss', function() {
  return gulp.src(sources.scss)
    .pipe(sourcemaps.init())
    .pipe(cssGlobbing({
      extensions: ['.css', '.scss'] }))
    .pipe(sass({
      indentedSyntax: false,
      includePaths: includePaths.scss,
      imagePath: 'assets',
      errLogToConsole: true }))
    .pipe(autoprefixer({ browsers: ['last 2 version'] }))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest(buildPath))
    .pipe(gulp.dest(assetPath));
});

// gulp.task('compile-es6', function() {
//   return gulp.src(sources.js)
//     .pipe(sourcemaps.init())
//     .pipe(include())
//     .pipe(babel({
//       loose: 'all' }))
//     .pipe(sourcemaps.write())
//     .pipe(gulp.dest(buildPath))
//     .pipe(gulp.dest(assetPath));
// });

gulp.task('compile-js', function() {
  var stream = browserify(sources.js, { debug: true })
    .bundle()
    .pipe(source('application.js'))
    .pipe(gulp.dest(buildPath))
    .pipe(gulp.dest(assetPath));
});

gulp.task('compile-fonts', function() {
  return gulp.src(sources.font)
    .pipe(changed(assetPath))
    .pipe(gulp.dest(buildPath))
    .pipe(gulp.dest(assetPath));
});

gulp.task('compile-images', function() {
  return gulp.src(sources.img)
    .pipe(changed(assetPath))
    .pipe(imagemin())
    .pipe(gulp.dest(buildPath))
    .pipe(gulp.dest(assetPath));
});

gulp.task('cache-bust', function() {
  var revAll = new RevAll();
  return gulp.src('build/assets/**')
    .pipe(revAll.revision())
    .pipe(gulp.dest(assetPath))
    .pipe(revAll.manifestFile())
    .pipe(gulp.dest('build'));
});

function cleanUp(keepQuantity) {
  var fileGroups = {};
  var regex = /^.+\/(.+)\..+\./;
  var identifier;
  return through.obj(function(file, enc, callback) {
    if (regex.test(file.path)) {
      identifier = regex.exec(file.path)[1] + path.extname(file.path);
      if (fileGroups[identifier] == undefined) {
        fileGroups[identifier] = [];
      }
      fileGroups[identifier].push({
        file: file.path,
        time: file.stat.ctime.getTime()
      });
    }
    callback();
  }, function(cb) {
    var filesToRemove = [];
    Object.keys(fileGroups).forEach(function(identifier) {
      fileGroups[identifier].sort(function(a,b) {
        return b.time - a.time; })
      .slice(keepQuantity)
      .forEach(function(f) {
        filesToRemove.push(f.file);
      }, this);
    }, this);
    console.log(filesToRemove);
    del(filesToRemove, cb);
  });
}

gulp.task('clean-up', function() {
  return gulp.src('public/assets/**/*', { read: false })
    .pipe(cleanUp(2));
});

gulp.task('watch', ['watch-scss', 'watch-js', 'watch-images', 'watch-fonts']);

gulp.task('watch-scss', function() {
  return gulp.watch(watchPaths.scss, ['compile-scss']);
});

gulp.task('watch-js', function() {
  return gulp.watch(watchPaths.js, ['compile-js']);
});

gulp.task('watch-images', function() {
  return gulp.watch(watchPaths.img, ['compile-images']);
});

gulp.task('watch-fonts', function() {
  return gulp.watch(watchPaths.fonts, ['compile-fonts']);
});
