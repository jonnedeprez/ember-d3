`import Ember from 'ember'`

BarsController = Ember.ArrayController.extend(
  actions:
    addRandomNumber: -> @get('model').pushObject(Math.round(Math.random()*1000))
)

`export default BarsController`
