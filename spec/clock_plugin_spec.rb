require 'spec_helper'


describe "The Clock plugin" do
  let(:channel) do 
    IrcFaker.new(cinch_mock)
  end

  let(:cinch_mock) do
    mock(:cinch).tap do |m|
      m.stub!(:reply)
      m.stub!(:user).and_return('test_user')
    end
  end

  let(:plugin_instance) do
    #This is f'd because Cinch is stupid, it requires some sort of phantom argument
    #to the initializer, which is braindead.
    ClockPlugin.new(mock('cinch_pleaser').as_null_object) 
  end 

  context "Using the !clock command to clock in and out" do
    subject { Clock.any_instance } 

    it "allows me to clock in by sending the message `!clock in` to the channel" do
      subject.should_receive(:clock_in).with('test_user')
      channel.
        plugins(plugin_instance).
        send_message("!clock in").
        as("test_user").
      run!
    end

    it "allows me to clock out by sending the message `!clock out` to the channel" do
      subject.should_receive(:clock_out).with('test_user')

      channel.
        plugins(plugin_instance).
        send_message("!clock out").
        as("test_user").
      run!
    end

    it "tells me the command usage information if I pass an incorrect subcommand" do
      cinch_mock.should_receive(:reply).with("USAGE: !clock <in|out>")

      channel.
        plugins(plugin_instance).
        send_message("!clock WRONG").
        as("test_user").
      run!
    end
  end

  context "The class itself"  do
    describe "instance methods" do
    
      subject { plugin_instance } 

      pending ":: waiting for design" do
        it "allows for review and editing of times for a given day"

        it "messages you if your time is out of the ordinary via email"
      end


      it { should respond_to :execute }
      describe "#execute(m, type)" do
        it "takes at least two arguments for execute" do
          expect { subject.execute(cinch_mock, "subcommand") }.to_not raise_error
        end

        it "should clock you in when you pass it the type 'in'" do
          Clock.any_instance.should_receive(:clock_in).with('test_user')
          subject.execute(cinch_mock, 'in') 
        end

        it "should clock you out when you pass it the type 'out'" do
          Clock.any_instance.should_receive(:clock_out).with('test_user')
          subject.execute(cinch_mock, 'out') 
        end

        it "should respond with a usage message if you try to use an invalid type" do
          cinch_mock.should_receive(:reply).with("USAGE: !clock <in|out>")
          subject.execute(cinch_mock, 'flurble') 
        end
      end
    end

    describe "class level constraints" do
      subject { ClockPlugin } 

      #Cinch doesn't open up much in the way of "respond to !clock command", but it
      #should be tested 
      its(:included_modules) { should include(Cinch::Plugin) }
    end
  end
end
