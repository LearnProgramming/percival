class Clock
  def for(username)
    (timesheet_manager.for(username) || []).sort
  end

  def clock_in(username)
    timesheet_manager.entry(username, :in)
  end

  def clock_out(username)
    timesheet_manager.entry(username, :out)
  end

  def initialize(timesheet_manager = Timesheet)
    @timesheet_manager = timesheet_manager
  end

  private

  attr_reader :timesheet_manager
end
