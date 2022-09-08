require "./spec_helper"
require "../src/extension"

describe Extension do
  extension = "# 2022-08-01T16:51:24,257+0000 [42259 143] com.newrelic FINER: Weave extension jars: {/opt/newrelic-7.9.0/extensions-autoappprops/syn-integration-newrelic-autoappprops.jar=1659117056000}"
  it "recognizes line where extension is 'weaved'" do
    Extension.weaved?(extension).should eq(true)
  end
  it "parses out extension name correctly" do
    Extension.parse(extension).should eq("syn-integration-newrelic-autoappprops")
  end
end
