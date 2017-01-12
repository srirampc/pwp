# Personal Web Page for Sriram P C 

This is the source code of Sriram P C's [web
page](http://srirampc.net).  It is built using the
[nanoc](http://nanoc.stoneship.org/) with
[nanoc_blog](https://github.com/mgutz/nanoc3_blog) as the starting
point.

# Dependencies/Installation to build using nanoc

1. Install ruby 2.4 with rvm

2. Install node.js, npm and coffee-script (With Ubuntu, one can do apt-get install)

3. Install python-pygments (apt-get works here too!)

4. Following gems are required to compile (bundle gems update should work!)

    activesupport
    adsf
    builder
    coffee-script
    compass
    compass-colors
    compass-susy-plugin
    cri
    haml
    i18n
    mime-types
    nanoc
    nokogiri
    org-ruby
    rack
    rake
    rdiscount
    rubypants
    systemu

5. Compile command

    bundle exec nanoc compile

6. To view, run web server as

    bundle exec nanoc view 
