require 'singleton'
require 'forwardable'
class Logger
  extend Forwardable

  def initialize
    #since we're keeping a persistent connection, we need
    #to remember to close the file when the object dies.
    ObjectSpace.define_finalizer(self, proc { flush ; close })
  end

  delegate [:flush, :close] => :file

  def log(user, message, event)
    file << "%s | %8s | %s: %s\n" % [iso_standard_time, event, user, message]
  end

  private 

  def file
    @file ||= File.open(PERCIVAL_ROOT + '/data/log', 'a')
  end

  def iso_standard_time
    Time.now.strftime("%F %T")
  end
end
