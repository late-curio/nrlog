
file = "newrelic_agent.log"
if ARGV.size() > 0
    file = ARGV[0]
end
weaved = Set(String).new()
File.each_line(file) do |line|
    if line.includes?("weaved")
        i = line.index(".instrumentation.")
        if i 
            j = line.index(":", offset: i)
            if j
                weaved.add(line[(i + 17)..(j - line.size- 1)])
                # weaved.add(line)
            end  
        end
    end
end
weaved.to_a().sort().each do |pkg|
    puts pkg
end