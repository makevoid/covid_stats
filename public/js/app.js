google.charts.load('current', {
  'packages':['geochart'],
  // Note: you will need to get a mapsApiKey for your project.
  // See: https://developers.google.com/chart/interactive/docs/basic_load_libs#load-settings
  'mapsApiKey': 'AIzaSyD-9tSrke72PouQMnMX-a7eZSW0jkFMBWY'
})
google.charts.setOnLoadCallback(drawRegionsMap)

function drawRegionsMap() {
  // window.data_7d_deaths.prepend['Country', '# of deaths - 7 days']
  const data = google.visualization.arrayToDataTable(
    window.data_7d_deaths
  )

  const options = {
    region: '150',
  }
  const chartElem = document.querySelector('#regions_div')
  const chart = new google.visualization.GeoChart(chartElem)

  chart.draw(data, options)
}
