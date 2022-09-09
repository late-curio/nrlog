require "./nrlog"

file = "newrelic_agent.log"
if ARGV.size() > 0
  file = ARGV[0]
end
log = Nrlog::AgentLog.new(file)
log.load()
session = log.first
puts "#{session.transaction_count} transactions started"
puts ""
puts "Instrumentation"
puts "---------------"
session.weaved.to_a().sort().each do |pkg|
  puts pkg
end
puts ""
puts "Extensions (not loaded initially)"
puts "---------------------------------"
session.extensions.to_a().sort().each do |pkg|
  puts pkg
end