require "./nrlog"

file = "newrelic_agent.log"
if ARGV.size() > 0
  file = ARGV[0]
end
log = Nrlog::AgentLog.new(file)
log.load()

puts "#{log.sessions.size} sessions started"

count = 0

log.sessions.each do |session|
  count += 1
  puts ""
  puts "[Session #{count}]"
  puts "#{session.transaction_count} transactions started"
  instrumentation = session.weaved
  if instrumentation.size > 0
    puts "Instrumentation"
    puts "---------------"
    session.weaved.to_a().sort().each do |pkg|
      puts pkg
    end
  else
    puts "*** No Instrumentation Modules Loaded ***"
  end
  
  extensions = session.extensions
  if extensions.size > 0
    puts ""
    puts "Extensions (not loaded initially)"
    puts "---------------------------------"
    session.extensions.to_a().sort().each do |pkg|
      puts pkg
    end
  end
end