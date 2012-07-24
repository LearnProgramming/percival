#TODO: catch name of bot and confirm that message was for me
class ChannelChangerPlugin
  include Cinch::Plugin
  
  
  match /join-channel\s+(\S+)/, :method => :join
  match /leave-channel(?:\s+(\S+))?/, :method => :leave

  listen_to :error, method: :error

  # TODO: respond to error codes
  def error irc
    debug( irc.to_s )
  end
  
  
  #TODO: get rid of the 'space' var
  #TODO: inform if there is an error
  def leave irc, channel
    if UserRole.approved? irc.user, :channel
      channel ||= irc.channel
      Channel(channel).part 
    end
  end

  #TODO: confirm success or failure
  #TODO: inform if there is an error
  def join irc, channel
    Channel(channel).join() if UserRole.approved? irc.user, :channel
  end
end



