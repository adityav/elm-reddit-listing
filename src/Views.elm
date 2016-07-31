module Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Keyed as HtmlK
import Html.App as App
import Html.Events exposing ( onClick, onInput )
import String


-- components
import Components.RedditWidget as RedditWidget 

-- models
import Models exposing (..)

-- mosgs
import Msgs exposing (..)

keyedDiv = HtmlK.node "div"


-- VIEW

-- Top level view
view : Model -> Html Msg
view model =
  div []
  [ headerTmpl model
  , bodyTmpl model
  , loadingTmpl model.isLoading
  , footerTmpl model
  ]

headerTmpl : Model -> Html Msg
headerTmpl model =
  div [ class "container", style styles.header ]
  [ div [ class "row" ]
    [ div [ class "jumbotron" ]
      [ p [] [ text "elm-community"]
      ]
    ]
  ]

-- reddit listing. We use keyedDiv to optimize add/removals
bodyTmpl : Model -> Html Msg
bodyTmpl model =
  div [ class "container" ][
    searchBoxTmpl model,
    keyedDiv [ id "reddit-listing", class "container" ] 
      (List.map (\data -> (data.id, RedditWidget.view data)) <| filterListing model.filterString model.redditListing.data)
  ]

filterListing filterString listing = 
  List.filter (\data -> String.contains filterString data.title) listing


searchBoxTmpl : Model -> Html Msg
searchBoxTmpl model =
  div [ class "form-group"][
    label [ for "search-box" ] [ text "search text" ],
    input [ id "search-box", class "form-control", placeholder "enter search text to filter data", onInput SetFilter] [
    ]
  ]

-- loading div when more data is being loaded
loadingTmpl : Bool -> Html Msg
loadingTmpl isLoading =
  if isLoading then
    div [ class "row" ][
      img [src "img/ripple.svg", class "img-responsive center-block"] []
    ]
  else span [] []

-- footer. never to be seen :{}
footerTmpl : Model -> Html Msg
footerTmpl model =
  div [ class "container", style styles.header ]
  [ div [ class "row" ]
    [ div [ class "jumbotron" ]
      [ samp [] [ text "elm-community"]
      ]
    ]
  ]


-- CSS STYLES
styles =
  {
    header =
      [ ("margin-top", "20px")
      , ( "text-align", "center" )
      ],
    img =
      [ ( "width", "33%" )
      , ( "border", "4px solid #337AB7")
      ]
  }
