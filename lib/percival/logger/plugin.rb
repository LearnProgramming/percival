require 'forwardable'
class LoggerPlugin
  include Cinch::Plugin
  extend Forwardable

  listen_to(
    :join, :leaving, 
    :message, 
    :op, :deop, :halfop, :dehalfop, :owner, :deowner,
    :ban, :unban,
    :kick, 
    :away, :unaway,
    :voice, :devoice 
  )

  timer 15, method: :flush

  def listen(irc)
    log(irc.user, irc.message, irc.command)
  end

  private 

  delegate [:flush, :log] => :logger

  def logger
    @logger ||= Logger.new 
  end
end
