require 'spec_helper'

describe "Clock class methods" do
  subject { Clock }
  
  describe ".reset!(user)" do
    it "takes a single user as an argument" do
      expect { subject.reset!("foo") }.should_not raise_error
    end
  end

  describe ".for(user)" do
    it "takes a single user as an argument" do
      expect { subject.for("foo") }.should_not raise_error
    end
  end

  describe ".in" do
    it "takes no arguments" do
      expect { subject.in }.should_not raise_error
    end
  end

  describe ".out" do
    it "takes no arguments" do
      expect { subject.out }.should_not raise_error
    end
  end
end


describe "Using the !clock command to clock in and out" do
  before { Clock.reset!("test_user") }
  let(:channel) do 
    IrcFaker.new(cinch_mock)
  end

  let(:cinch_mock) do
    mock(:cinch).tap do |m|
      m.stub!(:reply)
    end
  end
  

  it "allows me to clock in by sending the message `!clock in` to the channel" do
    channel.
      send_message("!clock in").
      as("test_user").
    done

    Clock.for("test_user").should =~ [Clock.in]
  end

  it "allows me to clock out by sending the message `!clock out` to the channel" do
    channel.
      send_message("!clock in").
      as("test_user").
    done
    Clock.for("test_user").should =~ [Clock.in]

    channel.
      send_message("!clock out").
      as("test_user").
    done
    Clock.for("test_user").should =~ [Clock.in, Clock.out]
  end

  pending "design" do
    it "allows for review and editing of times for a given day"

    it "messages you if your time is out of the ordinary via email"
  end
end

