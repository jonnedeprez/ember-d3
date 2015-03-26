`import Ember from 'ember'`

MapController = Ember.Controller.extend(
  selectedBezirk: ''
  hasSelectedBezirk: Em.computed.notEmpty('selectedBezirk')
)

`export default MapController`
