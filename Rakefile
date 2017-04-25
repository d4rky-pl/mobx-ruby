require 'bundler'
Bundler.require

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec') do |t|
  t.pattern = FileList['spec/**/*_spec.rb']
end

task :default => :spec

desc "Push a new version to Rubygems"
task :publish do
  require 'mobx/version'

  sh "gem build mobx-ruby.gemspec"
  sh "gem push mobx-ruby-#{Mobx::VERSION}.gem"
  sh "git tag v#{Mobx::VERSION}"
  sh "git push origin v#{Mobx::VERSION}"
  sh "git push origin master"
  sh "rm ruby-mobx-#{Mobx::VERSION}.gem"
end
