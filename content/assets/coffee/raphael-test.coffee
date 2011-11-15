
getCenterStr = (c) ->
    c.attr("cx") + ' ' + c.attr("cy")

connectCircles = (paper,c1,c2,clr = "#000") ->
    # Connect the circles c1 and c2 with a path of color clr
    l = paper.path 'M' + getCenterStr(c1) +
          'L' +  getCenterStr(c2)
    l.attr {stroke:clr}
    l

make2DHC = (paper,cx,cy,hoffset,voffset,clr) ->
    hc = []
    # First, I used Raphael's translate and rotate function, but
    #  I couldn't then get the circle's center co-ords easily.
    #  (Use of BBox also didn't help).
    #  Hence, I am doing the math by hand.
    hc[0] = paper.circle cx, cy, 30
    hc[1] = paper.circle cx - hoffset,
               cy + hoffset * Math.tan(Math.PI / 6), 30
    hc[2] = paper.circle cx, cy + voffset, 30
    hc[3] = paper.circle cx-hoffset,
               cy + voffset + hoffset * Math.tan(Math.PI / 6), 30
    c.attr {fill:clr} for c in  hc
    intraPaths = (
        connectCircles paper,hc[p[0]],hc[p[1]],clr for p in [[0,1],
            [0,2],[1,3],[2,3]] )
    hc.concat intraPaths

window.onload = () ->
    btn = document.getElementById("run")
    resetbtn = document.getElementById("reset")
    paper = Raphael "canvas", 640, 480
    xorig = 320
    yorig = 60
    hcwidth = 200
    hcheight = hcwidth * Math.tan(Math.PI/6)
    redhc = bluehc = interPaths = animRedHC = animBlueHC = []
    build3DHC = () ->
        # make 2 2D hyper cube
        redhc = make2DHC paper, xorig, yorig,
            hcwidth, hcheight, 'red'
        bluehc = make2DHC paper, xorig + hcwidth,
            yorig + hcheight, hcwidth, hcheight, 'blue'
        # build the paths between two 2D hyper cubes
        interPaths = (connectCircles paper,redhc[i], bluehc[i] for i in [0..3])
        # circles for animation
        animRedHC = (c.clone().attr {r:"0"} for c in redhc[0..3])
        animBlueHC = (c.clone().attr {r:"0"} for c in bluehc[0..3])
    build3DHC()
    resetbtn.onclick = () ->
        try
            paper.clear()
            build3DHC()
        catch e
            alert e.message || e
    btn.onclick = () ->
        try
            t = {fill:"#33CC33", r:"30"}
            animRedHC[0].animate t, 2000
            setTimeout (() ->
                c.animate t, 2000 for c in [animRedHC[1],animRedHC[2],
                    animBlueHC[0]]
                1), 3000
            setTimeout (() ->
                c.animate t, 2000 for c in [animRedHC[3],animBlueHC[1],
                    animBlueHC[2]]
                1), 6000
            setTimeout (() ->
                animBlueHC[3].animate t,2000
                1), 9000
        catch e
            alert e.message || e


