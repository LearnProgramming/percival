require 'spec_helper'

describe Timesheet do #class methods
  subject { Timesheet } 
  
  let(:reader) { mock("reader").tap { |r| r.stub!(:open) ; r.stub!(:read) ; r.stub!(:exists?).and_return(true) } }
  let(:invalid_reader) { mock("invalid reader") }

  it { should respond_to :entry }
  describe "#entry" do
    it "should take a username and a tick-type as an argument to .entry" do
      expect { subject.entry('test_user', :in, reader) }.to_not raise_error
      expect { subject.entry('test_user', :out, reader) }.to_not raise_error
    end

    it "optionally expects a dependency which responds to #open and #read" do
      expect { subject.entry('test', :in, reader) }.to_not raise_error
      expect { subject.entry('test', :in, invalid_reader) }.to raise_error
    end

    it "should throw an error if you try to make the same entry type twice in a row" do
      fake_data_after_clockin =<<-HERE
--- !ruby/object:Tick
time: 2011-12-06 08:19:22.174495000 -05:00
type: :out

--- !ruby/object:Tick
time: 2011-12-06 08:23:00.546090000 -05:00
type: :in

      HERE

      expect do
        reader.should_receive(:read).with(anything).and_return(fake_data_after_clockin)
        reader.stub(:read).and_return(fake_data_after_clockin)

        subject.entry('test', :in, reader)
      end.to raise_error InvalidTimesheetSequence
    end
  end

  describe "#clock" do
    it "should write the tick to the user's timesheet" do
      reader.should_receive(:open).with(PERCIVAL_ROOT + '/data/timesheets/test', 'a')

      subject.entry('test', :in, reader) # this feels a little wrong, it calls clock internally
    end
  end
end

