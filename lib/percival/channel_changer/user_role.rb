class UserRole
  @test_users = ["colwem", "jfredett"]
  @roles = {
    super_user: @test_users,
    channel_changer: @test_users,
    name_changer: @test_users}

  def self.approved?(user, role)
    user = user.name if user.is_a? Cinch::User
    raise "user not in String, Cinch::User" unless user.is_a? String
    @roles[role].include? user
  end
end
