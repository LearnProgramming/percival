class QuotePlugin
  include Cinch::Plugin

  match /quote (\w+) (.+)/, { :method => :record }
  match /quote\s*$/, { :method => :random }
  match /quote-by (\w+)/, { :method => :quote_by }

  def record(irc, user, quote)
    Quotelist.record(user, quote)
    irc.reply "Quote recorded for user " + user
  end

  def random(irc)
    irc.reply Quotelist.get_random_quote
  end

  def quote_by(irc, user)
    begin
      irc.reply(Quotelist.get_quote_by user)
    rescue Errno::ENOENT
      irc.reply "No quotes from that user yet"
    end
  end
    
end
