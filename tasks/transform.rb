#!/usr/bin/env ruby

module Tasks

  Filters = {}
  Transforms = {}

  Filters[:filter_europe] = -> (region, details) { details["continent"] == "Europe" }

  Filters[:filter_russia] = -> (region, details) {
    country = details["location"]
    country != "Russia"
  }

  Transforms[:transform_data] = -> (region, details) {
    country = details["location"]
    # stat = details["data"].fetch(-1).fetch "new_deaths" # yesterday
    stat = details["data"][-8..-1]
    stat = stat.sum{ |data| data["new_deaths"] } # 7 days
    [country, stat]
  }

  TF_INPUT_DATA  = "data/data.json"
  TF_OUTPUT      = "data/europe.json"

  Transform = -> {
    path = File.expand_path "../../", __FILE__

    data = File.read TF_INPUT_DATA
    data = JSON.parse data

    data.select! &Filters[:filter_europe]
    data.select! &Filters[:filter_russia] # unfortunately russia has data of the whole continent, see Russia in Asia map (soon)
    data = data.map &Transforms[:transform_data]

    File.open(TF_OUTPUT, "w"){ |f| f.write data.to_json }
  }

end

if __FILE__ == $0
  require 'json'
  Tasks::Transform.()
end
