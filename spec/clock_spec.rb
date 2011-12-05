require 'spec_helper'

describe Clock do

  let(:cinch_mock) { 
    mock(:cinch).tap do |m|
      m.stub!(:reply)
    end
  }

  let(:timesheet) { mock("timesheet class").tap { |t| t.stub!(:entry) } }

  subject { Clock.new(timesheet) } 

  it { should respond_to :clock_in }
  describe "#clock_in" do
    it "takes a username as an argument" do
      expect { subject.clock_in("test_username") }.should_not raise_error
    end

    it "should create a tick on the user's timesheet" do
      timesheet.
        should_receive(:entry).
        with('test_user', :in)

      subject.clock_in('test_user')
    end
  end

  it { should respond_to :clock_out }
  describe "#clock_out" do
    it "takes a username as an argument" do
      expect { subject.clock_out("test_username") }.should_not raise_error
    end

    it "should create a tick on the user's timesheet" do
      timesheet.
        should_receive(:entry).
        with('test_user', :out)
      subject.clock_out('test_user')
    end
  end

  it { should respond_to :execute }
  describe "#execute(m, type)" do

    it "takes at least two arguments for execute" do
      expect { subject.execute(cinch_mock, "subcommand") }.should_not raise_error
    end

    it "should clock you in when you pass it the type 'in'" do
      subject.should_receive(:clock_in).with('test_user')
      cinch_mock.stub!(:user).and_return('test_user')
      subject.execute(cinch_mock, 'in') 
    end

    it "should clock you out when you pass it the type 'out'" do
      subject.should_receive(:clock_out).with('test_user')
      cinch_mock.stub!(:user).and_return('test_user')
      subject.execute(cinch_mock, 'out') 
    end

    it "should respond with a usage message if you try to use an invalid type" do
      cinch_mock.stub!(:user).and_return('test_user')
      cinch_mock.should_receive(:reply).with("USAGE: !clock <in|out>")
      subject.execute(cinch_mock, 'flurble') 
    end
  end
end

describe Clock do #class methods
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

    it "should return an empty list if no ticks are present" do
      subject.for("foo").should == []
    end

    it "returns all the clock-tick objects for a given user" 

    it "returns the tick object in chronological order"

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

  subject { Clock } 

  it "allows me to clock in by sending the message `!clock in` to the channel" do
    plugin_instance = subject.new
    plugin_instance.should_receive(:clock_in).with('test_user')
    channel.
      plugins(plugin_instance).
      send_message("!clock in").
      as("test_user").
    run!
  end

  it "allows me to clock out by sending the message `!clock out` to the channel" do
    plugin_instance = subject.new
    plugin_instance.should_receive(:clock_out).with('test_user')

    channel.
      plugins(plugin_instance).
      send_message("!clock out").
      as("test_user").
    run!
  end

  it "tells me the command usage information if I pass an incorrect subcommand" do
    cinch_mock.should_receive(:reply).with("USAGE: !clock <in|out>")
    channel.
      plugins(subject.new).
      send_message("!clock WRONG").
      as("test_user").
    run!
  end

  pending "design" do
    it "allows for review and editing of times for a given day"

    it "messages you if your time is out of the ordinary via email"
  end
end

