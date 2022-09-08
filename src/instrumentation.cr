module Instrumentation
  def self.weaved?(input : String) : Bool
    input.includes?("weaved") && input.includes?(".instrumentation.")
  end
  def self.parse(input : String) : String
    j = line.index(":", offset: i)
    if j
      return line[(i + 17)..(j - line.size- 1)]
    end
  end
end