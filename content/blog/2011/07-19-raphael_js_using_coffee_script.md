---
created_at: 2011-07-19
excerpt: Vector drawing using the good parts of JavaScript
kind: article
publish: true
has_code: true
tags: [programming]
title: "Raphael.js using Coffee Script"
disqus: true
---

Beneath all the C-like syntax, there is an implementation of the
[Scheme][scheme] in Javascript. [CoffeeScript][coffee] is an
interesting language that provides a Python-like indentation syntax
for the Scheme in Javascript. In this post, I explain how I used
CoffeeScript with Raphael.js for a simple SVG animation. (*Update :*
When this was initially written, Raphael.js was at version
'1.5'. Raphael.js has had a major update since. I have to
update the article.) 

## Problem
<img style="margin: 0.5em auto 0.5em auto;float:right"
  src="/assets/images/3dhcube.png" alt="3D Hyper Cube"> 

In parallel computing, the _n_-dimensional hypercube is a
model used for a network of _n_ processors. The 
figure on the right shows  a 3-D hypercube. Each node, shown on the
figure by a circle, is a processor. The lines
connecting two nodes is an interconnection, through which two 
processors communicate with each other. The processors are numbered
from _0_ to _2 ** (n -1)_. A 3-D hypercube is made up
of two 2-D hypercubes. Two 2-D hypercubes, say _a_ and _b_, are
connected such that each processor of the hypercube _a_ is connected
to the corresponding processor of _b_. In other words, two processors
with the same id are connected. An _n_ dimensional hypercube is
constructed from two _n-1_ dimensional hypercube in a similar manner. 

Now, consider an algorithm, which runs on a hypercube as follows:

1. A processor at level _i_ can begin execution only after its
neighboring processors in level _i - 1_  have completed their execution.
2. All processors in level _i_ can execute in parallel.

For example, in the 3-D hypercube shown in the picture, processors
marked _001_, _010_ and _100_ can execute in parallel after processor
_000_ has finished its execution. Dynamic programming algorithms are
mapped directly onto hypercubes in such fashion.

Suppose we have 4 processors arranged in 2-D hypercube, and our
problem size is such that it requires a 3-D hypercube. How do we use
the 2-D hypercube to solve such a problem ? Since a
3-D hyper cube is made of two 2-D hypercubes, one way to solve
the problem is to schedule the execution of one hypercube after
another. For example, with the 3-D hypercube shown in the picture, we
can execute the jobs of four processors on top (all with middle digit
_0_) followed by those in the bottom (all with middle digit _1_). If
we were to follow this method, it would take _2 x 3 = 6_ steps. 

To reduce the number of steps, we can pipe-line the execution of
hypercubes. In pipe-lining, the processors at the same level are
executed in parallel. Again back to the example given in the picture,
we can consider all the processor with the first digit _0_ forming a
2-D hypercube, while the one with first digit _1_ forming another. We
can also see that after _000_ is done processing, _001_, _010_ of the
first 2-D hypercube and _100_ of the second 2-D hypercube can execute
in parallel. All the three can be executed because we have 4
processors arranged in a 2-D hypercube. Thus the execution of second
hypercube _overlays_ the execution the first one (though it lags a
bit). With the use of pipe-lining, it would only take 4 steps.  

My aim in this post is to make an animation on the browser that shows
this idea of pipe-lining hypercubes. This exercise is just an attempt
to use Raphael.js along with  CoffeeScript, while trying to learn both!

## Setup
For Unix-y systems the set-up is straight forward.

1. Download and build [node.js][nodejs].
2. Install [npm][npmjs]. If you are behind a proxy server (like me),
   this may be not straight forward. npm installer gets the
   source files necessary for npm's sub-modules from [github][github]
   using  _git://_ protocol. I tried to make git protocol work behind
   the proxy, but it just wouldn't. I, then, had to go and change the
   protocol in _.git/config_ file from 'git' to 'https'. If you have
   any suggestions for getting git protocol to work behind a proxy
   with authentication,please do comment. (Instructions given
   [here][gitproxy] doesn't work for me!) 
3. Install [Coffee-script][coffee].
4. Download [Raphael.js][rapheal].
5. Make an html file whose _body_ contains an empty _div_, that can be
   used by Rapheal to draw, and also other controls if necessary. I
   used the following: 
   <pre><code class="language-html">
&lt;script src='assets/js/raphael-min.js'&gt; &lt;/script&gt;
&lt;script src='assets/js/raphael-test.js'&gt; &lt;/script&gt;
&lt;div style="margin:0.5em auto;width:100%"&gt;
 &lt;a id="reset" class="widebutton"&gt;Click here to reset&lt;/a&gt;
&lt;/div&gt;
&lt;div id="canvas"&gt; &lt;/div&gt;
&lt;div style="margin:0.5em auto;width:100%"&gt;
   &lt;a id="run" class="widebutton"&gt;Click here to run&lt;/a&gt;
&lt;/div&gt;
</pre>
   Here, my coffe-script source file compiles to
   javascript at location _assets/js/raphael-test.js_ and
   Raphael.js source code is available at _assets/js/raphael-min.js_ - 
   relative to the html file. The _div_ with id _canvas_ will be 
   the parent for the SVG output.

For Windows, the setup is the same. The primary trouble is
getting CoffeScript to run in windows, but Mikhail Nasyrov's [excellent
instructions][windowscoffee] should fix any problems.

