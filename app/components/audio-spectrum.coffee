`import Ember from 'ember'`

AudioSpectrumComponent = Ember.Component.extend(
  tagName: 'svg'
  xmlns: 'http://www.w3.org/2000/svg'
  width: 800
  height: 400
  attributeBindings: ['xmlns', 'width', 'height']

  svg: (->
    id = @.$().get(0).id
    d3.select("##{id}")
  ).property()

  yScale: (->
    d3.scale.linear().range([0, @get('height')]).domain([0, 512])
  ).property('height')

  xScale: (->
    d3.scale.ordinal().rangeBands([0, @get('width')], 0.1).domain(d3.range(@get('analyser').frequencyBinCount))
  ).property('width')

  colorScale: (->
    d3.scale.linear().domain([0, @get('analyser').frequencyBinCount]).range(["green", "red"])
  ).property('height')

  spectrum: (->
    analyser = @get('analyser')
    spectrum = new Uint8Array(analyser.frequencyBinCount)
    analyser.getByteFrequencyData(spectrum)
    spectrum
  ).property().volatile()

  inserted: (->

    height = @get('height')

    svg = @get 'svg'

    xScale = @get('xScale')
    yScale = @get('yScale')

    colorScale = @get('colorScale')

    spectrum = @get('spectrum')

    svg.selectAll(".bar")
      .data(spectrum)
      .enter().append('rect')
        .attr('class', 'bar')
        .attr('fill', (d, i) -> colorScale(i))
        .attr('x', (d, i) -> xScale(i))
        .attr('width', xScale.rangeBand())
        .attr('y', (d) -> (height - yScale(d)) / 2)
        .attr('height', (d) -> yScale(d))

    bars = svg.selectAll(".bar")

    self = this

    step = (->
      spectrum = self.get('spectrum')
      d3.timer(step)
      bars.data(spectrum)
        .attr('y', (d) -> (height - yScale(d)) / 2)
        .attr('height', (d) -> yScale(d))
    )

    step()

  ).on('didInsertElement')

)

`export default AudioSpectrumComponent`
