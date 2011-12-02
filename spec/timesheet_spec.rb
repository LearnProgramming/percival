require 'spec_helper'

describe Timesheet do #class methods
  subject { Timesheet } 
  
  it { should respond_to :entry }
  it "should take a username and a tick-type as an argument to .entry" do
    expect { subject.entry('test_user', :in) }.should_not raise_error
    expect { subject.entry('test_user', :out) }.should_not raise_error
  end

  
end

