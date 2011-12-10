class ClockPlugin
  include Cinch::Plugin

  match /clock (.+)/

  def execute(irc, status)
    begin 
      case status
      when "in"
        Clock.new.clock_in(irc.user)
      when "out"
        Clock.new.clock_out(irc.user)
      else
        irc.reply "USAGE: !clock <in|out>"
      end
    rescue InvalidTimesheetSequence
      irc.reply "You are already clocked #{status}."
    end
  end
    
end
