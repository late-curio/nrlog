require "./extension"
require "./instrumentation"

file = "newrelic_agent.log"
if ARGV.size() > 0
  file = ARGV[0]
end
weaved = Set(String).new()
extensions = Set(String).new()
transaction_count = 0
transaction_activity = Array(String).new()
File.each_line(file) do |line|
  if Instrumentation.weaved?(line)
    weaved.add(Instrumentation.parse(line))
  end
  if Extension.weaved?(line)
    extensions.add(Extension.parse(line))
  end
  if line.includes?("TransactionActivity@") && line.includes?("starting")
    transaction_count += 1
  end
end
puts "#{transaction_count} transactions started"
puts ""
puts "Instrumentation"
puts "---------------"
weaved.to_a().sort().each do |pkg|
  puts pkg
end
puts ""
puts "Extensions (not loaded initially)"
puts "---------------------------------"
extensions.to_a().sort().each do |pkg|
  puts pkg
end