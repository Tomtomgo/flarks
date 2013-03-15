class Family

  aagnuds: []

  init: (scene, n) ->
        
    for i in [0..n-1]
      @aagnuds[i] = new Aagnud()
      @aagnuds[i].init(scene)

  update: (scene, t, vid) ->
    
    for i in [0..@aagnuds.length-1]
      @aagnuds[i].update(scene, t, vid)

window.Family = Family