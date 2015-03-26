`import Ember from 'ember'`

BarChartComponent = Ember.Component.extend(
  tagName: 'svg'
  xmlns: 'http://www.w3.org/2000/svg'
  width: 800
  height: 400
  attributeBindings: ['xmlns', 'width', 'height']

  svg: (->
    id = @.$().get(0).id
    d3.select("##{id}")
  ).property()

  xScale: (-> d3.scale.ordinal().rangeRoundBands([0, @get 'width'], 0.1)).property()
  yScale: (-> d3.scale.linear().range([0, @get('height')])).property()
  xAxis: (-> d3.svg.axis().scale(@get('xScale')).orient("bottom")).property()

  chartDataUpdated: (->
    barsContainer = @get('barsContainer')
    data = @get 'chartData' || []
    yScale = @get 'yScale'
    yScale.domain([0, d3.max(@get('chartData'))])
    xScale = @get 'xScale'
    xScale.domain(d3.range(data.length))

    height = @get 'height'

    selection = barsContainer.selectAll('.bar').data(data)

    selection.enter().append('rect')
    .attr('class', 'bar')
    .attr('height', (d) -> yScale(d))
    .attr('transform', (d, i) -> "translate(#{xScale(i)}, #{height - yScale(d)})")
    .attr('width', xScale.rangeBand())
    .style('fill', 'red')

    selection
    .attr('height', (d) -> yScale(d))
    .attr('transform', (d, i) -> "translate(#{xScale(i)}, #{height - yScale(d)})")
    .attr('width', xScale.rangeBand())

    selection.exit().remove()

    xAxis = @get('xAxis')

    barsContainer.select('.x.axis')
    .attr("transform", "translate(0,#{height})")
    .call(xAxis)

  ).observes('chartData.[]').on('didInsertElement')

  barsContainer: (->
    @get('svg').append('g').attr('class', '.bars')
  ).property()



)

`export default BarChartComponent`
