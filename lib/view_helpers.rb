module ViewHelpers
  # def labelize(string)
  #   Inflecto.humanize(Inflecto.underscore(string.to_s)).capitalize
  # end

  def titleize(string)
    string.to_s.capitalize.gsub /_/, " "
  end
end