## Code 

The first part is to write a function that draws 2D Hypercube. The
code is shown below. Here, _paper_ is a _Raphael_ object constructed
on top of the _canvas_ we defined in the previous section.  _hoffset_
and _voffset_ determine how high and wide the 2D hypercube should be.
Four circles are drawn on the canvas using 
_circle_ function of _Raphael_ object. The centers of the circles 
are calculated such that the 2D Hypercube looks like a plane hanging in
3-D space.

<pre><code class="language-coffeescript">
make2DHC = (paper, cx, cy, hoffset, voffset, clr) ->
    hc = []
    hc[0] = paper.circle cx, cy, 30
    hc[1] = paper.circle cx - hoffset,
               cy + hoffset * Math.tan(Math.PI / 6), 30
    hc[2] = paper.circle cx, cy + voffset, 30
    hc[3] = paper.circle cx-hoffset,
               cy + voffset + hoffset * Math.tan(Math.PI / 6), 30
    # Fill the circles
    c.attr {fill:clr} for c in  hc
    # Connect the nodes
    intraPaths = (
        connectCircles paper,hc[p[0]],hc[p[1]],clr for p in [[0,1],
            [0,2],[1,3],[2,3]] )
    # return the nodes and paths
    hc.concat intraPaths
</code></pre>


Using _make2DHC_, we can a build a 3D hypercube by constructing two 2D
hypercubes, and adding paths between the circles of the two
hypercubes. To aid animation, I draw circles of radius zero on top the
nodes. The code for building 3D Hypercube is shown below.

<pre><code class="language-coffeescript">
build3DHC = () ->
    # make 2 2D hyper cube
    redhc = make2DHC paper, xorig, yorig,
        hcwidth, hcheight, 'red'
    bluehc = make2DHC paper, xorig + hcwidth,
        yorig + hcheight, hcwidth, hcheight, 'blue'
    # build the paths between two 2D hyper cubes
    interPaths = (connectCircles paper,redhc[i], bluehc[i] for i in [0..3])
    # circles for animation initially set with radius 0
    animRedHC = (c.clone().attr {r:"0"} for c in redhc[0..3])
    animBlueHC = (c.clone().attr {r:"0"} for c in bluehc[0..3])
</code></pre>

After having completed the circles, animation is filling the empty
circles at different time points (as shown below).

<pre><code class="language-coffeescript">
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
</code></pre>

Complete source code of the coffee-scrip is available [here][coffeesrc].

## Output

<script src='/assets/js/raphael-min.js'></script>
<script src='/assets/js/raphael-test.js'></script>
<div style="margin:0.5em auto;width:100%">
 <a id="reset" class="widebutton">Click here to reset</a>
</div>
<div id="canvas"></div>
<div style="margin: 0.5em auto 1.5em auto;width:100%"><a id="run"
class="widebutton">Click here to run</a></div>

# Lessons Learned 
1. This probably is a wrong application of Raphael.js. Processing.js,
   I think, might be probably the right tool for the job here. I don't
   have any experience with Processing.js.
2. I still think [tikz][tikz] has a much better and cleaner 
   interface for a drawing library. If there is any Javascript drawing
   library with an interface similar to tikz, it would be great.
3. CoffeeScript is very picky on how your code should spread across
   multiple lines. The rules for multi-line statements are not
   in the documentation. For example, all of the following three
   comprehensions are incorrect Coffee-Script for the same reason :
   The line break is in the wrong place. 
          intraPaths = (connectCircles paper,hc[p[0]],
              hc[p[1]],clr for p in [[0,1],[0,2],[1,3],[2,3]])

          intraPaths = (connectCircles paper,hc[p[0]],hc[p[1]],clr
              for p in [[0,1],[0,2],[1,3],[2,3]])

          intraPaths = (connectCircles paper,hc[p[0]],hc[p[1]],clr for p in
              [[0,1],[0,2],[1,3],[2,3]])
   My suggestion is that, when in doubt use
   [Try CoffeeScript][trycoffee]. Still, CoffeeScript is a better
   alternative for Javascript. I certainly would use CoffeeScript instead of
   Javascript in the future.

# Exercise for the reader
There many things to improve here. Two I can think of are:

1. It doesn't look good that the inter-connections between the red and
   blue circles cross the boundaries. Connections should stop at the
   boundaries.
2. The animation is done using javascript setTimeout method.  One
   can hijack the animation sequence by clicking Reset link right in
   the middle of animation. I think a better way to animate is to use 
   keyframes. Of course, one can disable the 'Reset' link, when the
   animation is going on.

[nodejs]: http://www.nodejs.org
[coffee]: http://jashkenas.github.com/coffee-script
[npmjs]: http://www.npmjs.org
[github]: http://github.com
[rapheal]: http://raphaeljs.com/
[windowscoffee]: http://blog.mnasyrov.com/post/2872046541/coffeescript-on-windows-how-to-roast-coffee
[coffeesrc]: /assets/coffee/raphael-test.coffee
[gitproxy]: http://stackoverflow.com/questions/128035/how-do-i-pull-from-a-git-repository-through-an-http-proxy
[scheme]: http://en.wikipedia.org/wiki/Scheme_%28programming_language%29
[tikz]: http://en.wikipedia.org/wiki/PGF/TikZ
[trycoffee]: http://jashkenas.github.com/coffee-script/#try:alert%20%22Hello%20CoffeeScript!%22
