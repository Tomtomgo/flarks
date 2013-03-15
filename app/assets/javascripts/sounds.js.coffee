class Sounds

  init: () ->
    @context = new webkitAudioContext()
    @tuna = new Tuna(@context)

  connectEffects: (source) ->

    @delay = new @tuna.Delay(
                    feedback: 0.5,
                    delayTime: 250,
                    wetLevel: 0.5,
                    dryLevel: 0.5
            )

    @chorus = new @tuna.Chorus(
                  feedback: 0.5
                  delay: 0.1
                  rate: 0.75
                )

    source.connect(@chorus.input)
    @chorus.connect(@delay.input)
    @delay.connect(@context.destination)

window.sounds = new Sounds()