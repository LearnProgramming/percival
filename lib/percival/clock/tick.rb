class Tick
  def new(time, type)
    @time = time
    @type = type
  end

  def self.in
    new(Time.now, :in)
  end

  def self.out
    new(Time.now, :out)
  end
end
