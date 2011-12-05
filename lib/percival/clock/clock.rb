class Clock
  def self.reset!(user_name)

  end

  def self.for(user_name)
    []
  end

  def clock_in(username)
    timesheet_manager.entry(username, :in, )
  end

  def clock_out(username)
    timesheet_manager.entry(username, :out)
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

  def initialize(timesheet_manager = Timesheet)
    @timesheet_manager = timesheet_manager
  end

  private
  attr_reader :timesheet_manager
end
