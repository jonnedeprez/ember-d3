`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend(location: config.locationType)
Router.map ->
  @route 'bars'
  @route 'spectrum'
  @route 'map'

`export default Router`
