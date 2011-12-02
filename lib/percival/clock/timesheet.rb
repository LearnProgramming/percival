class Timesheet
  def self.entry(user, type)
    new(user).clock(type)
  end

  def clock(type)
    Tick.send(type)
    self
  end

  def initialize(*args)
  end
end
