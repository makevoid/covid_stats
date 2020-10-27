

const drawRegionsMap = () => {
  // window.data_7d_deaths.prepend['Country', '# of deaths - 7 days']
  const data = google.visualization.arrayToDataTable(
    window.data_7d_deaths
  )

  const options = {
    region: '150',
    colorAxis: { colors: ["orange"] },
  }
  const chartElem = document.querySelector('.regions_div')
  const chart = new google.visualization.GeoChart(chartElem)

  chart.draw(data, options)
}


window.addEventListener('DOMContentLoaded', (event) => {
  google.charts.load('current', {
    'packages': ['geochart'],
    'mapsApiKey': 'AIzaSyBmkSJKJhWnSJNVHS33kocZy6YC8pVJJCk'
  })
  google.charts.setOnLoadCallback(drawRegionsMap)
})
