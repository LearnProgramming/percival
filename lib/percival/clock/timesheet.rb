class Timesheet
  def self.entry(user, type)
    new(user).clock(type)
  end

  def clock(type)
    Tick.send(type)
    self
  end

  private

  attr_reader :user

  def initialize(user)
    @user = user

    #dirty hack -- there should be a way to get File to do this...
    # -- jgf 12/05/11
    system "touch #{timesheet_path}"

    @timesheet = File.open(timesheet_path)
  end

  def timesheet_path
    PERCIVAL_ROOT + path_to_timesheets + user.to_s
  end

  def path_to_timesheets
    "/data/timesheets/" #this gets monkeypatched for tests 
  end
end
