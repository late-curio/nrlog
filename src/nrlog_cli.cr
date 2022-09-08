require "./nrlog"

file = "newrelic_agent.log"
if ARGV.size() > 0
  file = ARGV[0]
end
log = Nrlog.load(file)
puts "#{log.transaction_count} transactions started"
puts ""
puts "Instrumentation"
puts "---------------"
log.weaved.to_a().sort().each do |pkg|
  puts pkg
end
puts ""
puts "Extensions (not loaded initially)"
puts "---------------------------------"
log.extensions.to_a().sort().each do |pkg|
  puts pkg
end