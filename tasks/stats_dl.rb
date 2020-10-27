#!/usr/bin/env ruby

module Tasks
  API_ENDPOINT = "https://covid.ourworldindata.org/data" # TODO: deduplicate in a config.rb config file (present in env.rb already)

  StatsDL = -> {
    path = File.expand_path "../../", __FILE__

    puts "- downloading the data..."
    puts system "curl #{API_ENDPOINT}/owid-covid-data.json > #{path}/tmp/owid-covid-data.json "
    puts "\n- updating the data file..."
    puts system "mv #{path}/tmp/owid-covid-data.json #{path}/data/data.json"
  }

end


Tasks::StatsDL.() if __FILE__ == $0
