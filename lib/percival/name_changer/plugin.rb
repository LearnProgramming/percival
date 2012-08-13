class NameChangerPlugin
  include Cinch::Plugin

  match /change-name\s+(\S+)/, :method => :change_name

  def change_name( irc, name )
    if UserRole.approved? irc.user, :name_changer
      bot.nick = name
    end
  end
end
