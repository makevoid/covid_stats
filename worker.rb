WorkerState = {
  last_update: nil,
}

TIMESTAMP_URL = "#{API_ENDPOINT}/owid-covid-data-last-updated-timestamp.txt"

FetchTimestamp = -> {
  begin
    resp = Net::HTTP.get_response URI TIMESTAMP_URL
  rescue Timeout::Error, Errno::ECONNRESET, EOFError, Errno::EHOSTUNREACH, Errno::ECONNREFUSED,
         Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => err
    puts "Got NET:HTTP Error: #{err.inspect} - #{err.message}"
  end

  resp && resp.body
}

NewDataAvailable = -> {
  data = FetchTimestamp.()
  if data && data != WorkerState[:last_update]
    WorkerState[:last_update] = data
    true
  end
}

LoadNewData = -> {
  Tasks::StatsDL.()
  Tasks::AllTransforms.()
  Stats.data = Stats.load_data
  Stats.data_timestamp = Stats.get_data_timestamp
}

OneHour = 3600 # seconds

Thread.abort_on_exception = true

Worker = -> {
  Thread.new do
    sleep 5
    loop do
      puts "Worker is running..."
      LoadNewData.() if NewDataAvailable.()
      sleep OneHour
    end
  end
}

Worker.()
