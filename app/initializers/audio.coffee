# Takes two parameters: container and app
initialize = (container, application) ->
  application.register('service:audio', 'audioService')
  application.inject('controller', 'audio', 'service:audio')

# app.register 'route', 'foo', 'service:foo'

AudioInitializer =
  name: 'audio'
  initialize: initialize

`export {initialize}`
`export default AudioInitializer`
