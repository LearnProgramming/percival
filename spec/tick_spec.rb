require 'spec_helper'

describe Tick do

end

describe Tick do #class methods
  subject { Tick } 

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
