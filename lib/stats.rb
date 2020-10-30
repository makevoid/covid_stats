class Stats

  REGIONS = %i(
    europe
    australia
    usa
    asia
    south_america
  )

  DATA_DEATHS_7D           = "#{PATH}/data/data.json"
  DATA_DEATHS_7D_EUROPE    = "#{PATH}/data/europe.json"
  DATA_DEATHS_7D_AUS       = "#{PATH}/data/australia.json"
  DATA_DEATHS_7D_USA       = "#{PATH}/data/usa.json"
  DATA_DEATHS_7D_ASIA      = "#{PATH}/data/asia.json"
  DATA_DEATHS_7D_S_AMERICA = "#{PATH}/data/south_america.json"

  @@data = {}
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
    data = {}
    REGIONS.each do |region|
      region_data = JSON.parse File.read "#{PATH}/data/#{region}.json"
      data[region] = header + region_data
    end
    data
  end

  def self.data
    @@data ||= load_data
  end

  def self.header
    [ ['Country', '# of deaths - 7 days'] ]
  end

  def self.all
    data
  end

end
