require "./spec_helper"

describe Nrlog do

  it "should read a sample log and get correct statistics" do
    log = Nrlog::AgentLog.new("./spec/logs/nr.log")
    log.load()
    session = log.first

    session.transaction_count.should eq 200
    session.weaved.size.should eq 7
    session.extensions.size.should eq 1
  end
end
