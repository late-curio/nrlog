module Extension
  def self.weaved?(input : String) : Bool
    input.includes?("Weave extension jars:")
  end
  def self.parse(input : String) : String
    i = input.index(".jar")
    if i
      j = input.rindex("/", i)
      if j
        return input[j + 1, i - j - 1]
      end
    end
    ""
  end
end