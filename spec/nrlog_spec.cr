require "./spec_helper"

describe Nrlog do

  it "should read a sample log and get correct statistics" do
    log = Nrlog::AgentLog.new("./spec/logs/nr.log")
    log.load()


    log.sessions.size.should eq 2

    session = log.sessions[0]
    session.transaction_count.should eq 0
    session.weaved.size.should eq 4
    session.extensions.size.should eq 0

    session = log.sessions[1]
    session.transaction_count.should eq 200
    session.extensions.size.should eq 1
    session.weaved.size.should eq 7
  end
end
