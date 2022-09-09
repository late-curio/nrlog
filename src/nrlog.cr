require "./extension"
require "./instrumentation"
# TODO: Write documentation for `Nrlog`
module Nrlog
  VERSION = "0.1.0"

  class AgentLog
    getter sessions
    def initialize(filename : String)
      @filename = filename
      @sessions = Array(AgentSession).new
    end

    def load()
      session = AgentSession.new()
      count = 0
      @sessions.push(session)

      File.each_line(@filename) do |line|
        if start_session?(line)
          if count > 0
            session = AgentSession.new()
            @sessions.push(session)
          end  
          count += 1
        end
        if session
          if Instrumentation.weaved?(line)
            session.weaved.add(Instrumentation.parse(line))
          elsif Extension.weaved?(line)
            session.extensions.add(Extension.parse(line))
          elsif line.includes?("TransactionActivity@") && line.includes?("starting")
            session.increment_transaction_count
          end
        end
      end
    end

    private def start_session?(line : String)
      line.includes?("Writing to New Relic log file:")
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
