#!/usr/bin/env ruby

path = File.expand_path "../../", __FILE__

puts "- downloading the data..."
puts system "curl https://covid.ourworldindata.org/data/owid-covid-data.json > #{path}/tmp/owid-covid-data.json "
puts "\n- updating the data file..."
puts system "mv #{path}/tmp/owid-covid-data.json #{path}/data/data.json"
