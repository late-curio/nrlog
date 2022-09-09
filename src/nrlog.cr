require "./extension"
require "./instrumentation"
# TODO: Write documentation for `Nrlog`
module Nrlog
  VERSION = "0.1.0"

  class AgentLog
    getter sessions

    def initialize(filename : String)
      @filename = filename
      @sessions = Set(AgentSession).new()
    end

    def load()
      session = AgentSession.new()
      File.each_line(@filename) do |line|
        if Instrumentation.weaved?(line)
          session.weaved.add(Instrumentation.parse(line))
        end
        if Extension.weaved?(line)
          session.extensions.add(Extension.parse(line))
        end
        if line.includes?("TransactionActivity@") && line.includes?("starting")
          session.increment_transaction_count
        end
      end
      @sessions.add(session)
    end

    def first
      @sessions.first
    end
  end

  class AgentSession
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
