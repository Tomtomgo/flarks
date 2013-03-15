class Vid

  currentFace: null 
  inited: false

  init: (scene) ->

    navigator.getUserMedia = navigator.webkitGetUserMedia
    options = video: true, toString: -> return "video"
    
    @video = $('#webcam_video')[0]
    @canvas = $('#webcam_canvas')[0]
    @context = @canvas.getContext('2d')
  
    navigator.getUserMedia(options, @startStreaming);
    
    @makeFace(scene)
  
  makeFace: (scene) ->

    @geometry = new THREE.SphereGeometry( 200, 20, 20)

    @texture = new THREE.Texture( @canvas )
    @texture.needsUpdate = true
    
    @material = new THREE.MeshBasicMaterial( { color: 0xffeeff, wireframe: false , map: @texture, transparent: true} )
    @faceball = new THREE.Mesh( @geometry, @material )
  
    scene.add( @faceball )

  startStreaming: (stream) =>
    if window.webkitURL and window.webkitURL.createObjectURL
      @video.src = window.webkitURL.createObjectURL(stream)
    else
      @video.src = stream

    @updateFrame()
    @updateFace()
    @inited = true

  updateFrame: () =>
    requestAnimationFrame(@updateFrame)
    @context.drawImage(@video, 0, 0, @canvas.width, @canvas.height)
    @texture.needsUpdate = true

    if @material.color.r > 0.2
      @material.color.r = @material.color.r - 0.1

    if @material.color.g > 0.2
      @material.color.g = @material.color.g - 0.1

    if @material.color.b > 0.2
      @material.color.b = @material.color.b - 0.1

  updateFace: () =>
    setTimeout(()=>
      requestAnimationFrame(@updateFace)
      f = ccv.detect_objects({canvas : (ccv.pre(@canvas)), cascade: cascade, interval: 2, min_neighbors: 1})
      if f.length>0
        @currentFace = f
      @drawFace()
    , 200)

  drawFace: (scene) =>
    
    if @currentFace
      @faceball.position.x = 500-(@currentFace[0].x * 10)
      @faceball.position.y = 500-(@currentFace[0].y * 10)

window.Vid = Vid