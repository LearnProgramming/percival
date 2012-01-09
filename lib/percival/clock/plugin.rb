class ClockPlugin
  include Cinch::Plugin

  match /clock (.+)/

  def execute(irc, subcommand, *args)
    begin 

      case subcommand 

      when "in"
        Clock.new.clock_in(irc.user)
      when "out"
        Clock.new.clock_out(irc.user)
      when "summary"
        subsubcommand = args.shift
        case subsubcommand
        when '--'
          summary_create(*args)
        when '--since'
          summary_since(Date.parse(args.shift))
        else
          summary_since(1.week.ago)
        end
      else
        irc.reply "USAGE: !clock <in|out>"
      end

    rescue InvalidTimesheetSequence
      irc.reply "You are already clocked #{status}."
    end
  end
    
end
