require 'spec_helper'

describe Clock do
  let(:cinch_mock) { 
    mock(:cinch).tap do |m|
      m.stub!(:reply)
    end
  }

  let(:timesheet) {
    mock("timesheet class").tap { |t| 
      t.as_null_object
      t.stub!(:entry) 
      t.stub!(:for)
    } 
  }

  subject { Clock.new(timesheet) } 

  it { should respond_to :clock_in }
  describe "#clock_in" do
    it "takes a username as an argument" do
      expect { subject.clock_in("test_username") }.to_not raise_error
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
      expect { subject.clock_out("test_username") }.to_not raise_error
    end

    it "should create a tick on the user's timesheet" do
      timesheet.
        should_receive(:entry).
        with('test_user', :out)
      subject.clock_out('test_user')
    end
  end


  describe "#for(user)" do
    it "takes a single user as an argument" do
      expect { subject.for("foo") }.to_not raise_error
    end

    it "should return an empty list if no ticks are present" do
      timesheet.should_receive(:for).with('foo').and_return([])
      subject.for("foo").should == []
    end

    it "returns all the clock-tick objects for a given user" do
      timesheet.should_receive(:for).with('test_user') 
      subject.for('test_user')
    end

    it "returns the tick object in chronological order" do
      fake_times = [Tick.new(Time.now + 60, :out), Tick.new(Time.now - 60, :in)]
      timesheet.should_receive(:for).with('test_user').and_return(fake_times)
      subject.for('test_user').should == fake_times.reverse #the above times are in reverse order
    end
  end
end
