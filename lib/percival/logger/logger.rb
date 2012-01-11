require 'singleton'
class Logger
  def initialize
    @file = File.open(PERCIVAL_ROOT + '/data/log', 'a')
  end

  def log(user, message)
    @file << "#{user}: #{message}\n"
    @file.flush
  end
end
