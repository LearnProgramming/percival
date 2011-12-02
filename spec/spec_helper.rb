require 'rspec'

require './lib/percival' 

class IrcFaker
  def initialize(irc_mock)
    @irc_mock = irc_mock
  end
  
  def send_message(msg)
    msg_params = msg.gsub(/^!/,'').split(' ')
    @command = msg_params.first.capitalize #this could be turned into the class...
    msg_params.shift
    @message_args = msg_params
    self
  end

  def as(sender)
    @sender = sender
    self
  end

  def done
    @irc_mock.stub!(:user).and_return(@sender) #a sort of lo-fi mock of the Cinch "user" object
    Clock.new.execute(@irc_mock, *@message_args)
    nil
  end
end
