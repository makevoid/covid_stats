#!/usr/bin/env ruby

require 'json'

path = File.expand_path "../../", __FILE__

INPUT_DATA  = "data/data.json"
OUTPUT      = "data/europe.json"

data = File.read INPUT_DATA
data = JSON.parse data

# ['Country', '# of deaths - 7 days'],
# ['Germany', 200],

filter_europe = -> (region, details) { details["continent"] == "Europe" }
filter_russia = -> (region, details) {
  country = details["location"]
  country != "Russia"
}
transform_data = -> (region, details) {
  country = details["location"]
  # stat = details["data"].fetch(-1).fetch "new_deaths" # yesterday
  stat = details["data"][-8..-1]
  stat = stat.sum{ |data| data["new_deaths"] } # 7 days
  [country, stat]
}

data.select! &filter_europe
data.select! &filter_russia
data = data.map &transform_data

File.open(OUTPUT, "w"){ |f| f.write data.to_json }
