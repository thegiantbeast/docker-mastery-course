# Assignment: Bind Mounts

* use a jekyll "static site generator" to start a local web server
* edit files on host using native tools
* container detects changes with host files and updates web server
* start container with `docker run -p 80:4000 -v $(pwd):/site bretfisher/jekyll-serve`
* fetch post url
* change file in `_posts/` and fetch the url to see changes