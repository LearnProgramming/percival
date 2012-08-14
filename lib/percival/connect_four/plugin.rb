class ConnectFourPlugin
  include Cinch::Plugin

  def initialize *args
    super
    @games = { }
  end
  
  match /cf\s+(\S+)?/, :method => :connect_four

  def connect_four m, command
    if /new/.match command
      @games[m.user.name] = ConnectFour.new 7,6
      m.reply "Awaiting your move sir"
    elsif /[1-7]/.match command 
      @games[m.user.name] ||= ConnectFour.new 7,6
      m.reply @games[m.user.name].your_move(command.to_i - 1)
      m.reply @games[m.user.name].my_move 
    else
      m.reply "command must be in [new|[1-7]]"
    end
  end
end
