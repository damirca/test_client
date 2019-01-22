require "bundler/gem_tasks"
require "test_client"

desc 'Runs the test client and outputs the final result'
task :client_test_run do
  runner = TestClient::Runner.new
  runner.run
  puts runner.final_result
end

task :default => :client_test_run
