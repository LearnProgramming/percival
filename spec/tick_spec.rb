require 'spec_helper'

describe Tick do
  subject { Tick.in } 

  describe "==" do
    it { should == subject } 

    it "should equal an equivalent tick" do
      time = Time.now
      Tick.new(time, :in).should == Tick.new(time, :in)
    end

    it "should not be equal to a tick of a different type" do
      Tick.in.should_not == Tick.out
    end

    it "should not be equal to a tick of the same type with a different time" do 
      tick1 = Tick.in
      tick2 = Tick.new(Time.now + 1, :in)
      tick1.should_not == tick2
    end
  end

  describe "<=>" do
    it "determines inequality by timestamp" do
      Tick.new(Time.now + 50, :in).should be > Tick.new(Time.now - 50, :out)
    end
  end
end

describe Tick do #class methods
  subject { Tick } 

  describe ".parse" do 
    it "is the inverse of #dump" do
      tick = Tick.in
      Tick.parse(tick.dump).should == tick

      tick = Tick.out
      Tick.parse(tick.dump).should == tick
    end
  end

  describe ".in" do
    it "takes no arguments" do
      expect { subject.in }.to_not raise_error
    end
  end

  describe ".out" do
    it "takes no arguments" do
      expect { subject.out }.to_not raise_error
    end
  end
end
