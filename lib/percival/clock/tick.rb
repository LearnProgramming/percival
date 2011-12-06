require 'yaml'
class Tick
  include Comparable

  def self.in
    new(Time.now, :in)
  end

  def self.out
    new(Time.now, :out)
  end

  def self.parse(s)
    YAML::load(s)  
  end
  alias_method :dump, :to_yaml

  def to_s 
    "#{time} #{type}"
  end
  alias_method :inspect, :to_s

  def ==(other)
    self.dump == other.dump
  end

  def <=>(other)
    time <=> other.send(:time) #a little bit cheaty
  end

  def initialize(time, type)
    @time = time
    @type = type
  end

  private 

  attr_accessor :time, :type
end
