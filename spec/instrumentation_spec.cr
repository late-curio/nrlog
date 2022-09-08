require "./spec_helper"
require "../src/instrumentation"

describe Instrumentation do
  extension = "# 2022-08-01T16:51:24,257+0000 [42259 143] com.newrelic FINER: Weave extension jars: {/opt/newrelic-7.9.0/extensions-autoappprops/syn-integration-newrelic-autoappprops.jar=1659117056000}"
  line = "[22689 50] com.newrelic FINE: com.newrelic.instrumentation.hibernate-4.3: weaved target java.net.URLClassLoader@1bdaa23d-org/hibernate/internal/SessionImpl"
  it "recognizes line where instrumentation is 'weaved'" do
    Instrumentation.weaved?(line).should eq(true)
  end
  it "parses out module name correctly" do
    Instrumentation.parse(line).should eq("hibernate-4.3")
  end
end
