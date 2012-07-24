class NameChangerPlugin
  include Cinch::Plugin

  match /change-name\s+(\S+)/, :method => :change_name

  def change_name irc, name
    debug "I was at least called"
    if UserRole.approved? irc.user, :name_changer
      debug "I got here"
      bot.nick = name
    end
  end
end
