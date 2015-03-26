`import Ember from 'ember'`

AudioService = Ember.Object.extend(

  audioContext: (->
    ctx = window.AudioContext || window.webkitAudioContext
    new ctx()
  ).property()

  analyser: (->
    context = @get('audioContext')
    analyser = context.createAnalyser()
    analyser.smoothingTimeConstant = 0.3
    analyser.fftSize = 64
    analyser
  ).property('audioContext')

  init: (->
    analyser = @get('analyser')
    speakers = @get('audioContext').destination
    analyser.connect(speakers)
  )
)

`export default AudioService`
