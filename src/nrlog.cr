require "./extension"
require "./instrumentation"
# TODO: Write documentation for `Nrlog`
module Nrlog
  VERSION = "0.1.0"

  class AgentLog
    getter weaved, extensions, transaction_count
    def initialize(filename : String)
      @filename = filename
      @weaved = Set(String).new()
      @extensions = Set(String).new()
      @transaction_count = 0
    end

    def process()
      @transaction_count = 0
      File.each_line(@filename) do |line|
        if Instrumentation.weaved?(line)
          @weaved.add(Instrumentation.parse(line))
        end
        if Extension.weaved?(line)
          @extensions.add(Extension.parse(line))
        end
        if line.includes?("TransactionActivity@") && line.includes?("starting")
          @transaction_count += 1
        end
      end

    end
  end
end
