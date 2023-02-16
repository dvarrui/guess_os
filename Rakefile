# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

require "standard/rake"

task default: %i[test standard]

task :help do
  system("rake -T")
end

# require "bundler/setup"
# require "bump/tasks"
#
# Bundler::GemHelper.install_tasks
