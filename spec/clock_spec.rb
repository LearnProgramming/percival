require 'spec_helper'

describe "Clock class methods" do
  subject { Clock }
  
  describe ".reset!(user)" do
    it "takes a single user as an argument" do
      expect { subject.reset!("foo") }.should_not raise_error
    end
  end

end


describe "Using the !clock command to clock in and out" do
  before { Clock.reset!("test_user") }

  it "allows me to clock in by sending the message `!clock in` to the channel" do
    channel.send_message("!clock in").as("test_user")
    Clock.for("test_user").should =~ [Clock.in("test_user")]
  end

  it "allows me to clock out by sending the message `!clock out` to the channel" do
    channel.send_message("!clock in").as("test_user")
    Clock.for("test_user").should =~ [Clock.in("test_user")]
    channel.send_message("!clock out").as("test_user")
    Clock.for("test_user").should =~ [Clock.in("test_user")]
  end

  pending "design" do
    it "allows for review and editing of times for a given day"

    it "messages you if your time is out of the ordinary via email"
  end
end

