import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Html.Events exposing ( onClick )
import Http
import Task
import Debug
import TimeTravel.Html.App as TimeTravel
import Json.Decode exposing (decodeValue)

-- components
import Components.RedditWidget as RedditWidget 

-- models
import Models exposing (..)
import Decoders
-- views
import Views exposing (..)

-- msgs
import Msgs exposing (..)

-- port
import AppPorts


-- APP
main =
  TimeTravel.program 
  --App.program
  { view = view
  , update = update
  , init = init
  , subscriptions = subscriptions}



-- INIT
init : (Model, Cmd Msg)
init =
    (Model emptyListing Nothing True, RedditWidget.loadRedditLinks)

-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Noop -> 
      (model, Cmd.none)

    FetchStarted url ->
      { model | isLoading = True } ! []

    RedditFetchSucceed redditData ->

      { model |
        redditListing = appendListing model.redditListing redditData,
        isLoading = False } ! [ AppPorts.isLastElemVisible "reddit-listing" ]

    RedditFetchFail err ->

      ({ model |
        fetchError = Just (Debug.log "Network Error" err),
        isLoading = False }, Cmd.none)

    LastItemVisible isVisible ->
      if isVisible then 
        ({ model | isLoading = True }, RedditWidget.loadMoreRedditLinks model.redditListing.after)
      else 
        (model, Cmd.none)



-- Subscriptions
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
  [ AppPorts.lastItemVisible LastItemVisible,
    -- process jsonp Succeed messages.
    -- here we are decoding the data and if it fails, returning an empty list
    AppPorts.fetchJsonPSucceed 
    <| decodeValue Decoders.decodeNews
    >> Result.map RedditFetchSucceed
    -->> (\r -> Debug.log "resultant" r)
    >> (Result.withDefault <| RedditFetchSucceed emptyListing)
  ]

