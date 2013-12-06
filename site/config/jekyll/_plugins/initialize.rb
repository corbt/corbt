
FileUtils.rm_rf(Dir.glob('../../public/assets/*.css'))
FileUtils.rm_rf(Dir.glob('../../public/assets/*.js'))
system('bundle exec rake assets:precompile')