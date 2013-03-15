class Aagnud

  init: (scene) ->
    
    @geometry = new THREE.SphereGeometry( 20, 20, 20)

    @material = new THREE.MeshLambertMaterial( { color: 0xffffff, wireframe: false } )

    @mesh = new THREE.Mesh( @geometry, @material )

    x = -500+Math.random()*1000
    y = -500+Math.random()*1000
    z = -500+Math.random()*1000

    @mesh.position.set(x,y,z)
  
    @direction = new THREE.Vector3( Math.random()-0.5, Math.random()-0.5, Math.random()-0.5 )
    @speed = 10+Math.random()*300

    scene.add( @mesh )
    
    ctx = window.sounds.context

    @osc = ctx.createOscillator()
    @osc.type = 0
    @osc.frequency = 440
    @osc.noteOn(0)

    @osc2 = ctx.createOscillator()
    @osc2.type = 1
    @osc2.frequency = 440
    @osc2.noteOn(0)

    @gainNode = ctx.createGainNode()
    @gainNode.gain.value = 0
    @osc2.connect(@gainNode)
    window.sounds.connectEffects(@gainNode)

  update: (scene, t, vid) ->
    
    if Math.abs(@mesh.position.x) > 1000
      @direction.x *= -1

    if Math.abs(@mesh.position.y) > 500
      @direction.y *= -1

    if Math.abs(@mesh.position.z) > 1000
      @direction.z *= -1
    
    @detectCollision(scene, vid)

    @move(t)

  detectCollision: (scene, vid)->

    if vid.inited

      dist = vid.faceball.position.distanceTo(@mesh.position) - (vid.geometry.radius + @geometry.radius)

      if dist < 0.1
        @direction.x = @direction.x*-1
        @direction.y = @direction.y*-1
        @direction.z = @direction.z*-1

        # Power pivot
        @mesh.position.x = @mesh.position.x + ((0.01+@direction.x)*200)
        @mesh.position.y = @mesh.position.y + ((0.01+@direction.y)*200)
        @mesh.position.z = @mesh.position.z + ((0.01+@direction.z)*200)

        @osc.frequency.value = 440 + vid.faceball.position.x
        @osc2.frequency.value = 440 + vid.faceball.position.x
        @gainNode.gain.value = 0.5

        @material.color.r = 1
        @material.color.g = 1
        @material.color.b = 1

        vid.material.color.r = 1
        vid.material.color.g = 1
        vid.material.color.b = 1
        
  move: (t) ->
    @mesh.position.x += @speed*@direction.x 
    @mesh.position.y += @speed*@direction.y
    @mesh.position.z += @speed*@direction.z
    
    if @gainNode.gain.value > 0
      @gainNode.gain.value = @gainNode.gain.value - 0.1

      if @gainNode.gain.value < 0
        @gainNode.gain.value = 0

    if @material.color.r > 0.05
      @material.color.r = @material.color.r - 0.05

    if @material.color.g > 0.05
      @material.color.g = @material.color.g - 0.05

    if @material.color.b > 0.05
      @material.color.b = @material.color.b - 0.05

window.Aagnud = Aagnud