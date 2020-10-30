desc "Run"
task :run do
  sh "bundle exec rackup -p ${PORT:-3000} -o 0.0.0.0"
end

task default: :run
