require 'rspec'

require './lib/percival' 

require './spec/support/irc_faker'


RSpec.configure do |config|
  config.before :suite do
    #make timesheet call into a test directory instead of the real thing
    class Timesheet
      alias_method :old_path_to_timesheets, :path_to_timesheets
      def path_to_timesheets
        "/spec/data/timesheets/"
      end
    end
  end

  config.after :suite do
    Dir[PERCIVAL_ROOT + '/spec/data/timesheets/*'].each { |file| File.delete(file) } 
  end
end
