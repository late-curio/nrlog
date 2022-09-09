require "./spec_helper"

describe Nrlog do

  it "works" do
    log = Nrlog::AgentLog.new("./spec/logs/nr.log")
    log.load()
    session = log.first

    session.transaction_count.should eq 200

  end
end
