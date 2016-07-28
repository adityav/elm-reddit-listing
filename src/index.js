// pull in desired CSS/SASS files
require( './styles/main.scss' );
var jsonp = require('jsonp');

function isElementInViewport (el) {
    //special bonus for those using jQuery
    if (typeof jQuery === "function" && el instanceof jQuery) {
        el = el[0];
    }

    var rect = el.getBoundingClientRect();

    return (
        rect.top >= 0 &&
        rect.left >= 0 &&
        rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) && /*or $(window).height() */
        rect.right <= (window.innerWidth || document.documentElement.clientWidth) /*or $(window).width() */
    );
}


// inject bundled Elm app into div#main
var Elm = require( './Main' );
var app = Elm.Main.embed( document.getElementById( 'main' ) );

//
// jsonp integration
//
app.ports.fetchJsonP.subscribe(function(url) {
    jsonp(url, {
        param : 'jsonp'
    },function(err, data) {
        if(err) {
            return app.ports.fetchJsonPFail.send(err);
        }
        app.ports.fetchJsonPSucceed.send(data);
    });
});

///
/// Check for last element visiblity
///
app.ports.isLastElemVisible.subscribe(function(divId) {
    console.log("Setting up listener for last item with Id:", divId);
    // scroll stop
    window.onscroll = function () {
      var wrapper = document.getElementById(divId);
      var lastItem = wrapper.childNodes[wrapper.childNodes.length - 1];
      // app.ports.lastItemVisible.send(false);
      if (isElementInViewport(lastItem)) {
        app.ports.lastItemVisible.send(true);
        // remove handler
        window.onscroll = null;
      } else {
        // app.ports.lastItemVisible.send(false);
      }
    };

});
