var browserSync = require('browser-sync');
var gulp        = require('gulp');

gulp.task('browserSync', ['browserify', 'coffeelint', 'copyJs', 
	'fonts', 'sounds', 'sass', 'copyCss', 'images', 'jade', 'copyHtml'
], function() {
  browserSync.init(['.tmp/**'], {   // watch .tmp dir for changes
    server: {
      baseDir: [
        '.tmp',
        '.'      // for bower_components availability
      ]
    }
  });
});
