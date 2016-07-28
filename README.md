# Reddit listing viewer

A rather simple listing viewer for /r/elm. Made in a day to learn elm.


# elm highlights

* Infinite scrolling
* JSONP for fetching data
* Simple listing filters
* It is amazing how elm code that compiles works successfully in browser. This has resulted in spending more time writing actual code than refreshing the browser to check if it all works.

# Future work

* Ability to list any generic /r/* listing



# Issues faced while developing an Elm app

* elm html is dificult for designers. need to have the HTML template outside of elm. Mitigating this issue by moving all views to their own module.

* a simple beahaviour like click on a link to open a new url is impossible with ports as window.open isn't available anywhere. However ports are super simple to implement. I feel I might build a elm-common-ports libary for myself. (as native code can't be published on elm-package)
