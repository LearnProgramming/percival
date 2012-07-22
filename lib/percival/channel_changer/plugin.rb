class ChannelChangerPlugin
  include Cinch::Plugin

  match /!join-channel\s+(\S+)/, :method => :join
  match /!leave-channel(\s+(\S+))?/, :method => :leave
    
  
  def leave msg, space, channel
    channel = channel.nil? ? irc.channel : Channel(channel)
    channel.kick(bot.user)
  end
  
  def join msg, channel
    print "here is channel #{channel}\n"
    Channel(channel).join()
  end
  
  # def switch msg
  #   leave msg
  #   join msg
  # end
  

  private 

  def channel_changer_user
    User("colwem")
  end
  
end
