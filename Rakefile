require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec'
require 'rspec/core'
require 'rspec/core/rake_task'

task :release => :spec

desc "Run Specs"
Rspec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern    = "spec/**/*_spec.rb"
  spec.verbose    = true
  spec.rspec_opts = ['--color']
end

require 'yard'

desc "Generate YARD docs"
YARD::Rake::YardocTask.new(:yard) do |t|
  t.files += ['lib/**/*.rb']
end
