class Stats

  DATA_DEATHS_7D_EUROPE = "#{PATH}/data/europe.json"
  DATA_DEATHS_7D_AUS    = "#{PATH}/data/australia.json"
  DATA_DEATHS_7D_USA    = "#{PATH}/data/usa.json"
  DATA_DEATHS_7D_ASIA    = "#{PATH}/data/asia.json"
  DATA_DEATHS_7D = DATA_DEATHS_7D_ASIA

  @@data = nil
  @@data_timestamp = nil

  def initialize
  end

  def self.data_timestamp=(new_timestamp)
    @@data_timestamp = new_timestamp
  end

  def self.get_data_timestamp
    %x{stat -c '%y' #{DATA_DEATHS_7D}}.strip
  end

  def self.data_timestamp
    @@data_timestamp ||= get_data_timestamp
  end

  def self.data=(new_data)
    @@data = new_data
  end

  def self.load_data
    JSON.parse File.read DATA_DEATHS_7D
  end

  def self.data
    @@data ||= load_data
  end

  def self.header
    [ ['Country', '# of deaths - 7 days'] ]
  end

  def self.all
    data = self.data
    header + data
  end

end
