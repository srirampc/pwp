# Personal Web Page for Sriram P C 

This is the source code of Sriram P C's [web
page](http://srirampc.net).  It is built using the
[nanoc](http://nanoc.stoneship.org/) with
[nanoc_blog](https://github.com/mgutz/nanoc3_blog) as the starting
point.

# Dependencies/Installation to build using nanoc

1. Install ruby 4.0.3 with rvm/rbenv (Currently tested with `rbenv`)

2. Install node.js, npm and coffeescript/coffee-script (With Ubuntu, one can do `apt-get install`)

3. Install python-pygments: pip install Pygments (apt-get works here too!)

4. Install the gems in Gemfile that required to compile (`bundle update` should work!)

5. Compile command

    bundle exec nanoc compile

6. To view, run web server as

    bundle exec nanoc view 
