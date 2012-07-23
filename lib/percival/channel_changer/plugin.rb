#TODO: catch name of bot and confirm that message was for me
class ChannelChangerPlugin
  include Cinch::Plugin
  
  @@roles = {channel: ["colwem", "jfredett"]}  
  
  match /join-channel\s+(\S+)/, :method => :join
  match /leave-channel(\s+(\S+))?/, :method => :leave
  
  #TODO: get rid of the 'space' var
  #TODO: inform if there is an error
  def leave irc, space, channel
    if role? irc.user, :channel
      channel = channel.nil? ? irc.channel : Channel(channel)
      bot.part(channel) 
    end
  end

  #TODO: confirm success or failure
  #TODO: inform if there is an error
  def join irc, channel
    Channel(channel).join() if role? irc.user, :channel
  end
  
  def role? user, role
    @@roles[role].map {|u| User(u)}.include? user
  end
end



