`import Ember from 'ember'`

BerlinMapComponent = Ember.Component.extend(
  tagName: 'svg'
  xmlns: 'http://www.w3.org/2000/svg'
  classNames: 'berlin-map'
  width: 700
  height: 500
  attributeBindings: ['xmlns', 'width', 'height']

  svg: (->
    id = @.$().get(0).id
    d3.select("##{id}")
  ).property()

  inserted: (->
    svg = @get('svg')
    self = this
    d3.json('berlin.topojson', (error, berlin) ->

      projection = d3.geo.path().projection(d3.geo.mercator().center([13.605, 52.5200]).scale(45000))

      svg.selectAll('.bezirk')
      .data(topojson.feature(berlin, berlin.objects.collection).features)
      .enter().append('path')
      .attr('class', "bezirk")
      .attr('d', projection)
      .on('click', (d) -> self.set('selection', d.properties.name) )


    )
  ).on('didInsertElement')
)

`export default BerlinMapComponent`
