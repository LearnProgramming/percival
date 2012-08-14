
class ChannelChangerPlugin
  include Cinch::Plugin
    
  match /join-channel\s+(\S+)/, :method => :join
  match /leave-channel(?:\s+(\S+))?/, :method => :leave

  listen_to :error, method: :error
  
  def error irc
    debug( irc.to_s )
  end
  
  def leave( irc, channel )
    if UserRole.approved? irc.user, :channel_changer
      channel ||= irc.channel
      Channel(channel).part 
    end
  end

  def join( irc, channel )
    Channel(channel).join() if UserRole.approved? irc.user, :channel_changer
  end
end



