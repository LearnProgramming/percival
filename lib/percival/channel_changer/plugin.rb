
class User

  roles = [:channel => ["colwem", "jfredett"]]
  
  def role? role
    roles[role].include? self
  end
end


class ChannelChangerPlugin
  include Cinch::Plugin

  match /join-channel\s+(\S+)/, :method => :join
  match /leave-channel(\s+(\S+))?/, :method => :leave
    
  #TODO: get rid of the 'space' var
  #TODO: inform if there is an error
  def leave irc, space, channel
    if irc.user.role? :channel
      channel = channel.nil? ? irc.channel : Channel(channel)
      bot.part(channel) 
    end
  end
  
  #TODO: inform if there is an error
  def join irc, channel
    Channel(channel).join() if irc.user.role? :channel
  end

  private 
  
  #TODO: how do we manange user privilages concerning the bot
  def channel_changer_user
    User("colwem")
  end
  
end
 


