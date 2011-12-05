class Timesheet
  def self.entry(user, type, reader=File)
    raise "Reader dependency must respond to #open" unless reader.respond_to? :open

    new(user, reader).clock(type)
  end

  def clock(type)
    write_to_timesheet(Tick.send(type).dump)
  end

  private

  attr_accessor :user, :reader

  def initialize(user, reader)
    @user = user
    @reader = reader
  end

  def write_to_timesheet(string)
    #dirty hack -- there should be a way to get File to do this...
    # -- jgf 12/05/11
    system "touch #{timesheet_path}"
    reader.open(timesheet_path, 'w') do |f|
      f << string
    end
    self
  end

  def timesheet_path
    PERCIVAL_ROOT + path_to_timesheets + user.to_s
  end

  def path_to_timesheets
    "/data/timesheets/" 
  end
end
