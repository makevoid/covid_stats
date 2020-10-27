class Stats

  DATA_DEATHS_7D = "#{PATH}/data/europe.json"

  @@data = nil

  def initialize
  end

  def self.data=(new_data)
    @@data = new_data
  end

  def self.load_data
    JSON.parse File.read DATA_DEATHS_7D
  end

  def self.data
    @@data || load_data
  end

  def self.header
    [ ['Country', '# of deaths - 7 days'] ]
  end

  def self.all
    data = self.data
    header + data
  end

end
