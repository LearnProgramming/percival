class UserRole

  @@roles = {channel: ["colwem", "jfredett"]}

  #TODO: figure out how the various names work on irc (authname, nick,
  #realname )  Whats the difference between a user and his nick and authname
  def self.approved?(user, role)
    if user.is_a? Cinch::User
      user = user.name
    elsif ! user.is_? String
      throw "user was not a valid type [String, User]" # TODO: raise
      # better Exception
    end
    @@roles[role].include? user 
  end
end
