class Stats

  def initialize

    # "ABW":
    #     "continent": "North America",
    #     "location": "Aruba",
    #     "population": 106766.0,
    #     "population_density": 584.8,
    #     "median_age": 41.2,
    #     "aged_65_older": 13.085,
    #     "aged_70_older": 7.452,
    #     "gdp_per_capita": 35973.781,
    #     "diabetes_prevalence": 11.62,
    #     "life_expectancy": 76.29,
    #
    # data:
    #     "date": "2020-03-19",
    #     "new_cases_smoothed": 0.286,
    #     "new_deaths_smoothed": 0.0,
    #     "new_cases_smoothed_per_million": 2.676,
    #     "new_deaths_smoothed_per_million": 0.0,
    #     "stringency_index": 33.33

  end

  DATA_DEATHS_7D = "#{PATH}/data/europe.json"

  def self.all
    data = JSON.parse File.read DATA_DEATHS_7D
    data.insert 0, ['Country', '# of deaths - 7 days']
  end

end

STATS = Stats.all
