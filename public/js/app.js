// env config - TODO: extract environment config

const mapsApiKey = 'AIzaSyBmkSJKJhWnSJNVHS33kocZy6YC8pVJJCk'

// app config - TODO: extract app config

const chartsBaseConfig = {
  'packages': ['geochart'],
  'mapsApiKey': mapsApiKey,
}

const chartOptions = {
  colorAxis: { colors: ["orange"] },
}

const regions = {
  all: '001',
  europe: '150',
  usa: '003',
  asia: '142',
  south_america: '419', // latin america + caribbean
  australia: '053',
}

const drawMap = (mapRegion) =>
  () => {
    const chartSelector = '.regions_chart'
    const dataSource = window.data_7d_deaths
    const data = google.visualization.arrayToDataTable(dataSource)
    const chartElem = document.querySelector(chartSelector)
    const chart = new google.visualization.GeoChart(chartElem)
    const customOptions = { region: mapRegion }
    const options = Object.assign(customOptions, chartOptions)
    chart.draw(data, options)
  }


const pageLoaded = (event) => {
  const customConfig = {}
  let chartsConfig = chartsBaseConfig
  chartsConfig = Object.assign(customConfig, chartsConfig)
  google.charts.load('current', chartsConfig)
  // const mapRegion = regions.europe
  const mapRegion = regions.australia
  google.charts.setOnLoadCallback(drawMap(mapRegion))
}

window.addEventListener('DOMContentLoaded', pageLoaded)

// const drawRegionMap = (regionName) => {
//
// }
