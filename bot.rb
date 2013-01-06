#!/usr/bin/env ruby

require 'rubygems'
require 'cinch'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'irc.freenode.net'
    c.channels = ['#lpmc-bot']
    c.nick = 'percival'
    c.plugins.plugins = []
  end
end

bot.start
