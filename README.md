# Personal Web Page for Sriram P C 

This is the source code of Sriram P C's [web
page](http://www.cse.iitb.ac.in/~srirampc).  It is built using the
[nanoc](http://nanoc.stoneship.org/) with
[nanoc_blog](https://github.com/mgutz/nanoc3_blog) as the starting
point.

# Dependencies/Installation to build using nanoc

1. Install ruby 1.9.2 with rvm

2. Install node.js, npm and coffee-script (With Ubuntu, one can do apt-get install)

3. Install python-pygments (apt-get works here too!)

4. Following gems are required to compile (bundle gems update should work!)

    gem update --system
    gem install nanoc
    gem install compass
    gem install coffee-script
    gem install builder
    gem install compass-susy-plugin
    gem install haml
    gem install rdiscount maruku bluecloth
    gem install adsf
    gem install systemu

5. Compile command

    nanoc compile

6. To view, run web server as

    nanoc view 
