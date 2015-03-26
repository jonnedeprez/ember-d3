`import Ember from 'ember'`

StreamingAudioSourceComponent = Ember.Component.extend(

  #  targetHandle: null

  inserted: (->
    self = @
    targetHandle = self.get('targetHandle')
    unless !!targetHandle
      Em.debug 'No target for sound output given!'
      return

    audioElement = @.$('audio').get(0)

    context = @get('audioContext')
    audioElement.addEventListener('canplay', ->
      source = context.createMediaElementSource(audioElement)
      self.set('source', source)

      source.connect(targetHandle)
    )
  ).on('didInsertElement')

  sourceChanged: (->
    source = @get('source')
    targetHandle = @get('targetHandle')
    source.connect(targetHandle) if !!source and !!targetHandle
  ).observes('source')
)

`export default StreamingAudioSourceComponent`
