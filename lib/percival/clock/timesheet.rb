class Timesheet
  def self.entry(user, type, reader=File)
    raise "Reader dependency must respond to #open" unless reader.respond_to? :open
    raise "Reader dependency must respond to #read" unless reader.respond_to? :read

    new(user, reader).clock(type)
  end

  def clock(type)
    raise InvalidTimesheetSequence if type == previous_type
    write_to_timesheet(Tick.send(type).dump)
  end

  private

  attr_accessor :user, :reader

  def initialize(user, reader)
    @user = user
    @reader = reader
  end

  def write_to_timesheet(string)
    reader.open(timesheet_path, 'a') do |f|
      f << string
      f << '\n'
    end
    self
  end

  def timesheet_data 
    raw_data = reader.read(timesheet_path)
    return [] unless raw_data
    
    entries = []
    entry = ""
    raw_data.each_line do |line|
      if line =~ /^\s*$/
        entries << YAML.load(entry)
        entry = "" 
      else
        entry << line
      end
    end
    entries << YAML.load(entry) #catches the last entry on the list (one which is not trailed by an empty line)

    entries
  end

  def previous_type
    last_entry = (timesheet_data || []).sort.last
    #another minor hack -- I want a "only other instances of myself need to
    #access this for comparison purposes" protection level.
    last_entry && last_entry.send(:type) 
  end

  def timesheet_path
    PERCIVAL_ROOT + path_to_timesheets + user.to_s
  end

  def path_to_timesheets
    "/data/timesheets/" 
  end
end

class InvalidTimesheetSequence < Exception ; end
