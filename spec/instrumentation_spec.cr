require "./spec_helper"
require "../src/instrumentation"

describe Instrumentation do
  line = "[22689 50] com.newrelic FINE: com.newrelic.instrumentation.hibernate-4.3: weaved target java.net.URLClassLoader@1bdaa23d-org/hibernate/internal/SessionImpl"
  it "recognizes line where instrumentation is 'weaved'" do
    Instrumentation.weaved?(line).should eq(true)
  end
  it "parses out module name correctly" do
    Instrumentation.parse(line).should eq("hibernate-4.3")
  end
end
