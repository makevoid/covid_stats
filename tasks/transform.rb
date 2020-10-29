#!/usr/bin/env ruby

module Tasks

  Filters = {}
  Transforms = {}

  Filters[:filter_europe] = -> (region, details) { details["continent"] == "Europe" }
  Filters[:filter_usa]    = -> (region, details) { details["continent"] == "North America" }
  Filters[:filter_aus]    = -> (region, details) { details["continent"] == "Oceania" }
  Filters[:filter_asia]   = -> (region, details) { details["continent"] == "Asia" }

  Filters[:filter_russia] = -> (region, details) {
    country = details["location"]
    country != "Russia"
  }

  Transforms[:transform_data] = -> (region, details) {
    country = details["location"]
    # stat = details["data"].fetch(-1).fetch "new_deaths" # yesterday
    stat = details["data"][-8..-1]
    stat = stat.sum{ |data| data["new_deaths"] || 0 } # 7 days
    [country, stat]
  }

  PATH = File.expand_path "../../", __FILE__
  TF_INPUT_DATA  = "#{PATH}/data/data.json"


  TransformEurope = -> {
    outputFile = "#{PATH}/data/europe.json"
    data = File.read TF_INPUT_DATA
    data = JSON.parse data

    data.select! &Filters[:filter_europe]

    data = data.map &Transforms[:transform_data]
    File.open(outputFile, "w"){ |f| f.write data.to_json }
  }

  TransformAus = -> {
    outputFile = "#{PATH}/data/australia.json"
    data = File.read TF_INPUT_DATA
    data = JSON.parse data

    data.select! &Filters[:filter_aus]

    data = data.map &Transforms[:transform_data]
    File.open(outputFile, "w"){ |f| f.write data.to_json }
  }

  TransformUsa = -> {
    outputFile = "#{PATH}/data/usa.json"
    data = File.read TF_INPUT_DATA
    data = JSON.parse data

    data.select! &Filters[:filter_usa]

    data = data.map &Transforms[:transform_data]
    File.open(outputFile, "w"){ |f| f.write data.to_json }
  }

  TransformAsia = -> {
    outputFile = "#{PATH}/data/asia.json"
    data = File.read TF_INPUT_DATA
    data = JSON.parse data

    data.select! &Filters[:filter_asia]

    data = data.map &Transforms[:transform_data]
    File.open(outputFile, "w"){ |f| f.write data.to_json }
  }


  AllTransforms = -> {
    TransformEurope.()
    TransformAus.()
    TransformUsa.()
    TransformAsia.()
  }

end

if __FILE__ == $0
  require 'json'
  Tasks::AllTransforms.()
end
