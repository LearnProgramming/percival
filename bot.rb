#!/usr/bin/env ruby

require 'rubygems'
require File.expand_path('../lib/percival', __FILE__)

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'irc.freenode.net'
    c.channels = ['#lpmc-bot']
    c.nick = 'percival'
    c.plugins.plugins = [Hello]
  end
end

bot.start
