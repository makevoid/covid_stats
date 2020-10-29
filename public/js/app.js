// env config - TODO: extract environment config

const mapsApiKey = 'AIzaSyBmkSJKJhWnSJNVHS33kocZy6YC8pVJJCk'

// app config - TODO: extract app config

const chartsBaseConfig = {
  'packages': ['geochart'],
  'mapsApiKey': mapsApiKey,
}

const chartOptions = {
  region: '150',
  colorAxis: { colors: ["orange"] },
}

const drawMap = () => {
  const chartSelector = '.regions_chart'
  const dataSource = window.data_7d_deaths
  const data = google.visualization.arrayToDataTable(dataSource)
  const chartElem = document.querySelector(chartSelector)
  const chart = new google.visualization.GeoChart(chartElem)
  chart.draw(data, chartOptions)
}

const pageLoaded = (event) => {
  const customConfig = {}
  let chartsConfig = chartsBaseConfig
  chartsConfig = Object.assign(customConfig, chartsConfig)
  google.charts.load('current', chartsConfig)
  google.charts.setOnLoadCallback(drawMap)
}

window.addEventListener('DOMContentLoaded', pageLoaded)

// const drawRegionMap = (regionName) => {
//
// }
