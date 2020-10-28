require 'bundler'
require 'json'
require 'net/http'

Encoding.default_internal = Encoding::UTF_8
Encoding.default_external = Encoding::UTF_8

Bundler.require :default

path = File.expand_path '../../', __FILE__
PATH = path

APP_ENV = ENV["RACK_ENV"] || "development"

Oj.default_options = { mode: :compat }

API_ENDPOINT = "https://covid.ourworldindata.org/data"

require "#{PATH}/lib/stats"

require "#{PATH}/tasks/stats_dl"
require "#{PATH}/tasks/transform"
