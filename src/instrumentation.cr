module Instrumentation
  def self.weaved?(input : String) : Bool
    input.includes?("weaved") && input.includes?(".instrumentation.")
  end
  def self.parse(input : String) : String
    i = input.index(".instrumentation.")
    if i
      j = input.index(":", offset: i)
    end
    if i && j
      return input[(i + 17)..(j - input.size- 1)]
    end
    return ""
  end
end