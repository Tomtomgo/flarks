class Flarks

  constructor: () ->
    console.log('Crick')
    @initScene()

    window.sounds.init()
    @initVid()
    @initFamily(40)
    @animate()

  initVid: () ->
    @vid = new Vid()
    @vid.init(@scene)

  initFamily: (n) ->
    @family = new Family()
    @family.init(@scene, n)

  initScene: () ->

    @clock = new THREE.Clock()
    @clock.start()

    @camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 1, 10000 )
    @camera.position.z = 1000

    @scene = new THREE.Scene()

    @light1 = new THREE.PointLight( 0xaadd00, 1 )
    @light1.position.set( 500, 1000, 1500 )
    @scene.add( @light1 )

    @light2 = new THREE.PointLight( 0x11e0ee, 1 )
    @light2.position.set( -500, 0, 1500 )
    @scene.add( @light2 )

    @light3 = new THREE.PointLight( 0xff3333, 1 )
    @light3.position.set( 0, -1000, 1500 )
    @scene.add( @light3 )
    
    @renderer = new THREE.WebGLRenderer()
    @renderer.setSize( window.innerWidth, window.innerHeight )
    utils.watchWindowResize(@renderer, @camera)

    document.body.appendChild( @renderer.domElement )

  animate: () =>

    requestAnimationFrame( @animate )
    
    t = @clock.getElapsedTime()

    @family.update(@scene, t, @vid);

    @renderer.render( @scene, @camera )

  $(document).ready(->
    window.flarks = new Flarks()
  )