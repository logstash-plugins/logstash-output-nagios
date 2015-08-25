# encoding: utf-8
require_relative "../spec_helper"

describe LogStash::Outputs::Nagios do

  it "should register without errors" do
    plugin = LogStash::Plugin.lookup("output", "nagios").new
    expect { plugin.register }.to_not raise_error
  end

  describe "send" do

    let(:properties) { { "message" => "This is a message!", "nagios_service" => "nagios_service", "nagios_host" => "nagios_host" } }
    let(:event)      { LogStash::Event.new(properties) }

    before(:each) do
      subject.register
      expect(subject).to receive(:commandfile?).and_return(true)
    end

    it "send the event to nagios" do
      expect(subject).to receive(:send_to_nagios)
      subject.receive(event)
    end
  end

end
