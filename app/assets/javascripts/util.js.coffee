class Util
  
  # Stolen here http://learningthreejs.com/data/THREEx/THREEx.WindowResize.js
  watchWindowResize: (renderer, camera)->
    callback = () ->
      
      renderer.setSize( window.innerWidth, window.innerHeight )
      camera.aspect = window.innerWidth / window.innerHeight
      camera.updateProjectionMatrix()

    window.addEventListener('resize', callback, false)

    return {
      stop: () ->
        window.removeEventListener('resize', callback)
    }

window.utils = new Util()