module Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Keyed as HtmlK
import Html.App as App
import Html.Events exposing ( onClick )


-- components
import Components.RedditWidget as RedditWidget 

-- models
import Models exposing (..)

-- mosgs
import Msgs exposing (..)

keyedDiv = HtmlK.node "div"


-- VIEW

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

bodyTmpl : Model -> Html Msg
bodyTmpl model =
  keyedDiv [ id "reddit-listing", class "container" ] 
    (List.map (\data -> (data.id, RedditWidget.view data)) model.redditListing.data)

loadingTmpl : Bool -> Html Msg
loadingTmpl isLoading =
  if isLoading then
    div [ class "row" ][
      img [src "img/ripple.svg", class "img-responsive center-block"] []
    ]
  else span [] []

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
