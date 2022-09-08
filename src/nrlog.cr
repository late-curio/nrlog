# TODO: Write documentation for `Nrlog`
module Nrlog
  VERSION = "0.1.0"
  file = "newrelic_agent.log"
  if ARGV.size() > 0
      file = ARGV[0]
  end
  weaved = Set(String).new()
  transaction_count = 0
  transaction_activity = Array(String).new()
  File.each_line(file) do |line|
      if line.includes?("weaved")
          i = line.index(".instrumentation.")
          if i 
              j = line.index(":", offset: i)
              if j
                  weaved.add(line[(i + 17)..(j - line.size- 1)])
              end  
          end
      end
      if line.includes?("TransactionActivity@") && line.includes?("starting")
          transaction_count += 1
      end
  end
  puts "#{transaction_count} transactions started"
  weaved.to_a().sort().each do |pkg|
      puts pkg
  end
end
