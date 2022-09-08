require "./extension"
require "./instrumentation"
# TODO: Write documentation for `Nrlog`
module Nrlog
  VERSION = "0.1.0"

  def self.load(filename : String)
    log = AgentLog.new()
    File.each_line(filename) do |line|
      if Instrumentation.weaved?(line)
        log.weaved.add(Instrumentation.parse(line))
      end
      if Extension.weaved?(line)
        log.extensions.add(Extension.parse(line))
      end
      if line.includes?("TransactionActivity@") && line.includes?("starting")
        log.increment_transaction_count
      end
    end
    return log
  end

  class AgentLog
    getter weaved, extensions, transaction_count
    def initialize()
      @weaved = Set(String).new()
      @extensions = Set(String).new()
      @transaction_count = 0
    end
    def increment_transaction_count()
      @transaction_count += 1
    end
  end
end
