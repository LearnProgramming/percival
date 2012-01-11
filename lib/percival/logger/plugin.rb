class LoggerPlugin
  include Cinch::Plugin

  prefix ""
  match /(.*)/

  def execute(irc, message)
    @logger ||= Logger.new
    log(irc.user, message)
  end

  def intiialize
    super
  end


  def log(user, message)
    @logger.log(user, message)
  end
end
