class UserRole
  @@test_users = ["colwem", "jfredett"]
  @@roles = {
    super_user: @@test_users,
    channel_changer: @@test_users,
    name_changer: @@test_users}

  #TODO: figure out how the various names work on irc (authname, nick,
  #realname )  Whats the difference between a user and his nick and authname
  def self.approved?(user, role)
    if user.is_a? Cinch::User
      user = user.name
    elsif ! user.is_a? String
      throw "user was not a valid type [String, User]" # TODO: raise
      # better Exception
    end
    @@roles[role].include? user #or @@roles[:super_user].include? user 
  end
end
