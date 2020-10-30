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

// note: see https://developers.google.com/chart/interactive/docs/gallery/geochart#continent-hierarchy-and-codes
const regions = {
  all: '001',
  europe: '150',
  north_america: '021',
  asia: '142',
  south_america: '005',
  australia: '053',
}

const drawMap = (regionName) =>
  () => {
    const mapRegion = regions[regionName]
    const chartSelector = '.region_chart'
    const dataSource = window[`data_7d_deaths_${regionName}`]
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
  const locationPath = window.location.pathname.split("/")
  const regionName = locationPath[2] || "europe"
  google.charts.setOnLoadCallback(drawMap(regionName))
}

window.addEventListener('DOMContentLoaded', pageLoaded)

// const drawRegionMap = (regionName) => {
//
// }
