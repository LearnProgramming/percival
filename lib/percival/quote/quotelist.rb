class Quotelist
  def self.record(user, quote, reader=File)
    self.check_reader_validity(reader)
    reader.open(quotelist_path(user), 'a') do |f|
      f << quote + "\n"
    end
  end

  def self.get_random_quote()
    file = Dir.glob(PERCIVAL_ROOT + path_to_quotelists + '*').sample
    if file.nil?
      raise "No quotes found"
    end
    get_random_line file
  end

  def self.get_quote_by(user)
    get_random_line(quotelist_path user)
  end

  def self.quotelist_path(user)
    PERCIVAL_ROOT + path_to_quotelists + user.to_s
  end

  def self.path_to_quotelists
    "/data/quotelists/" 
  end

  private

  def self.get_random_line(file)
    File.readlines(file).sample
  end

  def self.check_reader_validity(reader)
    raise "Reader dependency must respond to #open" unless reader.respond_to? :open
    raise "Reader dependency must respond to #read" unless reader.respond_to? :read
    raise "Reader dependency must respond to #exists?" unless reader.respond_to? :exists?
  end

end

