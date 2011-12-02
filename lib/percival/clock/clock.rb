class Clock
  def self.reset!(user_name)

  end

  def self.for(user_name)
    []
  end

  def clock_in(username)
    Timesheet.entry(username, :in)
  end

  def clock_out(username)
    Timesheet.entry(username, :out)
  end

  def execute(irc, status)
    case status
    when "in"
      clock_in(irc.user)
    when "out"
      clock_out(irc.user)
    else
      irc.reply "USAGE: !clock <in|out>"
    end
  end
end
