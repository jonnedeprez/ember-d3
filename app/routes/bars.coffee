`import Ember from 'ember'`

BarsRoute = Ember.Route.extend(
  model: -> [200, 100, 350, 500, 420]
)

`export default BarsRoute`
