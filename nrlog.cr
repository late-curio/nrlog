weaved = Set(String).new()
File.each_line("newrelic_agent.log") do |line|
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